import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/api_service/api_consumer.dart';
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
      final response = await api.post(
        'http://inherit.safqauae.com/api/inherit',
        data: inheritanceState.toRequestBody(),
      );
      // response['data']['GrandChildren'] = [
      //   {
      //     "gender": "male",
      //     "status": "dead",
      //     "grandChildrenMalesCount": 2,
      //     "grandChildrenFemalesCount": 3,
      //     "share": {"men": 187.50000000000003, "women": 262.49999999999994},
      //     "totalShare": 450,
      //   },
      //   {
      //     "gender": "male",
      //     "status": "dead",
      //     "grandChildrenMalesCount": 0,
      //     "grandChildrenFemalesCount": 1,
      //     "share": {"men": 0, "women": 450},
      //     "totalShare": 450,
      //   },
      //   {
      //     "gender": "female",
      //     "status": "alive",
      //     "grandChildrenMalesCount": 0,
      //     "grandChildrenFemalesCount": 1,
      //     "totalShare": 450,
      //   },
      //   {
      //     "gender": "female",
      //     "status": "dead",
      //     "grandChildrenMalesCount": 2,
      //     "grandChildrenFemalesCount": 0,
      //     "share": {"men": 450, "women": 0},
      //     "totalShare": 450,
      //   },
      // ];
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
