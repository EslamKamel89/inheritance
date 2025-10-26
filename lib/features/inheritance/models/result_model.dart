class ResultModel {
  Map<String, dynamic>? data;
  ResultModel({this.data});

  ResultModel copyWith({Map<String, dynamic>? data}) {
    return ResultModel(data: data ?? this.data);
  }

  Map<String, dynamic> toJson() {
    return data ?? {};
  }

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(data: json);
  }

  @override
  String toString() => 'ResultModel(data: $data)';
}
