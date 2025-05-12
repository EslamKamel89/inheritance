class ResultModel {
  double? husband;
  double? wife;
  double? mother;
  double? father;
  double? sons;
  double? daughters;
  double? son;
  double? daughter;
  double? remaining;
  double? totalAmount;

  ResultModel({
    this.husband,
    this.wife,
    this.mother,
    this.father,
    this.sons,
    this.daughters,
    this.son,
    this.daughter,
    this.remaining,
    this.totalAmount,
  });

  @override
  String toString() {
    return 'Result(husband: $husband, wife: $wife, mother: $mother, father: $father, sons: $sons, daughters: $daughters, son: $son, daughter: $daughter, remaining: $remaining, totalAmount: $totalAmount)';
  }

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
    husband: json['husband'] != null ? double.parse(json['husband'].toString()) : null,
    wife: json['wife'] != null ? double.parse(json['wife'].toString()) : null,
    mother: json['mother'] != null ? double.parse(json['mother'].toString()) : null,
    father: json['father'] != null ? double.parse(json['father'].toString()) : null,
    daughters: json['daughters'] != null ? double.parse(json['daughters'].toString()) : null,
    sons: json['sons'] != null ? double.parse(json['sons'].toString()) : null,
    son: json['son'] != null ? double.parse(json['son'].toString()) : null,
    daughter: json['daughter'] != null ? double.parse(json['daughter'].toString()) : null,
    remaining: json['remaining'] != null ? double.parse(json['remaining'].toString()) : null,
    totalAmount: json['totalAmount'] != null ? double.parse(json['totalAmount'].toString()) : null,
  );

  Map<String, dynamic> toJson() => {
    'husband': husband,
    'wife': wife,
    'mother': mother,
    'father': father,
    'sons': sons,
    'daughters': daughters,
    'son': son,
    'daughter': daughter,
    'remaining': remaining,
    'totalAmount': totalAmount,
  };

  ResultModel copyWith({
    double? husband,
    double? wife,
    double? mother,
    double? father,
    double? sons,
    double? daughters,
    double? son,
    double? daughter,
    double? remaining,
    double? totalAmount,
  }) {
    return ResultModel(
      husband: husband ?? this.husband,
      wife: wife ?? this.wife,
      mother: mother ?? this.mother,
      father: father ?? this.father,
      sons: sons ?? this.sons,
      daughters: daughters ?? this.daughters,
      son: son ?? this.son,
      daughter: daughter ?? this.daughter,
      remaining: remaining ?? this.remaining,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
