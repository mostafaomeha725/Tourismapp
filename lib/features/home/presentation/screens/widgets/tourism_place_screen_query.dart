part of '../tourism_place_screen.dart';

extension _TourismPlaceScreenQuery on TourismPlaceScreen {
  Future<bool> _isPlaceQueryResolvable(String query) async {
    if (query.trim().isEmpty) {
      return false;
    }

    final uri = Uri.https('nominatim.openstreetmap.org', '/search', {
      'q': query,
      'format': 'jsonv2',
      'limit': '1',
    });

    try {
      final response = await http.get(
        uri,
        headers: {'User-Agent': 'tourismapp/1.0'},
      );

      if (response.statusCode != 200) {
        return false;
      }

      final decoded = jsonDecode(response.body);
      return decoded is List && decoded.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
