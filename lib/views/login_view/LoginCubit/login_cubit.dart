import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/views/job_view/job_model/UserModel.dart';
import 'package:graduation_project_admin/views/login_view/loginMOdel/AdminModel.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';
import '../../../utils/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);


  var box = Hive.box(boxName);
  AdminModel? userModel;

  login({String? userName, String? password}) async {
    emit(LoginLoading());

    try {
      final request = await DioHelper.getData(
          url: '/Admins/AdminLogin?userName=$userName&password=$password');


      if (request.statusCode == 200) {
        userModel = AdminModel.fromJson(request.data);
        if (userModel != null) {
          box.put('userName', userModel!.userName);
          box.put('adminId', userModel!.adminId);
          box.put('userId', userModel!.userId);
          box.put('permission', userModel!.permission);
          box.put('roles', userModel!.roles);
        }

        emit(LoginSuccess());
      } else {
        emit(LoginFailure());
      }
    } catch (e) {
      emit(LoginFailure());
    }
  }
}