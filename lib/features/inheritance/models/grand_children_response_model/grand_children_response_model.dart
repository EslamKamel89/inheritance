import 'share.dart';

class GrandChildrenResponseModel {
  String? gender;
  String? status;
  int? grandChildrenMalesCount;
  int? grandChildrenFemalesCount;
  Share? share;
  double? totalShare;

  GrandChildrenResponseModel({
    this.gender,
    this.status,
    this.grandChildrenMalesCount,
    this.grandChildrenFemalesCount,
    this.share,
    this.totalShare,
  });

  factory GrandChildrenResponseModel.fromJson(Map<String, dynamic> json) {
    return GrandChildrenResponseModel(
      gender: json['gender'] as String?,
      status: json['status'] as String?,
      grandChildrenMalesCount: json['grandChildrenMalesCount'] as int?,
      grandChildrenFemalesCount: json['grandChildrenFemalesCount'] as int?,
      share: json['share'] == null ? null : Share.fromJson(json['share'] as Map<String, dynamic>),
      totalShare: (json['totalShare'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'gender': gender,
    'status': status,
    'grandChildrenMalesCount': grandChildrenMalesCount,
    'grandChildrenFemalesCount': grandChildrenFemalesCount,
    'share': share?.toJson(),
    'totalShare': totalShare,
  };
}
