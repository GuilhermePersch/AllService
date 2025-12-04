DateTime parseDate(String text) {
  final parts = text.split('/');
  if (parts.length != 3) return DateTime.now(); // fallback

  final day = int.tryParse(parts[0]) ?? 1;
  final month = int.tryParse(parts[1]) ?? 1;
  final year = int.tryParse(parts[2]) ?? 2000;

  return DateTime(year, month, day);
}