import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/utils/dio_helper.dart';
import 'package:graduation_project_admin/views/dashboard_view/class/ChartDataColumn.dart';
import 'package:graduation_project_admin/views/dashboard_view/class/chartDataDoughnut%20Chart.dart';
import 'package:graduation_project_admin/views/dashboard_view/model/HelpingRequestModel.dart';
import 'package:graduation_project_admin/views/dashboard_view/model/NumberOfUsersPerMonthModel.dart';
import 'package:meta/meta.dart';

import '../model/CountPerJobModel.dart';
import '../model/RefugeesByCountryModel.dart';
import '../model/feedback_model.dart';

part 'dashbored_state.dart';

class DashboredCubit extends Cubit<DashboredState> {
  DashboredCubit() : super(DashboredInitial());

  static DashboredCubit get(context) => BlocProvider.of(context);
  int? refugeeCount;
  List <CountPerJobModel> ? countPerJobModel;
  List <ChartData>? chartData;

  getNumberOfRefugees() async {
    emit(NumberofRefugeeLoading());

    try {
      final response = await DioHelper.getData(
          url: '/Refugees/NumberOfRefugees');
      if (response.statusCode == 200) {
        final refugeeCount = int.parse(response.data.toString());
        emit(NumberofRefugeeSuccess(refugeeCount: refugeeCount));
      } else {
        emit(NumberofRefugeeError(errorMessage: response.data.toString()));
      }
    } catch (error) {
      emit(NumberofRefugeeError(errorMessage: error.toString()));
    }
  }

  List <RefugeesByCountryModel> ? refugeesByCountryModel;

  getRefugeesByCountry() async {
    emit(NumberofRefugeeLoading());
    try {
      final response = await DioHelper.getData(
          url: '/Refugees/RefugeesByCountry');
      if (response.statusCode == 200) {
        refugeesByCountryModel = (response.data as List)
            .map((e) => RefugeesByCountryModel.fromJson(e))
            .toList();
        chartData = refugeesByCountryModel!.map((e) =>
        ChartData()
          ..x = e.countryName
          ..y = e.count
          ..color = generateRandomColor()
        ).toList();
        emit(NumberofRefugeeSuccess(
            refugeeCount: refugeesByCountryModel!.length));
      } else {
        emit(NumberofRefugeeError(errorMessage: response.data.toString()));
      }
    } catch (error) {
      emit(NumberofRefugeeError(errorMessage: error.toString()));
    }
  }


  countPerJob() async {
    emit(CountPerJobLoading());
    try {
      final response = await DioHelper.getData(url: '/Jobs/CountPerJob');
      if (response.statusCode == 200) {
        countPerJobModel = (response.data as List)
            .map((e) => CountPerJobModel.fromJson(e))
            .toList();
        emit(CountPerJobSuccess(countPerJobModel: countPerJobModel!));
      } else {
        emit(CountPerJobError(errorMessage: response.data.toString()));
      }
    } catch (error) {
      emit(CountPerJobError(errorMessage: error.toString()));
    }
  }

  Color generateRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255, // Alpha (fully opaque)
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  List<NumberOfUsersPerMonthModel> ? numberOfUsersPerMonthModel;
  List<ChartDataColumn> ? chartDataColumn;

  getNumberOfUsersPerMonth() async {
    emit(NumberOfUsersPerMonthLoading());
    try {
      final response = await DioHelper.getData(
          url: '/Users/NumberOfUsersPerMonth');
      if (response.statusCode == 200) {
        print(response.data);
        numberOfUsersPerMonthModel = (response.data as List)
            .map((e) => NumberOfUsersPerMonthModel.fromJson(e))
            .toList();
        chartDataColumn = numberOfUsersPerMonthModel!.map((e) =>
            ChartDataColumn(
              e.yearMonth!,
              e.count!,
            )).toList();
        emit(NumberOfUsersPerMonthSuccess(
            numberOfUsersPerMonthModel: numberOfUsersPerMonthModel!));
      } else {
        emit(
            NumberOfUsersPerMonthError(errorMessage: response.data.toString()));
      }
    } catch (error) {
      emit(NumberOfUsersPerMonthError(errorMessage: error.toString()));
    }
  }


  Future<void> fetchRefugeeData() async {
    emit(DashboredLoading()); // Emit a single loading state for both operations


    try {
      // Fetch refugees by country
      final response1 = await DioHelper.getData(
          url: '/Refugees/RefugeesByCountry');
      if (response1.statusCode == 200) {
        refugeesByCountryModel = (response1.data as List)
            .map((e) => RefugeesByCountryModel.fromJson(e))
            .toList();
        chartData = refugeesByCountryModel!.map((e) =>
        ChartData()
          ..x = e.countryName
          ..y = e.count
          ..color = generateRandomColor()
        ).toList();
      } else {
        emit(DashboredError(errorMessage: response1.data.toString()));
        return; // Stop if the first request fails
      }

      // Fetch total number of refugees
      final response2 = await DioHelper.getData(
          url: '/Refugees/NumberOfRefugees');
      if (response2.statusCode == 200) {
        refugeeCount = int.parse(response2.data.toString());
        emit(DashboredSuccess()); // Emit success state with all data
      } else {
        emit(DashboredError(errorMessage: response2.data.toString()));
      }
    } catch (error) {
      emit(DashboredError(errorMessage: error.toString()));
    }
  }

  List <FeedbackModel> ? feedbackModel;
List<HelpingRequestModel> ? helpingRequestModel;
  getFeedback() async {
    emit(GetFeedbackLoading());
    try {
      final response = await DioHelper.getData(url: '/Feedbacks');
      if (response.statusCode == 200) {
        feedbackModel = (response.data as List)
            .map((e) => FeedbackModel.fromJson(e))
            .toList();

        emit(GetFeedbackSuccess());
      } else {
        emit(
            GetFeedbackError(errorMessage: response.data.toString()));
      }
    } catch (error) {
      emit(GetFeedbackError(errorMessage: error.toString()));
    }
  }
  getHelpingRequest() async {
    emit(GetHelpingRequestLoading());
    try {
      final response = await DioHelper.getData(url: '/HelpingRefugee');
      if (response.statusCode == 200) {

        helpingRequestModel = (response.data as List)
            .map((e) => HelpingRequestModel.fromJson(e))
            .toList();
        print(helpingRequestModel!.length);

        emit(GetHelpingRequestSuccess());
      } else {
        emit(
            GetHelpingRequestError(errorMessage: response.data.toString()));
      }
    } catch (error) {
      emit(GetHelpingRequestError(errorMessage: error.toString()));
    }
  }
}