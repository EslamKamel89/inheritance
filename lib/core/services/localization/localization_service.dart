class LocalizationService {
  LocalizationService._();
  static final LocalizationService instance = LocalizationService._();
  Map<String, dynamic> _translations = {};

  Map<String, dynamic> get translations => _translations;
  Future<void> loadTranslations() async {
    await Future.delayed(const Duration(milliseconds: 500));

    _translations = _fakeBackendResponse;
  }

  String translate(String key, String locale) {
    final entry = _translations[key];
    if (entry == null) return key;
    return entry[locale] ?? key;
  }

  final _fakeBackendResponse = {
    "bismillah_begin": {"en": "Bismillah, Let's Begin", "ar": "بسم الله، لنبدأ"},
    "any_will_written": {"en": "Any will written?", "ar": "هل توجد وصية مكتوبة؟"},
    "wasiyat_amount": {"en": "Will or Wasiyat amount?", "ar": "ما قيمة الوصية؟"},
    "loan_settle": {"en": "Loan to settle?", "ar": "هل يوجد دين يجب سداده؟"},
    "loan_amount": {"en": "Loan Amount?", "ar": "ما قيمة الدين؟"},
    "any_unborn_baby": {"en": "Any unborn baby?", "ar": "هل يوجد جنين لم يولد بعد؟"},
    "relation_deceased": {"en": "Relation with deceased?", "ar": "ما صلتك بالمتوفى؟"},
    "father_alive": {"en": "Father still alive?", "ar": "هل الأب على قيد الحياة؟"},
    "deceased_gender": {"en": "Deceased's gender?", "ar": "ما جنس المتوفى؟"},
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
    "how_many_daughters": {
      "en": "How many daughter(s) of the deceased?",
      "ar": "كم عدد بنات المتوفى؟",
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
    "how_many_grandchildren": {
      "en": "How many grandchildren(s) of the deceased?",
      "ar": "كم عدد أحفاد المتوفى؟",
    },
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
    "does_have_brothers": {"en": "Does the deceased have any brother(s)", "ar": "هل للمتوفى إخوة؟"},
    "does_have_children": {"en": "Do the deceased have any children?", "ar": "هل للمتوفى أبناء؟"},
    "father_alive_question": {
      "en": "Is the father of the deceased alive?",
      "ar": "هل والد المتوفى على قيد الحياة؟",
    },
    "loan_question": {
      "en": "Is there any loan to be returned on behalf of the deceased?",
      "ar": "هل يوجد دين يجب سداده نيابة عن المتوفى؟",
    },
    "mother_alive_question": {
      "en": "Is the mother of deceased alive?",
      "ar": "هل والدة المتوفى على قيد الحياة؟",
    },
    "does_have_sisters": {"en": "Does the deceased have any sister(s)", "ar": "هل للمتوفى أخوات؟"},
    "unborn_question": {
      "en": "Is there any Unborn Baby of the deceased?",
      "ar": "هل يوجد جنين لم يولد بعد للمتوفى؟",
    },
    "unborn_warning": {
      "en": "Please use the calculator once the baby is born (brought to the world).",
      "ar": "يرجى استخدام الحاسبة بعد ولادة الطفل.",
    },
    "start_again": {"en": "Start Again", "ar": "ابدأ من جديد"},
    "wasiyat_question": {
      "en": "Is there any WILL or Wasiyat by the deceased?",
      "ar": "هل ترك المتوفى وصية؟",
    },
    "enter_loan_amount": {"en": "Please Enter Loan Amount", "ar": "الرجاء إدخال قيمة الدين"},
    "loan_amount_question": {
      "en": "Please enter the total loan amount, to be returned on behalf of the deceased?",
      "ar": "يرجى إدخال إجمالي الدين المطلوب سداده نيابة عن المتوفى",
    },
    "male_married_alive": {
      "en": "Was the deceased married? If so, his wife is alive?",
      "ar": "هل كان المتوفى متزوجًا؟ وهل زوجته على قيد الحياة؟",
    },
    "next": {"en": "Next", "ar": "التالي"},
    "enter_total_amount": {"en": "Please Enter Total Amount", "ar": "الرجاء إدخال المبلغ الإجمالي"},
    "total_amount_question": {
      "en": "What is the total worth/amount left by deceased?",
      "ar": "ما إجمالي التركة التي تركها المتوفى؟",
    },
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
    "i_am_her_husband": {"en": "I am her Husbnad", "ar": "أنا زوجها"},
    "i_am_his_wife": {"en": "I am his wife", "ar": "أنا زوجته"},
    "none_of_them": {"en": "none of them", "ar": "لا شيء مما سبق"},
    "please_enter_sons": {"en": "Please Enter Sons Count", "ar": "الرجاء إدخال عدد الأبناء الذكور"},
    "how_many_sons": {
      "en": "How many son(s) of the deceased?",
      "ar": "كم عدد أبناء المتوفى الذكور؟",
    },
    "please_enter_sisters": {"en": "Please Enter Sisters Count", "ar": "الرجاء إدخال عدد الأخوات"},
    "how_many_sisters": {
      "en": "How many sisters(s) of the deceased?",
      "ar": "كم عدد أخوات المتوفى؟",
    },
    "total_amount": {"en": "total amount", "ar": "إجمالي المبلغ"},
  };
}
