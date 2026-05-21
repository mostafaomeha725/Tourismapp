import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';

import '/core/constants/strings.dart';
import '/core/di/services_locator.dart';
import '/core/error/failure.dart';
import 'authorization_interceptor.dart';

class NetworkService {
  final Dio dio;

  NetworkService(this.dio) {
    dio.options
      ..baseUrl = AppStrings.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..receiveDataWhenStatusError = true
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30);

    addHeaders();
    addInterceptors();
  }

  String _t({required String en, required String ar, required String fr}) {
    final lang = (sl<PreferencesStorage>().getCurrentLanguage()).toLowerCase();
    if (lang.startsWith('ar')) return ar;
    if (lang.startsWith('fr')) return fr;
    return en;
  }

  String _noInternetMessage() => _t(
    en: 'No Internet Connection',
    ar: 'لا يوجد اتصال بالإنترنت',
    fr: 'Pas de connexion Internet',
  );

  bool _isNoInternetError(DioException e) {
    final message = (e.message ?? '').toLowerCase();
    final errorText = (e.error?.toString() ?? '').toLowerCase();

    return message.contains('failed host lookup') ||
        errorText.contains('failed host lookup') ||
        message.contains('socketexception') ||
        errorText.contains('socketexception');
  }

  void addInterceptors() {
    dio.interceptors.add(AuthorizationInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(requestBody: true, requestHeader: true),
    );
  }

  void addHeaders() {
    final prefs = sl<PreferencesStorage>();

    final token = prefs.getUserToken();
    final lang = prefs.getCurrentLanguage();

    dio.options.headers = {
      "Accept": "application/json",
      "Accept-Encoding": "gzip, deflate",
      "Accept-Language": lang,

      if (token != null && token.isNotEmpty) "Authorization": "Bearer $token",
    };
  }

  void addToken(String token) {
    dio.options.headers['Authorization'] = "Bearer $token";
  }

  void removeToken() {
    dio.options.headers.remove('Authorization');
  }

  Future<Either<Failure, dynamic>> postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool isRaw = true,
  }) async {
    try {
      var response = await dio.post(
        endPoint,
        data: data == null
            ? null
            : isRaw
            ? data
            : FormData.fromMap(data),
        queryParameters: queryParameters,
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        final body = response.data;
        if (body is Map<String, dynamic> && body['status'] == false) {
          return Left(
            Failure(
              body['message']?.toString() ??
                  _t(
                    en: 'Request failed',
                    ar: 'فشل الطلب',
                    fr: 'La requête a échoué',
                  ),
            ),
          );
        }
        return Right(body);
      } else {
        final body = response.data;
        final msg = body is Map<String, dynamic>
            ? body['message']?.toString()
            : null;
        return Left(
          Failure(
            msg ??
                _t(
                  en: 'Error ${response.statusCode}',
                  ar: 'خطأ ${response.statusCode}',
                  fr: 'Erreur ${response.statusCode}',
                ),
          ),
        );
      }
    } on SocketException {
      return Left(
        Failure(
          _t(
            en: 'No Internet Connection',
            ar: 'لا يوجد اتصال بالإنترنت',
            fr: 'Pas de connexion Internet',
          ),
        ),
      );
    } on FormatException catch (e) {
      return Left(Failure(_handleFormatException(e)));
    } on DioException catch (e) {
      return handleDioExceoptions(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, dynamic>> uploadFile({
    required String endPoint,
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      var response = await dio.post(
        endPoint,
        data: formData,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on SocketException {
      return Left(
        Failure(
          _t(
            en: 'No Internet Connection',
            ar: 'لا يوجد اتصال بالإنترنت',
            fr: 'Pas de connexion Internet',
          ),
        ),
      );
    } on FormatException {
      return Left(
        Failure(
          _t(
            en: 'Format Exception',
            ar: 'خطأ في تنسيق البيانات',
            fr: 'Erreur de format',
          ),
        ),
      );
    } on DioException catch (e) {
      return handleDioExceoptions(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<String, dynamic>> downloadFile({
    required String fileUrl,
    required String savePath,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers = {"Accept": "*/*"};

    try {
      var response = await dio.download(
        fileUrl,
        savePath,
        queryParameters: queryParameters,
        onReceiveProgress: (received, total) {
          // You can use these values to show download progress
          // safePrint(
          //     'downloadFile =>Received: ${received.toString()}, Total: ${total.toString()}');

          if (total != -1) {
            // Calculate download progress percentage
            // double progress = (received / total * 100);
            // safePrint('downloadFile => progress: ${progress.toString()}}');
          }
        },
      );
      return Right(response);
    } catch (e) {
      debugPrint(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<Failure, dynamic>> putData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      var response = await dio.put(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on SocketException {
      return Left(
        Failure(
          _t(
            en: 'No Internet Connection',
            ar: 'لا يوجد اتصال بالإنترنت',
            fr: 'Pas de connexion Internet',
          ),
        ),
      );
    } on FormatException {
      return Left(
        Failure(
          _t(
            en: 'Format Exception',
            ar: 'خطأ في تنسيق البيانات',
            fr: 'Erreur de format',
          ),
        ),
      );
    } on DioException catch (e) {
      return handleDioExceoptions(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<String, dynamic>> patchData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool isRaw = true,
  }) async {
    try {
      var response = await dio.patch(
        endPoint,
        queryParameters: queryParameters,
        data: data == null
            ? null
            : isRaw
            ? data
            : FormData.fromMap(data),
      );
      return Right(response.data);
    } on SocketException {
      return Left(
        _t(
          en: 'No Internet Connection',
          ar: 'لا يوجد اتصال بالإنترنت',
          fr: 'Pas de connexion Internet',
        ),
      );
    } on FormatException {
      return Left(
        _t(
          en: 'Format Exception',
          ar: 'خطأ في تنسيق البيانات',
          fr: 'Erreur de format',
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final message = _extractErrorMessage(
          e.response?.data,
          fallback:
              e.message ??
              _t(
                en: 'Bad response',
                ar: 'استجابة غير صالحة',
                fr: 'Mauvaise réponse',
              ),
        );
        return Left(message);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // safePrint('check your connection');
        return Left(
          _t(
            en: 'Check your connection',
            ar: 'تحقق من اتصالك بالإنترنت',
            fr: 'Vérifiez votre connexion',
          ),
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // safePrint('unable to connect to the server');
        return Left(
          _t(
            en: 'Unable to connect to the server',
            ar: 'تعذر الاتصال بالخادم',
            fr: 'Impossible de se connecter au serveur',
          ),
        );
      } else {
        return Left(e.message ?? "");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, dynamic>> deleteData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      var response = await dio.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on SocketException {
      return Left(
        _t(
          en: 'No Internet Connection',
          ar: 'لا يوجد اتصال بالإنترنت',
          fr: 'Pas de connexion Internet',
        ),
      );
    } on FormatException {
      return Left(
        _t(
          en: 'Format Exception',
          ar: 'خطأ في تنسيق البيانات',
          fr: 'Erreur de format',
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final message = _extractErrorMessage(
          e.response?.data,
          fallback:
              e.message ??
              _t(
                en: 'Bad response',
                ar: 'استجابة غير صالحة',
                fr: 'Mauvaise réponse',
              ),
        );
        return Left(message);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // safePrint('check your connection');
        return Left(
          _t(
            en: 'Check your connection',
            ar: 'تحقق من اتصالك بالإنترنت',
            fr: 'Vérifiez votre connexion',
          ),
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // safePrint('unable to connect to the server');
        return Left(
          _t(
            en: 'Unable to connect to the server',
            ar: 'تعذر الاتصال بالخادم',
            fr: 'Impossible de se connecter au serveur',
          ),
        );
      } else {
        return Left(e.message ?? "");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<Failure, dynamic>> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      var response = await dio.get(endPoint, queryParameters: queryParameters);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return Right(response.data);
      } else {
        return Left(Failure(response.data['message']));
      }
    } on SocketException {
      return Left(
        Failure(
          _t(
            en: 'No Internet Connection',
            ar: 'لا يوجد اتصال بالإنترنت',
            fr: 'Pas de connexion Internet',
          ),
        ),
      );
    } on FormatException {
      return Left(
        Failure(
          _t(
            en: 'Format Exception',
            ar: 'خطأ في تنسيق البيانات',
            fr: 'Erreur de format',
          ),
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return Left(Failure(e.response!.data['message']));
        // return Left(_l)(e.message);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // safePrint('check your connection');
        return Left(
          Failure(
            _t(
              en: 'Check your connection',
              ar: 'تحقق من اتصالك بالإنترنت',
              fr: 'Vérifiez votre connexion',
            ),
          ),
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return Left(
          Failure(
            _t(
              en: 'Unable to connect to the server',
              ar: 'تعذر الاتصال بالخادم',
              fr: 'Impossible de se connecter au serveur',
            ),
          ),
        );
      } else {
        return Left(Failure(e.message ?? ""));
        // return const Left("Check internet connection");
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Left<Failure, dynamic> handleDioExceoptions(DioException e) {
    if (_isNoInternetError(e)) {
      return Left(Failure(_noInternetMessage()));
    }

    if (e.type == DioExceptionType.connectionError) {
      return Left(Failure(_noInternetMessage()));
    }

    if (e.type == DioExceptionType.badResponse) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        // Handle validation errors as Map: { "errors": { "Email": ["..."], "PhoneNumber": ["..."] } }
        if (data['errors'] is Map) {
          final errors = data['errors'] as Map;
          for (final fieldErrors in errors.values) {
            if (fieldErrors is List && fieldErrors.isNotEmpty) {
              return Left(Failure(fieldErrors.first.toString()));
            }
          }
        }
        // Handle errors as List: { "errors": [{"description": "..."}] }
        if (data['errors'] is List && (data['errors'] as List).isNotEmpty) {
          final firstError = (data['errors'] as List).first;
          if (firstError is Map<String, dynamic>) {
            return Left(
              Failure(
                firstError['description']?.toString() ??
                    _t(
                      en: 'Unknown error',
                      ar: 'خطأ غير معروف',
                      fr: 'Erreur inconnue',
                    ),
              ),
            );
          }
        }
        // Handle message field format
        if (data['message'] != null) {
          return Left(Failure(data['message'].toString()));
        }
        // Fallback to title
        if (data['title'] != null) {
          return Left(Failure(data['title'].toString()));
        }
      }
      return Left(
        Failure(
          e.message ??
              _t(
                en: 'Something went wrong',
                ar: 'حدث خطأ ما',
                fr: 'Une erreur est survenue',
              ),
        ),
      );
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return Left(
        Failure(
          _t(
            en: 'Check your connection',
            ar: 'تحقق من اتصالك بالإنترنت',
            fr: 'Vérifiez votre connexion',
          ),
        ),
      );
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return Left(
        Failure(
          _t(
            en: 'Unable to connect to the server',
            ar: 'تعذر الاتصال بالخادم',
            fr: 'Impossible de se connecter au serveur',
          ),
        ),
      );
    } else if (e.type == DioExceptionType.unknown) {
      final responseData = e.response?.data;
      if (responseData is Map<String, dynamic>) {
        final message = _extractErrorMessage(
          responseData,
          fallback: _t(
            en: 'Unexpected network error',
            ar: 'خطأ غير متوقع في الشبكة',
            fr: 'Erreur réseau inattendue',
          ),
        );
        return Left(Failure(message));
      }

      if (responseData is String) {
        final parsed = _tryParseJsonObject(responseData);
        if (parsed != null) {
          final message = _extractErrorMessage(
            parsed,
            fallback: _t(
              en: 'Unexpected network error',
              ar: 'خطأ غير متوقع في الشبكة',
              fr: 'Erreur réseau inattendue',
            ),
          );
          return Left(Failure(message));
        }

        final trimmed = responseData.trim();
        if (trimmed.startsWith('<!DOCTYPE html') ||
            trimmed.startsWith('<html')) {
          return Left(
            Failure(
              _t(
                en: 'Server returned HTML instead of JSON response.',
                ar: 'الخادم أعاد HTML بدلًا من JSON.',
                fr: 'Le serveur a renvoyé du HTML au lieu de JSON.',
              ),
            ),
          );
        }

        if (trimmed.isNotEmpty) {
          return Left(Failure(trimmed));
        }
      }

      final error = e.error;
      if (error is SocketException) {
        return Left(
          Failure(
            _t(
              en: 'No Internet Connection',
              ar: 'لا يوجد اتصال بالإنترنت',
              fr: 'Pas de connexion Internet',
            ),
          ),
        );
      }

      if (error is HandshakeException || error is TlsException) {
        return Left(
          Failure(
            _t(
              en: 'Secure connection failed. Please try another network.',
              ar: 'فشل الاتصال الآمن. حاول استخدام شبكة أخرى.',
              fr: 'La connexion sécurisée a échoué. Veuillez essayer un autre réseau.',
            ),
          ),
        );
      }

      if (error is HttpException) {
        return Left(Failure(error.message));
      }

      if (error != null) {
        return Left(Failure(error.toString()));
      }

      return Left(
        Failure(
          e.message ??
              _t(
                en: 'Unexpected network error',
                ar: 'خطأ غير متوقع في الشبكة',
                fr: 'Erreur réseau inattendue',
              ),
        ),
      );
    } else {
      return Left(
        Failure(
          e.message ??
              _t(
                en: 'Unexpected network error',
                ar: 'خطأ غير متوقع في الشبكة',
                fr: 'Erreur réseau inattendue',
              ),
        ),
      );
    }
  }

  String _extractErrorMessage(dynamic data, {required String fallback}) {
    if (data is Map<String, dynamic>) {
      final errors = data['errors'];

      if (errors is List && errors.isNotEmpty) {
        final first = errors.first;
        if (first is Map<String, dynamic>) {
          final description = first['description'];
          if (description is String && description.isNotEmpty) {
            return description;
          }
          final message = first['message'];
          if (message is String && message.isNotEmpty) {
            return message;
          }
        }
        if (first is String && first.isNotEmpty) {
          return first;
        }
      }

      if (errors is Map) {
        for (final value in errors.values) {
          if (value is List && value.isNotEmpty) {
            final first = value.first;
            if (first is String && first.isNotEmpty) {
              return first;
            }
          }
          if (value is String && value.isNotEmpty) {
            return value;
          }
        }
      }

      final message = data['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }

      final title = data['title'];
      if (title is String && title.isNotEmpty) {
        return title;
      }
    }

    return fallback;
  }

  String _handleFormatException(FormatException exception) {
    final message = exception.message.toLowerCase();
    if (message.contains('unexpected character')) {
      return _t(
        en: 'Server returned invalid response format.',
        ar: 'الخادم أعاد تنسيق استجابة غير صالح.',
        fr: 'Le serveur a renvoyé un format de réponse invalide.',
      );
    }
    return exception.message;
  }

  Map<String, dynamic>? _tryParseJsonObject(String value) {
    final normalized = value.trim().replaceFirst('\uFEFF', '');
    if (normalized.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(normalized);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {}

    return null;
  }
}
