import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/constants/link_tokens.dart';
import 'package:tourismapp/core/error/failure.dart';

class ResolvePackageBookingLinkUseCase {
  static const String unavailableLinkMessage = 'BOOKING_LINK_UNAVAILABLE';
  static const String invalidLinkMessage = 'BOOKING_LINK_INVALID';

  Either<Failure, String> call(String? rawLink) {
    final normalizedLink = rawLink?.trim();
    if (normalizedLink == null ||
        normalizedLink.isEmpty ||
        normalizedLink == unavailableLocationLinkToken ||
        normalizedLink == unavailableBookingLinkToken) {
      return const Left(Failure(unavailableLinkMessage));
    }

    final uri = Uri.tryParse(normalizedLink);
    final isValidHttpUrl =
        uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;

    if (!isValidHttpUrl) {
      return const Left(Failure(invalidLinkMessage));
    }

    return Right(normalizedLink);
  }
}
