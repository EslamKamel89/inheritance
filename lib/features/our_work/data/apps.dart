import 'package:inheritance/features/our_work/app_info_model.dart';
import 'package:inheritance/utils/assets/assets.dart';

final List<AppInfo> apps = [
  AppInfo(
    titleKey: "our_work_quran_title",
    descriptionKey: "our_work_quran_description",
    images: [
      AssetsData.quran1,
      AssetsData.quran2,
      AssetsData.quran3,
      AssetsData.quran4,
      AssetsData.quran5,
    ],
    appStoreUrl: "https://apps.apple.com/us/app/dalalat-al-quran/id6736754081",
    googlePlayUrl: "https://play.google.com/store/apps/details?id=com.dubdev.dallalat",
  ),
  AppInfo(
    titleKey: "our_work_islamic_calendar_title",
    descriptionKey: "our_work_islamic_calendar_description",
    images: [
      AssetsData.islamicCalender1,
      AssetsData.islamicCalender2,
      AssetsData.islamicCalender3,
      AssetsData.islamicCalender4,
    ],
    appStoreUrl: "https://apps.apple.com/us/app/eternal-islamic-calendar/id6738862001",
    googlePlayUrl: "https://play.google.com/store/apps/details?id=com.gaztec.islamic_calander",
  ),
];
