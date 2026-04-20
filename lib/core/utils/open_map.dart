import 'package:tourismapp/core/constants/link_tokens.dart';
import 'package:tourismapp/core/utils/easy_loading.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openLocationLink(String url) async {
  final normalizedUrl = url.trim();
  if (normalizedUrl.isEmpty || normalizedUrl == unavailableLocationLinkToken) {
    showError('Package location link is not available yet.');
    return;
  }

  final uri = Uri.tryParse(normalizedUrl);
  final isValidHttpUrl =
      uri != null &&
      (uri.scheme == 'http' || uri.scheme == 'https') &&
      uri.host.isNotEmpty;
  if (!isValidHttpUrl) {
    showError('Package location link is invalid.');
    return;
  }

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    showError('Could not open location link right now.');
  }
}
