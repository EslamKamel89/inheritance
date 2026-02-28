import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inheritance/core/api_service/api_consumer.dart';
import 'package:inheritance/core/api_service/end_points.dart';
import 'package:inheritance/core/heleprs/print_helper.dart';
import 'package:inheritance/core/service_locator/service_locator.dart';
import 'package:inheritance/core/static_data/shared_prefrences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  LocalizationService._();
  final SharedPreferences prefs = serviceLocator<SharedPreferences>();
  static final LocalizationService instance = LocalizationService._();
  Map<String, dynamic> _translations = {};

  Map<String, dynamic> get translations => _translations;
  Future<void> loadTranslations() async {
    final api = serviceLocator<ApiConsumer>();
    try {
      final res = await api.get(EndPoint.translates);
      _translations = res;
      // _translations = _fakeBackendResponse();
      prefs.setString(ShPrefKey.translations, jsonEncode(_translations));
    } catch (e) {
      String errorMsg = 'Unkwon Error Occured';
      if (e is DioException) {
        errorMsg = jsonEncode(e.response?.data ?? 'Unkwon Error Occured');
      }
      // showSnackbar('Server Error', errorMsg, true);
      pr(errorMsg, 'LocalizationService - loadTranslations');
      final translationsStr = prefs.getString(ShPrefKey.translations);
      if (translationsStr != null) {
        _translations = jsonDecode(translationsStr);
      }
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

    // ================= EXAMPLES / TUTORIAL SCREEN =================
    "examples_title": {"en": "How to Use", "ar": "كيفية الاستخدام"},
    "examples_intro_title": {"en": "Using Mirath is Simple", "ar": "استخدام ميراث سهل"},
    "examples_intro_body": {
      "en":
          "Follow a few guided steps and the app will calculate inheritance shares automatically.",
      "ar": "اتبع خطوات بسيطة وسيقوم التطبيق بحساب أنصبة الميراث تلقائيًا.",
    },

    "step1_title": {"en": "Enter Total Estate", "ar": "إدخال إجمالي التركة"},
    "step1_body": {
      "en": "Start by entering the total amount of inheritance left by the deceased.",
      "ar": "ابدأ بإدخال إجمالي قيمة التركة التي تركها المتوفى.",
    },

    "step2_title": {"en": "Add Debts & Wills", "ar": "إضافة الديون والوصية"},
    "step2_body": {
      "en": "Enter any debts or wills that must be deducted before distribution.",
      "ar": "أدخل الديون أو الوصايا التي يجب خصمها قبل توزيع التركة.",
    },

    "step3_title": {"en": "Choose Your Relation", "ar": "تحديد علاقتك بالمتوفى"},
    "step3_body": {
      "en": "Select your relationship to the deceased so the app understands your role.",
      "ar": "اختر علاقتك بالمتوفى ليتمكن التطبيق من تحديد دورك.",
    },

    "step4_title": {"en": "Answer Family Questions", "ar": "الإجابة على أسئلة العائلة"},
    "step4_body": {
      "en": "Answer simple questions about parents, children, and other relatives.",
      "ar": "أجب عن أسئلة بسيطة حول الوالدين والأبناء وبقية الأقارب.",
    },

    "step5_title": {"en": "Get Automatic Results", "ar": "الحصول على النتائج تلقائيًا"},
    "step5_body": {
      "en": "The app calculates inheritance shares instantly based on Islamic rules.",
      "ar": "يقوم التطبيق بحساب الأنصبة فورًا وفق أحكام الشريعة الإسلامية.",
    },

    "examples_ready": {"en": "You're ready to start!", "ar": "أنت الآن جاهز للبدء!"},

    // ================= RESULT LABELS =================
    "wasiayat_value": {"en": "Wasiyat Amount", "ar": "قيمة الوصية"},

    "loan_value": {"en": "Loan Amount", "ar": "قيمة الدين"},

    "brothers_number": {"en": "Brothers Count", "ar": "عدد الإخوة"},

    "sisters_number": {"en": "Sisters Count", "ar": "عدد الأخوات"},

    "grandchildren_number": {"en": "Grandchildren", "ar": "الأحفاد"},

    "total_value": {"en": "Total Amount", "ar": "إجمالي التركة"},

    "husband": {"en": "Husband", "ar": "الزوج"},
    "wife": {"en": "Wife", "ar": "الزوجة"},
    "mother": {"en": "Mother", "ar": "الأم"},
    "father": {"en": "Father", "ar": "الأب"},

    "sons": {"en": "Sons", "ar": "الأبناء الذكور"},
    "daughters": {"en": "Daughters", "ar": "البنات"},

    "son": {"en": "Son", "ar": "ابن"},
    "daughter": {"en": "Daughter", "ar": "ابنة"},

    "brother": {"en": "Brother", "ar": "أخ"},
    "sister": {"en": "Sister", "ar": "أخت"},

    "remaining": {"en": "Remaining Amount", "ar": "المبلغ المتبقي"},

    // ----------------- new ----------------------------
    "about_section_html": {
      "en":
          "<h1>About Mirath</h1><p><strong>Mirath</strong> is a guided inheritance calculation tool designed to simplify the complex rules of Islamic inheritance (Faraid).</p><p>The application helps families understand how wealth should be distributed after settling debts and wills, following authentic Shariah principles.</p><h2>Our Mission</h2><p>We aim to make inheritance calculations:</p><ul><li>Clear and understandable</li><li>Accurate according to Islamic jurisprudence</li><li>Accessible to everyone</li></ul><blockquote data-type=\"definition\">Mirath is not just a calculator — it is an educational companion that guides users step by step.</blockquote>",
      "ar":
          "<h1>عن تطبيق ميراث</h1><p><strong>ميراث</strong> هو أداة موجهة لحساب الميراث تهدف إلى تبسيط أحكام المواريث في الشريعة الإسلامية.</p><p>يساعد التطبيق العائلات على فهم كيفية توزيع التركة بعد سداد الديون وتنفيذ الوصايا، وفقًا لأحكام الشريعة المعتمدة.</p><h2>رسالتنا</h2><p>نسعى إلى جعل حساب الميراث:</p><ul><li>واضحًا وسهل الفهم</li><li>دقيقًا وفق الفقه الإسلامي</li><li>متاحًا للجميع</li></ul><blockquote data-type=\"definition\">ميراث ليس مجرد حاسبة، بل دليل تعليمي يرافق المستخدم خطوة بخطوة.</blockquote>",
    },

    "about_how_html": {
      "en":
          "<h1>How Mirath Works</h1><h2>Step 1: Enter the Estate</h2><p>You begin by entering the total estate value.</p><h2>Step 2: Deduct Obligations</h2><p>Debts and valid wills are deducted before distribution.</p><h2>Step 3: Identify Heirs</h2><p>The app asks structured questions about:</p><ul><li>Parents</li><li>Spouse</li><li>Children</li><li>Siblings</li></ul><h2>Step 4: Automatic Calculation</h2><p>Based on your answers, Mirath applies Islamic inheritance rules and generates the correct shares instantly.</p><span data-type=\"quran\">“For men is a share of what the parents and close relatives leave, and for women is a share...” (Qur’an 4:7)</span>",
      "ar":
          "<h1>كيف يعمل تطبيق ميراث</h1><h2>الخطوة الأولى: إدخال التركة</h2><p>تبدأ بإدخال إجمالي قيمة التركة.</p><h2>الخطوة الثانية: خصم الالتزامات</h2><p>يتم خصم الديون والوصايا الصحيحة قبل توزيع الميراث.</p><h2>الخطوة الثالثة: تحديد الورثة</h2><p>يطرح التطبيق أسئلة منظمة حول:</p><ul><li>الوالدين</li><li>الزوج أو الزوجة</li><li>الأبناء</li><li>الإخوة والأخوات</li></ul><h2>الخطوة الرابعة: الحساب التلقائي</h2><p>بناءً على إجاباتك، يطبق ميراث أحكام الشريعة ويحسب الأنصبة بدقة وفورًا.</p><span data-type=\"quran\">﴿لِلرِّجَالِ نَصِيبٌ مِّمَّا تَرَكَ الْوَالِدَانِ وَالْأَقْرَبُونَ وَلِلنِّسَاءِ نَصِيبٌ﴾ (النساء: 7)</span>",
    },

    "about_disclaimer_html": {
      "en":
          "<h1>Important Disclaimer</h1><p>This application is provided for <strong>educational and informational purposes</strong> only.</p><ul><li>It does not replace official legal consultation.</li><li>It does not replace certified religious scholarship.</li></ul><p>Inheritance cases may vary depending on specific circumstances, local laws, or juristic differences.</p><blockquote data-type=\"definition\">For complex or disputed cases, always consult a qualified Islamic scholar or legal authority.</blockquote><p><strong data-type=\"contrast\">Do not rely solely on automated tools for critical legal decisions.</strong></p>",
      "ar":
          "<h1>تنبيه مهم</h1><p>هذا التطبيق مخصص لأغراض <strong>تعليمية وتثقيفية</strong> فقط.</p><ul><li>لا يُغني عن الاستشارة القانونية الرسمية.</li><li>ولا يُغني عن الرجوع إلى أهل العلم المختصين.</li></ul><p>قد تختلف بعض حالات الميراث بحسب الظروف الخاصة أو القوانين المحلية أو اختلاف الاجتهادات الفقهية.</p><blockquote data-type=\"definition\">في الحالات المعقدة أو محل النزاع، يُنصح بالرجوع إلى عالم شرعي مؤهل أو جهة قانونية مختصة.</blockquote><p><strong data-type=\"contrast\">لا تعتمد على الأدوات الآلية وحدها في القرارات القانونية الحساسة.</strong></p>",
    },

    "about_limitations_html": {
      "en":
          "<h1>Current Limitations</h1><p>While Mirath covers common inheritance scenarios, some special cases may not yet be supported:</p><ul><li>Unborn heirs</li><li>Missing persons</li><li>Disputed ownership</li><li>Complex multi-generational cases</li></ul><p>We continuously improve the system to handle more advanced jurisprudential scenarios.</p><blockquote data-type=\"definition\">Your feedback helps us expand coverage and accuracy.</blockquote>",
      "ar":
          "<h1>القيود الحالية</h1><p>رغم أن ميراث يغطي أغلب الحالات الشائعة، إلا أن بعض الحالات الخاصة قد لا تكون مدعومة حاليًا مثل:</p><ul><li>وجود جنين</li><li>المفقودين</li><li>النزاعات على الملكية</li><li>الحالات متعددة الأجيال المعقدة</li></ul><p>نعمل باستمرار على تطوير النظام ليشمل حالات فقهية أكثر تعقيدًا.</p><blockquote data-type=\"definition\">ملاحظاتكم تساهم في تحسين التغطية والدقة.</blockquote>",
    },

    "share_app": {"en": "Share App", "ar": "مشاركة التطبيق"},

    "share_app_title": {"en": "Share Mirath", "ar": "مشاركة تطبيق ميراث"},

    "share_app_body": {
      "en": "Help others benefit from inheritance calculation by sharing the app.",
      "ar": "ساعد الآخرين في الاستفادة من حساب الميراث عبر مشاركة التطبيق.",
    },

    "share_android": {"en": "Share Android Version", "ar": "مشاركة نسخة أندرويد"},

    "share_ios": {"en": "Share iOS Version", "ar": "مشاركة نسخة iOS"},

    "cancel": {"en": "Cancel", "ar": "إلغاء"},
  };
}
