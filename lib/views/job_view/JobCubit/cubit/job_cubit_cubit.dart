import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project_admin/utils/dio_helper.dart';
import 'package:graduation_project_admin/views/job_view/job_model/JobModel.dart';
import 'package:graduation_project_admin/views/job_view/job_model/PersonModel.dart';
import 'package:graduation_project_admin/views/job_view/job_model/RefugeeModel.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../manage_user_view/CountryModel/CountryModel.dart';
import '../../job_model/JobAppliedModel.dart';
import '../../job_model/UserModel.dart';

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
        jobModel = [];
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

  addJob(JobModel jobModel) async {
    emit(AddJobLoading());
    var headers = {
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "jobName": jobModel.jobName,
      "description": jobModel.description,
      "salary": jobModel.salary,
      "country": jobModel.country,
      "location": jobModel.location,
      "publishDate": jobModel.publishDate,
      "yearsOfExperience": jobModel.yearsOfExperience,
      "isView": jobModel.isView
    });
    var dio = Dio();
    var response = await dio.request(
      'http://arshdny.runasp.net/api/Jobs',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200|| response.statusCode ==201|| response.statusCode ==204) {
      print(json.encode(response.data));
      emit(AddJobSuccess());
    }
    else {
      print(response.statusMessage);
      emit(AddJobError());
    }
  }


  editJob(JobModel jobModel) async {
    emit(AddJobLoading());
    var headers = {
      'Content-Type': 'application/json'
    };


    var data = json.encode({
      "jobId": jobModel.jobId,
      "jobName": jobModel.jobName,
      "description": jobModel.description,
      "salary": jobModel.salary,
      "country": jobModel.country,
      "location": jobModel.location,
      "publishDate": jobModel.publishDate,
      "yearsOfExperience": jobModel.yearsOfExperience,
      "isView": jobModel.isView
    });
    var dio = Dio();

    var response = await dio.request(
      'http://arshdny.runasp.net/api/Jobs',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      emit(AddJobSuccess());
    }
    else {
      print(response.statusMessage);
      emit(AddJobError());
    }
  }

  deleteJob(int id) async {
    emit(AddJobLoading());
    var headers = {
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    var response = await dio.request(
      'http://arshdny.runasp.net/api/Jobs/$id',
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print(json.encode(response.data));
      emit(AddJobSuccess());
    }
    else {
      print(response.statusMessage);
      emit(AddJobError());
    }
  }
  changeJobStatus(int id,bool state) async {
    emit(AddJobLoading());
    var headers = {
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    var response = await dio.request(
      'http://arshdny.runasp.net/api/Jobs/EditIsViewJobStatus/$id?isView=$state',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
    );

    if (response.statusCode == 200|| response.statusCode == 204) {
      print(json.encode(response.data));
      emit(AddJobSuccess());
    }
    else {
      print(response.statusMessage);
      emit(AddJobError());
    }
  }


  Future<void> filterJobs({
    required String jobName,
    required String description,
    required int minSalary,
    required int maxSalary,
    required int specificSalary,
    required String address,
    required String location,
    required String minPublishDate,
    required String maxPublishDate,
    required String specificPublishDate,
    required int yearsOfExperience,
  }) async {
    try {
      emit(GetJobLoading());

      Map<String, dynamic> queryParameters = {};

      if (jobName.isNotEmpty) queryParameters['jobName'] = jobName;
      if (description.isNotEmpty) queryParameters['description'] = description;
      if (minSalary > 0) queryParameters['minSalary'] = minSalary;
      if (maxSalary > 0) queryParameters['maxSalary'] = maxSalary;
      if (specificSalary > 0)
        queryParameters['specificSalary'] = specificSalary;
      if (address.isNotEmpty) queryParameters['address'] = address;
      if (location.isNotEmpty) queryParameters['location'] = location;
      if (minPublishDate.isNotEmpty)
        queryParameters['minPublishDate'] = minPublishDate;
      if (maxPublishDate.isNotEmpty)
        queryParameters['maxPublishDate'] = maxPublishDate;
      if (specificPublishDate.isNotEmpty)
        queryParameters['specificPublishDate'] = specificPublishDate;
      if (yearsOfExperience > 0)
        queryParameters['yearsOfExperience'] = yearsOfExperience;

      print('Query Parameters: $queryParameters');

      final response = await DioHelper.getData(
        url: '/Jobs/FilterJobs',
        query: queryParameters,
      );

      if (response.statusCode == 200) {
        print(response.data);
        jobModel =
            (response.data as List).map((e) => JobModel.fromJson(e)).toList();
        emit(GetJobSuccess());
      } else {
        emit(GetJobError());
        throw Exception('Failed to fetch jobs: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetJobError());
      throw Exception('Error fetching jobs: $e');
    }
  }

  List <RefugeeModel>? refugeeModel;
  JobAppliedModel? jobAppliedModel;
  List<JobAppliedModel>? jobAppliedModelList;

  getAllRefugeesAppliedOnThisJob({int ? id}) async {
    emit(GetAllRefugeesAppliedOnThisJobLoading());
    try {
      final response = await DioHelper.getData(
          url: "/RefugeeAppliedJobs/GetAllRefugeesAppliedOnThisJob?JobID=$id");
      if (response.statusCode == 200) {
        refugeeModel =
            (response.data as List)
                .map((e) => RefugeeModel.fromJson(e))
                .toList();
        // for (var refugee in refugeeModel!) {
        //   var refuggeApplied =await getAllAppliedjobs(refugeeId: refugee.refugeeId!);
        //   if (refuggeApplied != null) {
        //     jobAppliedModelList?.add(refuggeApplied);
        //   }
        //
        // }

        emit(GetAllRefugeesAppliedOnThisJobSuccess());
      } else {
        print(response.statusCode);
        emit(GetAllRefugeesAppliedOnThisJobError());
      }
    } catch (error) {
      emit(GetAllRefugeesAppliedOnThisJobError());
    }
  }




//    getAllAppliedjobs(
//   {
//     required int refugeeId,
//
// }
//       ) async {
//     try {
//       emit(getAllAppliedjobsLoading());
//       var response = await DioHelper.getData(url: '/RefugeeAppliedJobs/$refugeeId');
//       if (response.statusCode == 200) {
//
//         jobAppliedModel = JobAppliedModel.fromJson(response.data);
//
//
//         emit(getAllAppliedjobsSuccess());
//         return jobAppliedModel;
//       } else {
//         emit(getAllAppliedjobsError());
//       }
//     } catch (e) {
//       print(e.toString());
//       emit(getAllAppliedjobsError());
//     }
//   }

  RefugeeModel? refugeeModeldata;
  PersonModel? personModel;

  fetchDataAndProcess({int?id}) async {
    // Create a Dio instance
    Dio dio = Dio();
    emit(GetAllRefugeesAppliedOnThisJobLoading());

    try {
      // Make the first API request to get user data
      Response userResponse = await dio.get(
          'http://arshdny.runasp.net/api/Users/$id');

      if (userResponse.statusCode == 200) {
        // Parse the response JSON
        final userData = userResponse.data;
        final personId = userData['personId'];

        // Make the second API request to get person data
        Response personResponse = await dio.get(
            'http://arshdny.runasp.net/api/People/$personId');

        if (personResponse.statusCode == 200) {
          // Parse the response JSON
          final personData = personResponse.data;
          personModel = PersonModel.fromJson(personData);
          emit(GetAllRefugeesAppliedOnThisJobSuccess());

          // Process the person data as needed

        } else {
          print(
              'Failed to load person data. Error ${personResponse.statusCode}');
          emit(GetAllRefugeesAppliedOnThisJobError());
        }
      } else {
        print('Failed to load user data. Error ${userResponse.statusCode}');
        emit(GetAllRefugeesAppliedOnThisJobError());
      }
    } catch (e) {
      print('Error: $e');
      emit(GetAllRefugeesAppliedOnThisJobError());
    }
  }

  getRefugeeById(int id) async {
    emit(GetRefugeeByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/Refugees/$id");
      if (response.statusCode == 200) {
        refugeeModeldata = RefugeeModel.fromJson(response.data);

        await getCountryById(refugeeModeldata!.countryId!);
        await getUserById(refugeeModeldata!.userId!);
        await getPersonById(userModel!.personId!);


        emit(GetRefugeeByIdLoaded(
          refugeeModeldata!,

        ));
      } else {
        print(response.statusCode);
        emit(GetRefugeeByIdError("Error"));
      }
    } catch (error) {
      emit(GetRefugeeByIdError("Error"));
    }
  }

  UserModel? userModel;


  getUserById(int id) async {
    emit(GetUserByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/Users/$id");
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(response.data);

        emit(GetUserByIdLoaded());
      } else {
        print(response.statusCode);
        emit(GetUserByIdError("Error"));
      }
    } catch (error) {
      emit(GetUserByIdError("Error"));
    }
  }

  getPersonById(int id) async {
    emit(GetPersonByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/People/$id");
      if (response.statusCode == 200) {
        personModel = PersonModel.fromJson(response.data);
        emit(GetPersonByIdLoaded(
          personModel!,
        ));
      } else {
        print(response.statusCode);
        emit(GetPersonByIdError("Error"));
      }
    } catch (error) {
      emit(GetPersonByIdError("Error"));
    }
  }

  CountryModel? countryModel;

  getCountryById(int id) async {
    emit(GetCountryByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/Countries/$id");
      if (response.statusCode == 200) {
        countryModel = CountryModel.fromJson(response.data);
        emit(GetCountryByIdLoaded(
          response.data,
        ));
      } else {
        print(response.statusCode);
        emit(GetCountryByIdError("Error"));
      }
    } catch (error) {
      emit(GetCountryByIdError("Error"));
    }
  }

  AcceptOrRejectRefugee({int ? refugeeid,
    int ? jobid,
    int ? jobstatus
  }) async {
    emit(AcceptOrRejectRefugeeLoading());
    try {
      var response = await DioHelper.putData(
          url: "/RefugeeAppliedJobs?refugeeId=$refugeeid&jobId=$jobid&jobStatus=$jobstatus");
      if (response.statusCode == 200 || response.statusCode == 204) {
        emit(AcceptOrRejectRefugeeSuccess());
      } else {
        print(response.statusCode);
        emit(AcceptOrRejectRefugeeError());
      }
    } catch (error) {
      emit(AcceptOrRejectRefugeeError());
    }
  }



}
