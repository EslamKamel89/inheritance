int parseStringToInt(String value) {
  try {
    return int.parse(value.trim());
  } catch (e) {
    return 0;
  }
}
