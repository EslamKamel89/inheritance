// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'inheritance_cubit.dart';

class InheritanceState {
  InheritanceEnum? currentStep;
  double? totalAmount;
  bool? isWasiyat;
  double? wasiyatAmount;
  bool? isLoan;
  double? loanAmount;
  bool? isUnborn;
  RelationEnum? yourRelation;
  GenderEnum? deceasedGender;
  bool? maleDeceasedStatus;
  bool? femaleDeceasedStatus;
  bool? isFatherAlive;
  bool? isMotherAlive;
  bool? isChildren;
  int? sonsCount;
  int? daughersCount;
  bool? isSisters;
  int? sistersCount;
  bool? isBrothers;
  int? brothersCount;
  InheritanceState({
    this.currentStep,
    this.totalAmount,
    this.isWasiyat,
    this.wasiyatAmount,
    this.isLoan,
    this.loanAmount,
    this.isUnborn,
    this.yourRelation,
    this.deceasedGender,
    this.maleDeceasedStatus,
    this.femaleDeceasedStatus,
    this.isFatherAlive,
    this.isMotherAlive,
    this.isChildren,
    this.sonsCount,
    this.daughersCount,
    this.isSisters,
    this.sistersCount,
    this.isBrothers,
    this.brothersCount,
  });

  InheritanceState copyWith({
    InheritanceEnum? currentStep,
    double? totalAmount,
    bool? isWasiyat,
    double? wasiyatAmount,
    bool? isLoan,
    double? loanAmount,
    bool? isUnborn,
    RelationEnum? yourRelation,
    GenderEnum? deceasedGender,
    bool? maleDeceasedStatus,
    bool? femaleDeceasedStatus,
    bool? isFatherAlive,
    bool? isMotherAlive,
    bool? isChildren,
    int? sonsCount,
    int? daughersCount,
    bool? isSisters,
    int? sistersCount,
    bool? isBrothers,
    int? brothersCount,
  }) {
    return InheritanceState(
      currentStep: currentStep ?? this.currentStep,
      totalAmount: totalAmount ?? this.totalAmount,
      isWasiyat: isWasiyat ?? this.isWasiyat,
      wasiyatAmount: wasiyatAmount ?? this.wasiyatAmount,
      isLoan: isLoan ?? this.isLoan,
      loanAmount: loanAmount ?? this.loanAmount,
      isUnborn: isUnborn ?? this.isUnborn,
      yourRelation: yourRelation ?? this.yourRelation,
      deceasedGender: deceasedGender ?? this.deceasedGender,
      maleDeceasedStatus: maleDeceasedStatus ?? this.maleDeceasedStatus,
      femaleDeceasedStatus: femaleDeceasedStatus ?? this.femaleDeceasedStatus,
      isFatherAlive: isFatherAlive ?? this.isFatherAlive,
      isMotherAlive: isMotherAlive ?? this.isMotherAlive,
      isChildren: isChildren ?? this.isChildren,
      sonsCount: sonsCount ?? this.sonsCount,
      daughersCount: daughersCount ?? this.daughersCount,
      isSisters: isSisters ?? this.isSisters,
      sistersCount: sistersCount ?? this.sistersCount,
      isBrothers: isBrothers ?? this.isBrothers,
      brothersCount: brothersCount ?? this.brothersCount,
    );
  }

  @override
  String toString() {
    return 'InheritanceState(currentStep: $currentStep, totalAmount: $totalAmount, isWasiyat: $isWasiyat, wasiyatAmount: $wasiyatAmount, isLoan: $isLoan, loanAmount: $loanAmount, isUnborn: $isUnborn, yourRelation: $yourRelation, deceasedGender: $deceasedGender, maleDeceasedStatus: $maleDeceasedStatus, femaleDeceasedStatus: $femaleDeceasedStatus, isFatherAlive: $isFatherAlive, isMotherAlive: $isMotherAlive, isChildren: $isChildren, sonsCount: $sonsCount, daughersCount: $daughersCount, isSisters: $isSisters, sistersCount: $sistersCount, isBrothers: $isBrothers, brothersCount: $brothersCount)';
  }
}
