import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/views/manage_user_view/CountryModel/CountryModel.dart';
import 'package:meta/meta.dart';

import '../../../utils/dio_helper.dart';
import '../../job_view/job_model/PersonModel.dart';
import '../../job_view/job_model/RefugeeModel.dart';
import '../../job_view/job_model/UserModel.dart';

part 'refugee_state.dart';

class RefugeeCubit extends Cubit<RefugeeState> {
  RefugeeCubit() : super(RefugeeInitial());
  static RefugeeCubit get(context) => BlocProvider.of(context);
  List<RefugeeModel> ListrefugeeModel = [];
  RefugeeModel? refugeeModel;
  getAllRefugees() async {
    emit(RefugeeLoading());
    try {
      final response = await DioHelper.getData(url: "/Refugees");
      if (response.statusCode == 200) {
        ListrefugeeModel =
            (response.data as List).map((e) => RefugeeModel.fromJson(e)).toList();
        emit(RefugeeLoaded(
          ListrefugeeModel,
        ));
      } else {
        print(response.statusCode);
        emit(RefugeeError("Error"));
      }
    } catch (error) {
      emit(RefugeeError("Error"));
    }
  }

getRefugeeById(int id) async {
    emit(GetRefugeeByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/Refugees/$id");
      if (response.statusCode == 200) {
        refugeeModel = RefugeeModel.fromJson(response.data);
        print (refugeeModel!.cv);

await getCountryById(refugeeModel!.countryId!);
await getUserById(refugeeModel!.userId!);
await        getPersonById(userModel!.personId! );


        emit(GetRefugeeByIdLoaded(
          refugeeModel!,

        ));
      } else {
        print(response.statusCode);
        emit(GetRefugeeByIdError("Error"));
      }
    } catch (error) {
      emit(GetRefugeeByIdError("Error"));
    }
  }
  PersonModel? personModel;
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

  blockUser(int id) async {
    emit(BlockUserLoading());
    try {
      final response = await DioHelper.putData(url: "/Users/BlockUser/$id");
      if (response.statusCode == 200|| response.statusCode == 204|| response.statusCode == 201) {

        emit(BlockUserLoaded());
      } else {
        print(response.statusCode);

        emit(BlockUserError());
      }
    } catch (error) {

      emit(BlockUserError());
    }
  }
  unblockUser(int id) async {
emit(UnblockUserLoading());
    try {
      final response = await DioHelper.putData(url: "/Users/UnBlockUser/$id");
      if (response.statusCode == 200 || response.statusCode == 204 || response.statusCode == 201) {
    emit(UnblockUserLoaded());
      } else {
        print(response.statusCode);
        emit(UnblockUserError());
      }
    } catch (error) {
      emit(UnblockUserError());
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


  //
  // fetchDataAndProcess( {int?id}) async {
  //   // Create a Dio instance
  //   Dio dio = Dio();
  //   emit(GetDataRefugeesLooding());
  //
  //   try {
  //     // Make the first API request to get user data
  //     Response userResponse = await dio.get('http://arshdny.runasp.net/api/Users/$id');
  //
  //     if (userResponse.statusCode == 200) {
  //       // Parse the response JSON
  //       final userData = userResponse.data;
  //       final personId = userData['personId'];
  //
  //       // Make the second API request to get person data
  //       Response personResponse = await dio.get('http://arshdny.runasp.net/api/People/$personId');
  //
  //       if (personResponse.statusCode == 200) {
  //         // Parse the response JSON
  //         final personData = personResponse.data;
  //         personModel = PersonModel.fromJson(personData);
  //         emit(GetDataRefugeesLooding());
  //
  //         // Process the person data as needed
  //
  //       } else {
  //         print('Failed to load person data. Error ${personResponse.statusCode}');
  //         emit(GetAllRefugeesError());
  //
  //       }
  //     } else {
  //       print('Failed to load user data. Error ${userResponse.statusCode}');
  //       emit(GetAllRefugeesError());
  //
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     emit(GetAllRefugeesError());
  //
  //   }
  // }

}
