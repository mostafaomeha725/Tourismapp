String formatRatingCompact(double rating) {
  final formatted = rating.toStringAsFixed(2);
  return formatted
      .replaceFirst(RegExp(r'0+$'), '')
      .replaceFirst(RegExp(r'\.$'), '');
}
