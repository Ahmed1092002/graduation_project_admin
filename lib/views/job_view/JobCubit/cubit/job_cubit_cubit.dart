import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project_admin/utils/dio_helper.dart';
import 'package:graduation_project_admin/views/job_view/job_model/JobModel.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'job_cubit_state.dart';

class JobCubit extends Cubit<JobCubitState> {
  JobCubit() : super(JobCubitInitial());
  static JobCubit get(context) => BlocProvider.of(context);

  List<JobModel>? jobModel;

  getJobs() async {
    emit(GetJobLoading());
    try {
      final response = await DioHelper.getData(url: "/Jobs");
      if (response.statusCode == 200) {
        print(response.data);
        jobModel =
            (response.data as List).map((e) => JobModel.fromJson(e)).toList();
        emit(GetJobSuccess());
      } else {
        print(response.statusCode);
        emit(GetJobError());
      }
    } catch (error) {
      emit(GetJobError());
    }
  }

  AddJob({
    String? jobName,
    String? description,
    int? salary,
    String? country,
    String? location,
    int? yearsOfExperience,
  }) async {
    Map<String, dynamic> addjob = {
      "jobName": jobName,
      "description": description,
      "salary": salary,
      "country": country,
      "location": location,
      "publishDate": DateTime.now(),
      "yearsOfExperience": yearsOfExperience,
      "isView": true
    };

    emit(AddJobLoading());
    try {
      final response = await DioHelper.postData(url: "/Jobs", query: addjob);
      if (response.statusCode == 200) {
        print(response.data);

        emit(AddJobsuccses());
      } else {
        print(response.statusCode);
        emit(AddJobError());
      }
    } catch (error) {
      emit(AddJobError());
    }
  }
}
