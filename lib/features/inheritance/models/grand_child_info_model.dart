// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:inheritance/features/inheritance/enums/gender_enum.dart';

class GrandChildrenInfoModel {
  bool submitted;
  List<GrandChildInfoModel> grandChildren;
  GrandChildrenInfoModel({required this.submitted, required this.grandChildren});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'submitted': submitted,
      'grandChildren': grandChildren.map((x) => x.toJson()).toList(),
    };
  }

  List<Map<String, dynamic>> toRequestBody() {
    return grandChildren.map((x) => x.toJson()).toList();
  }

  @override
  String toString() =>
      'GrandChildrenInfoModel(submitted: $submitted, grandChildren: $grandChildren)';
}

class GrandChildInfoModel {
  GenderEnum? gender;
  String? status;
  int? grandChildrenMalesCount;
  int? grandChildrenFemalesCount;

  GrandChildInfoModel({
    this.gender,
    this.status,
    this.grandChildrenMalesCount,
    this.grandChildrenFemalesCount,
  });

  @override
  String toString() {
    return 'GrandChildInfoModel(gender: $gender, status: $status, grandChildrenMalesCount: $grandChildrenMalesCount, grandChildrenFemalesCount: $grandChildrenFemalesCount)';
  }

  Map<String, dynamic> toJson() => {
    'gender': gender,
    'status': status,
    'grandChildrenMalesCount': grandChildrenMalesCount,
    'grandChildrenFemalesCount': grandChildrenFemalesCount,
  };
}
