import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/views/job_view/job_model/PersonModel.dart';
import 'package:graduation_project_admin/views/job_view/job_model/UserModel.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';
import '../../../utils/dio_helper.dart';
import '../../login_view/loginMOdel/AdminModel.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  static AdminCubit get(context) => BlocProvider.of(context);
  List<AdminModel> ListAdminModel = [];
  AdminModel? adminModel;
  var box = Hive.box(boxName);

  getAllAdmins() async {
    emit(AdminLoading());
    ListAdminModel = [];

    // Retrieve the admin ID from local storage
    var admin = await box.get('adminId');
    print(admin);

    try {
      // Make a GET request to fetch admins from the server
      final response = await DioHelper.getData(url: "/Admins");

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // If the response is successful, process the data
        ListAdminModel = (response.data as List)
            .where((e) => e['adminId'] != admin) // Exclude logged-in admin
            .map((e) => AdminModel.fromJson(e)) // Convert the response data to AdminModel objects
            .toList();

        emit(AdminLoaded()); // Emit AdminLoaded state after processing the data
      } else {
        // If the response status code is not 200, print the status code and emit AdminError state
        print(response.statusCode);
        emit(AdminError());
      }
    } catch (error) {
      // If an error occurs during the request, emit AdminError state
      emit(AdminError());
    }
  }



  editAdmin({ int? userId, String? qualification, String? roles, int? permission,int?admin}) async {
    emit(AdminLoading());
    try {
      final response = await DioHelper.putData(url: "/Admins", data: {
        "userId": userId,
        "qualification": qualification,
        "adminId": admin,
        "roles": roles,
        "permission": permission
      });
      if (response.statusCode == 200||response.statusCode == 201||response.statusCode == 204) {
        adminModel = AdminModel.fromJson(response.data);
        await getAllAdmins();
        emit(AdminLoaded());
      } else {
        print(response.statusCode);
        print (response.data);
        print (response.statusMessage);
        emit(AdminError());
      }
    } catch (error) {
      print(error);

      emit(AdminError());
    }
  }

  PersonModel? personModel;
  UserModel? userModel;

  Future<void> addPerson(PersonModel? personModel) async {
    emit(AddPersonLoading());

    var headers = {
      'Content-Type': 'application/json',
    };

    var data = json.encode({
      "firstName": personModel!.firstName,
      "lastName": personModel.lastName,
      "gender": personModel.gender,
      "address": personModel.address,
      "phone1": personModel.phone1 ?? '', // Ensure phone1 is not null
      "phone2": personModel.phone2 ?? '', // Ensure phone2 is not null
      "dateOfBirth": personModel.dateOfBirth,
      "email": personModel.email,
    });

    try {
      var dio = Dio();
      var response = await dio.post(
        'http://arshdny.runasp.net/api/People',
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(json.encode(response.data));
        personModel = PersonModel.fromJson(response.data);
        this.personModel = personModel; // Update the cubit's personModel
        emit(AddPersonLoaded(personModel));
      } else {
        print("Error message: ${response.statusMessage}");
        print("Error message: ${response.statusCode}");
        emit(AddPersonError());
      }
    } catch (error) {
      print("Exception: $error");
      emit(AddPersonError());
    }
  }

  Future addUser({int? personId, String? userName, String? passward}) async {
    emit(AddUserLoading());
    var data = {
      "personId": personId,
      "userName": userName,
      "password": passward,
      "isBlocked": false,
    };
    print("addUser request data: $data"); // Log request data

    try {
      var request = await DioHelper.postData(url: "/Users", data: data);
      if (request.statusCode == 200 || request.statusCode == 201) {
        userModel = UserModel.fromJson(request.data);
        emit(AddUserLoaded());
      } else {
        print("Error: ${request.data}"); // Log response body
        emit(AddUserError());
      }
    } catch (error) {
      print("Exception: $error"); // Log the error
      emit(AddUserError());
    }
  }

  Future addAdmin({String? qualification, String? roles, int? permission, int? userId}) async {
    var adminId = await box.get('adminId');
    emit(AddAdminLoading());
    var data = {
      "qualification": qualification,
      "roles": roles,
      "permission": permission,
      "userId": userId,
    };
    var query = {
      "CurrentAdminID": adminId,
    };
    print("addAdmin request data: $data"); // Log request data

    try {
      var request = await DioHelper.postData(url: "/Admins", data: data, query: query);
      if (request.statusCode == 200 || request.statusCode == 201) {
        adminModel = AdminModel.fromJson(request.data);
        emit(AddAdminLoaded());
      } else {
        print("Error: ${request.data}"); // Log response body
        emit(AddAdminError());
      }
    } catch (error) {
      print("Exception: $error"); // Log the error
      emit(AddAdminError());
    }
  }

  deleteAdmin(int? id) async {
    emit(DeleteAdminLoading());
    try {
      final response = await DioHelper.deleteData(url: "/Admins/$id");
      if (response.statusCode == 200|| response.statusCode == 204|| response.statusCode == 201) {
        await getAllAdmins();
        emit(DeleteAdminLoaded());
      } else {
        print(response.statusCode);
        emit(DeleteAdminError());
      }
    } catch (error) {
      print(error);
      emit(DeleteAdminError());
    }
  }

  // Future addPerson(PersonModel? personModel) async {
  //   emit(AddPersonLoading());
  //   var data = {
  //     "firstName": personModel!.firstName,
  //     "lastName": personModel.lastName,
  //     "gender": personModel.gender,
  //     "address": personModel.address,
  //     "phone1": personModel.phone1,
  //     "phone2": personModel.phone2 ?? personModel.phone1, // Ensure phone2 is provided
  //     "dateOfBirth": personModel.dateOfBirth,
  //     "email": personModel.email,
  //   };
  //   print("addPerson request data: $data"); // Log request data
  //
  //   try {
  //     var request = await DioHelper.postData(url: "/People", data: data);
  //     if (request.statusCode ==200) {
  //       print(json.encode(request.data));
  //       personModel = PersonModel.fromJson(request.data);
  //       this.personModel = personModel; // Update the cubit's personModel
  //       emit(AddPersonLoaded(personModel));
  //     } else {
  //       print("Error massage: ${request.statusMessage}"); // Log response body
  //       emit(AddPersonError());
  //     }
  //   } catch (error) {
  //     print("Exception: $error"); // Log the error
  //     emit(AddPersonError());
  //   }
  // }
}
