import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/api_service/api_consumer.dart';
import 'package:inheritance/core/api_service/end_points.dart';
import 'package:inheritance/core/enums/response_type.dart';
import 'package:inheritance/core/heleprs/print_helper.dart';
import 'package:inheritance/core/heleprs/snackbar.dart';
import 'package:inheritance/core/models/api_response_model.dart';
import 'package:inheritance/core/service_locator/service_locator.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/models/result_model.dart';

class ResultCubit extends Cubit<ApiResponseModel<ResultModel>> {
  final ApiConsumer api = serviceLocator();
  ResultCubit() : super(ApiResponseModel(response: ResponseEnum.initial));
  Future<void> fetchResult(InheritanceState inheritanceState) async {
    final t = prt('fetchResult - ResultCubit');
    try {
      emit(state.copyWith(response: ResponseEnum.loading));
      final response = await api.post(EndPoint.inherit, data: inheritanceState.toRequestBody());
      final resultModel = ResultModel.fromJson(response['data']);
      emit(pr(state.copyWith(response: ResponseEnum.success, data: resultModel), t));
    } catch (e) {
      String errorMsg = 'Unkwon Error Occured';
      if (e is DioException) {
        errorMsg = jsonEncode(e.response?.data ?? 'Unkwon Error Occured');
      }
      showSnackbar('Server Error', errorMsg, true);
      emit(
        pr(state.copyWith(response: ResponseEnum.failed, errorMessage: errorMsg, data: null), t),
      );
    }
  }
}

final _exampleRequest = {
  "totalAmount": 20000.0,
  "isWasiyat": true,
  "wasiyatAmount": 10.0,
  "isLoan": true,
  "loanAmount": 10.0,
  "isUnborn": false,
  "yourRelation": "husband",
  "deceasedGender": null,
  "maleDeceasedStatus": null,
  "femaleDeceasedStatus": null,
  "isFatherAlive": true,
  "isMotherAlive": true,
  "isSons": true,
  "isDaughters": true,
  "sonsCount": 1,
  "daughtersCount": 1,
  "grandchildrenInfo": [
    {
      "gender": "male",
      "status": "alive",
      "grandChildrenMalesCount": 1,
      "grandChildrenFemalesCount": 0,
    },
    {
      "gender": "female",
      "status": "alive",
      "grandChildrenMalesCount": 0,
      "grandChildrenFemalesCount": 1,
    },
  ],
  "isSisters": true,
  "sistersCount": 1,
  "isBrothers": true,
  "brothersCount": 1,
};
