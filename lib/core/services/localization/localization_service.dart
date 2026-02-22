import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inheritance/core/api_service/api_consumer.dart';
import 'package:inheritance/core/heleprs/snackbar.dart';
import 'package:inheritance/core/service_locator/service_locator.dart';

class LocalizationService {
  LocalizationService._();
  static final LocalizationService instance = LocalizationService._();
  Map<String, dynamic> _translations = {};

  Map<String, dynamic> get translations => _translations;
  Future<void> loadTranslations() async {
    final api = serviceLocator<ApiConsumer>();
    try {
      // final res = await api.get(EndPoint.translates);
      _translations = _fakeBackendResponse();
      // _translations = res;
    } catch (e) {
      String errorMsg = 'Unkwon Error Occured';
      if (e is DioException) {
        errorMsg = jsonEncode(e.response?.data ?? 'Unkwon Error Occured');
      }
      showSnackbar('Server Error', errorMsg, true);
    }
  }

  String translate(String key, String locale) {
    final entry = _translations[key];
    if (entry == null) return key;
    return entry[locale] ?? key;
  }

  _fakeBackendResponse() => {
    "total_amount_question": {
      "en": "What is the total worth/amount left by the deceased?",
      "ar": "ما هي القيمة الإجمالية للتركة التي خلّفها المتوفّى؟",
    },

    "wasiyat_question": {
      "en": "Did the deceased leave a will ?",
      "ar": "هل توجد وصيّة تركها المتوفّى؟",
    },

    "loan_settle": {
      "en": "Are there any outstanding liabilities of the deceased?",
      "ar": "هل على المتوفّى ذمم مالية قائمة نتيجة اتفاقات تعاقدية؟",
    },

    "any_unborn_baby": {
      "en": "Did the deceased leave any unborn child?",
      "ar": "هل يوجد جنين للمتوفّى لم يولد بعد؟",
    },

    "relation_deceased": {
      "en": "What is your relationship to the deceased?",
      "ar": "ما هي صلتك بالمتوفّى / المتوفّاة؟",
    },

    "i_am_her_husband": {"en": "I am her husband.", "ar": "أنا زوجها."},

    "i_am_his_wife": {"en": "I am his wife.", "ar": "أنا زوجته."},

    "none_of_them": {"en": "None of the above", "ar": "لا شيء مما سبق"},

    "deceased_gender": {
      "en": "What was the gender of the deceased?",
      "ar": "ما هو جنس المتوفّى / المتوفّاة",
    },

    "male_married_alive": {
      "en": "Was the deceased married? If yes, is his wife still living?",
      "ar": "هل كان المتوفّى متزوّجًا؟ وإذا كان كذلك، فهل زوجته ما زالت على قيد الحياة؟",
    },

    "father_alive_question": {
      "en": "Is the deceased’s father still alive?",
      "ar": "هل والد المتوفّى ما زال على قيد الحياة؟",
    },

    "mother_alive_question": {
      "en": "Is the deceased’s mother still alive?",
      "ar": "هل والدة المتوفّى ما زالت على قيد الحياة؟",
    },

    "does_have_children": {
      "en": "Did the deceased have any children?",
      "ar": "هل كان للمتوفّى أيّ أبناء؟",
    },

    "how_many_sons": {
      "en": "How many sons did the deceased have?",
      "ar": "كم عدد أبناء المتوفّى الذكور؟",
    },

    "how_many_daughters": {
      "en": "How many daughters did the deceased have?",
      "ar": "كم عدد بنات المتوفّى؟",
    },

    "how_many_grandchildren": {
      "en": "How many grandchildren did the deceased have?",
      "ar": "كم عدد أحفاد المتوفّى؟",
    },

    "does_have_sisters": {
      "en": "Did the deceased have any sisters?",
      "ar": "هل كان للمتوفّى أيّ أخوات؟",
    },

    "does_have_brothers": {
      "en": "Did the deceased have any brothers?",
      "ar": "هل كان للمتوفّى أيّ إخوة؟",
    },

    "bismillah_begin": {"en": "Bismillah, Let's Begin", "ar": "بسم الله، لنبدأ"},
    "any_will_written": {"en": "Any will written?", "ar": "هل توجد وصية مكتوبة؟"},
    "wasiyat_amount": {"en": "Will or Wasiyat amount?", "ar": "ما قيمة الوصية؟"},
    "loan_amount": {"en": "Loan Amount?", "ar": "ما قيمة الدين؟"},
    "father_alive": {"en": "Father still alive?", "ar": "هل الأب على قيد الحياة؟"},
    "wife_alive": {"en": "Deceased's wife alive?", "ar": "هل زوجة المتوفى على قيد الحياة؟"},
    "husband_alive": {"en": "Deceased's husband alive?", "ar": "هل زوج المتوفاة على قيد الحياة؟"},
    "mother_alive": {"en": "Mother still alive?", "ar": "هل الأم على قيد الحياة؟"},
    "children_exist": {"en": "Deceased's children?", "ar": "هل للمتوفى أبناء؟"},
    "sisters_exist": {"en": "Deceased's sisters?", "ar": "هل للمتوفى أخوات؟"},
    "sons_count": {"en": "Sons count?", "ar": "كم عدد الأبناء الذكور؟"},
    "daughters_count": {"en": "Daughters count?", "ar": "كم عدد البنات؟"},
    "sisters_count": {"en": "Sisters count?", "ar": "كم عدد الأخوات؟"},
    "brothers_exist": {"en": "Deceased's brothers?", "ar": "هل للمتوفى إخوة؟"},
    "brothers_count": {"en": "Brtohers count?", "ar": "كم عدد الإخوة؟"},
    "result": {"en": "Result", "ar": "النتيجة"},
    "back": {"en": "Back", "ar": "رجوع"},
    "please_enter_brothers": {"en": "Please Enter Brothers Count", "ar": "الرجاء إدخال عدد الإخوة"},
    "how_many_brothers": {
      "en": "How many brother(s) of the deceased?",
      "ar": "كم عدد إخوة المتوفى؟",
    },
    "brothers_placeholder": {"en": "brother(s) count", "ar": "عدد الإخوة"},
    "please_enter_daughters": {
      "en": "Please Enter Daughters Count",
      "ar": "الرجاء إدخال عدد البنات",
    },

    "daughters_placeholder": {"en": "daughter(s) count", "ar": "عدد البنات"},
    "gender_question": {"en": "What is the gender of the deceased?", "ar": "ما جنس المتوفى؟"},
    "female_married_alive": {
      "en": "Was the deceased married? If so, her husband is alive?",
      "ar": "هل كانت المتوفاة متزوجة؟ وهل زوجها على قيد الحياة؟",
    },
    "grandchildren_overview": {"en": "Grandchildren overview", "ar": "نظرة عامة على الأحفاد"},
    "records": {"en": "records", "ar": "سجلات"},
    "no_grandchildren": {"en": "No grandchildren found", "ar": "لا يوجد أحفاد"},
    "close": {"en": "Close", "ar": "إغلاق"},
    "males": {"en": "Males", "ar": "ذكور"},
    "females": {"en": "Females", "ar": "إناث"},
    "men_share": {"en": "Men share", "ar": "نصيب الذكور"},
    "women_share": {"en": "Women share", "ar": "نصيب الإناث"},
    "total": {"en": "Total", "ar": "الإجمالي"},

    "grandchildren_placeholder": {"en": "grandchildren(s) count", "ar": "عدد الأحفاد"},
    "child": {"en": "Child", "ar": "الابن"},
    "gender": {"en": "Gender", "ar": "الجنس"},
    "status": {"en": "Status", "ar": "الحالة"},
    "deceased": {"en": "Deceased", "ar": "متوفى"},
    "alive": {"en": "Alive", "ar": "حي"},
    "grandchildren_males": {"en": "Grandchildren (males)", "ar": "أحفاد ذكور"},
    "grandchildren_females": {"en": "Grandchildren (females)", "ar": "أحفاد إناث"},
    "enter_male_grandchildren": {
      "en": "Enter number of male grandchildren",
      "ar": "أدخل عدد الأحفاد الذكور",
    },
    "enter_female_grandchildren": {
      "en": "Enter number of female grandchildren",
      "ar": "أدخل عدد الأحفاد الإناث",
    },
    "yes": {"en": "YES", "ar": "نعم"},
    "no": {"en": "NO", "ar": "لا"},

    "loan_question": {
      "en": "Is there any loan to be returned on behalf of the deceased?",
      "ar": "هل يوجد دين يجب سداده نيابة عن المتوفى؟",
    },

    "unborn_question": {
      "en": "Is there any Unborn Baby of the deceased?",
      "ar": "هل يوجد جنين لم يولد بعد للمتوفى؟",
    },
    "unborn_warning": {
      "en": "Please use the calculator once the baby is born (brought to the world).",
      "ar": "يرجى استخدام الحاسبة بعد ولادة الطفل.",
    },
    "start_again": {"en": "Start Again", "ar": "ابدأ من جديد"},

    "enter_loan_amount": {"en": "Please Enter Loan Amount", "ar": "الرجاء إدخال قيمة الدين"},
    "loan_amount_question": {
      "en": "Please enter the total loan amount, to be returned on behalf of the deceased?",
      "ar": "يرجى إدخال إجمالي الدين المطلوب سداده نيابة عن المتوفى",
    },

    "next": {"en": "Next", "ar": "التالي"},
    "enter_total_amount": {"en": "Please Enter Total Amount", "ar": "الرجاء إدخال المبلغ الإجمالي"},

    "enter_wasiyat": {"en": "Please Enter Wasiyat Amount", "ar": "الرجاء إدخال قيمة الوصية"},
    "wasiyat_amount_question": {
      "en": "Please enter the total amount mentioned on the WILL or Wasiyat by the deceased?",
      "ar": "يرجى إدخال إجمالي المبلغ المذكور في الوصية",
    },
    "relation_question": {
      "en": "What is your relation with the deceased?",
      "ar": "ما صلتك بالمتوفى؟",
    },
    "use_after_birth": {
      "en": "Please use the calculator once the baby is born (brought to the world).",
      "ar": "يرجى استخدام الحاسبة بعد ولادة الطفل.",
    },

    "unborn_baby": {
      "en": "Is there any Unborn Baby of the deceased?",
      "ar": "هل يوجد جنين للمتوفى لم يولد بعد؟",
    },
    "please_enter_sons": {"en": "Please Enter Sons Count", "ar": "الرجاء إدخال عدد الأبناء الذكور"},

    "please_enter_sisters": {"en": "Please Enter Sisters Count", "ar": "الرجاء إدخال عدد الأخوات"},
    "how_many_sisters": {
      "en": "How many sisters(s) of the deceased?",
      "ar": "كم عدد أخوات المتوفى؟",
    },
    "total_amount": {"en": "total amount", "ar": "إجمالي المبلغ"},
    "male": {"en": "Male", "ar": "ذكر"},
    "female": {"en": "Female", "ar": "أنثي"},
    "details": {"en": "Details", "ar": "التفاصيل"},
    "grandchildren": {"en": "Grand Children", "ar": "الأحفاد"},

    // ================= ABOUT SCREEN =================
    "about_app_name": {"en": "Mirath", "ar": "ميراث"},
    "about_tagline": {
      "en": "Guided by Shariah. Built for peace of mind.",
      "ar": "مستند إلى الشريعة. صُمم لراحة البال.",
    },

    "about_section_title": {"en": "About the App", "ar": "عن التطبيق"},
    "about_section_body": {
      "en":
          "Mirath helps you calculate inheritance shares according to Islamic law in a simple, guided, and clear way.",
      "ar": "يساعدك تطبيق ميراث على حساب أنصبة الميراث وفق الشريعة الإسلامية بطريقة سهلة ومبسطة.",
    },

    "about_how_title": {"en": "How It Works", "ar": "كيف يعمل التطبيق"},
    "about_how_body": {
      "en":
          "You answer step-by-step questions about the deceased and heirs. The app then calculates the correct distribution automatically.",
      "ar":
          "تقوم بالإجابة على مجموعة من الأسئلة خطوة بخطوة، ثم يقوم التطبيق بحساب التوزيع الصحيح تلقائيًا.",
    },

    "about_disclaimer_title": {"en": "Important Disclaimer", "ar": "تنبيه مهم"},
    "about_disclaimer_body": {
      "en":
          "This app is an educational tool only. It does not replace official religious or legal consultation. Always consult qualified scholars for complex cases.",
      "ar":
          "هذا التطبيق أداة تعليمية فقط ولا يُغني عن الاستشارة الشرعية أو القانونية. يُنصح بالرجوع إلى أهل العلم في الحالات المعقدة.",
    },

    "about_limitations_title": {"en": "Limitations", "ar": "القيود"},
    "about_limitations_body": {
      "en":
          "Some special cases may not be supported, such as unborn heirs, disputed ownership, or incomplete information.",
      "ar": "قد لا يدعم التطبيق بعض الحالات الخاصة مثل وجود جنين أو النزاعات أو نقص المعلومات.",
    },

    "about_version_title": {"en": "Version", "ar": "الإصدار"},
    "about_version_body": {"en": "Mirath v1.0", "ar": "ميراث الإصدار 1.0"},
  };
}
