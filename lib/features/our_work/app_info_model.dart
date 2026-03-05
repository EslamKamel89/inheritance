class AppInfo {
  final String titleKey;
  final String descriptionKey;
  final List<String> images;
  final String appStoreUrl;
  final String googlePlayUrl;

  const AppInfo({
    required this.titleKey,
    required this.descriptionKey,
    required this.images,
    required this.appStoreUrl,
    required this.googlePlayUrl,
  });
}
