import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/domain/entities/helper_chat_message_entity.dart';

abstract class HelperChatRemoteDataSource {
  Future<Either<Failure, String>> sendMessage({
    required String message,
    required List<HelperChatMessageEntity> history,
  });
}

class HelperChatRemoteDataSourceImpl implements HelperChatRemoteDataSource {
  static const String _defaultBaseUrl = 'https://router.huggingface.co/v1';
  static const List<String> _defaultModels = [
    'mistralai/Mistral-Nemo-Instruct-2407',
    'Qwen/Qwen2.5-7B-Instruct',
  ];
  static const String _defaultHfToken = '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';

  final Dio _dio;
  final List<String> _models;
  final String _hfToken;

  HelperChatRemoteDataSourceImpl({
    Dio? dio,
    List<String>? models,
    String? token,
    String baseUrl = _defaultBaseUrl,
  }) : _models = models ?? _defaultModels,
       _hfToken = (token ?? _defaultHfToken).trim(),
       _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl,
               connectTimeout: const Duration(seconds: 30),
               receiveTimeout: const Duration(seconds: 60),
               headers: {'Content-Type': 'application/json'},
             ),
           );

  static const String _systemPrompt =
      'You are a tourism assistant specialized in Egypt travel. '
      'Answer in a practical, concise, and friendly way. '
      'Focus on destinations, itineraries, transportation, local costs, '
      'safety tips, and opening hours.';

  String _cleanModelText(String text) {
    var cleaned = text;
    cleaned = cleaned.replaceAll(
      RegExp(r'\[/?INST\]', caseSensitive: false),
      '',
    );
    cleaned = cleaned.replaceAll(
      RegExp(r'\[/?ASS\]', caseSensitive: false),
      '',
    );
    cleaned = cleaned.replaceAll(
      RegExp(r'\[/?SYSTEM\]', caseSensitive: false),
      '',
    );
    cleaned = cleaned.replaceAll(RegExp(r'\s+'), ' ').trim();
    return cleaned;
  }

  bool _isCorruptedReply(String text) {
    if (text.isEmpty) {
      return true;
    }
    final lower = text.toLowerCase();
    if (lower.contains('[inst]') ||
        lower.contains('[/inst]') ||
        lower.contains('[ass]') ||
        lower.contains('[/ass]')) {
      return true;
    }
    final lines = text
        .split(RegExp(r'[\n\r]+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    if (lines.length >= 4) {
      final unique = lines.toSet().length;
      if (unique <= 2) {
        return true;
      }
    }
    return false;
  }

  String? _extractAssistantContent(dynamic data) {
    if (data is! Map<String, dynamic>) {
      return null;
    }
    final choices = data['choices'];
    if (choices is! List || choices.isEmpty) {
      return null;
    }
    final first = choices.first;
    if (first is! Map<String, dynamic>) {
      return null;
    }
    final assistantMessage = first['message'];
    if (assistantMessage is! Map<String, dynamic>) {
      return null;
    }
    return (assistantMessage['content'] ?? '').toString().trim();
  }

  String? _extractErrorMessage(dynamic data) {
    if (data is! Map<String, dynamic>) {
      return null;
    }

    final error = data['error'];
    if (error is Map<String, dynamic>) {
      final msg = (error['message'] ?? '').toString().trim();
      if (msg.isNotEmpty) {
        return msg;
      }
    }

    final msg = (data['message'] ?? '').toString().trim();
    if (msg.isNotEmpty) {
      return msg;
    }
    return null;
  }

  @override
  Future<Either<Failure, String>> sendMessage({
    required String message,
    required List<HelperChatMessageEntity> history,
  }) async {
    if (_hfToken.isEmpty) {
      return const Left(
        Failure(
          'Chatbot is not configured. Run with --dart-define=HF_TOKEN=YOUR_TOKEN.',
        ),
      );
    }

    final conversation = <Map<String, String>>[
      {'role': 'system', 'content': _systemPrompt},
      ...history
          .where((item) => item.text.trim().isNotEmpty)
          .take(12)
          .map(
            (item) => {
              'role': item.isFromUser ? 'user' : 'assistant',
              'content': item.text.trim(),
            },
          ),
      {'role': 'user', 'content': message.trim()},
    ];

    try {
      String? lastErrorMessage;

      for (final model in _models) {
        try {
          final response = await _dio.post(
            '/chat/completions',
            data: {
              'model': model,
              'messages': conversation,
              'temperature': 0.35,
              'max_tokens': 450,
            },
            options: Options(headers: {'Authorization': 'Bearer $_hfToken'}),
          );

          final raw = _extractAssistantContent(response.data);
          if (raw == null || raw.isEmpty) {
            lastErrorMessage = 'No reply received from model $model.';
            continue;
          }

          final cleaned = _cleanModelText(raw);
          if (_isCorruptedReply(cleaned)) {
            lastErrorMessage =
                'Model $model returned an invalid reply, trying fallback model.';
            continue;
          }

          return Right(cleaned);
        } on DioException catch (e) {
          final msg = _extractErrorMessage(e.response?.data);
          if (msg != null) {
            lastErrorMessage = msg;
            continue;
          }
          lastErrorMessage = e.message;
        }
      }

      return Left(
        Failure(
          lastErrorMessage ?? 'No available model could handle the request.',
        ),
      );
    } on DioException catch (e) {
      final msg = _extractErrorMessage(e.response?.data);
      if (msg != null) {
        return Left(Failure(msg));
      }
      return Left(Failure(e.message ?? 'Chat request failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
