double? formatDouble(double? value) {
  if (value == null) return null;
  return double.parse(value.toStringAsFixed(2));
}
