import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../utils/dio_helper.dart';
import '../../dashboard_view/model/HelpingRequestModel.dart';

part 'recive_request_state.dart';

class ReciveRequestCubit extends Cubit<ReciveRequestState> {
  ReciveRequestCubit() : super(ReciveRequestInitial());

  static ReciveRequestCubit get(context) => BlocProvider.of(context);

  List<HelpingRequestModel> ? helpingRequestModel;

  getHelpingRequest() async {
    emit(GetHelpingRequestLoading());
    helpingRequestModel = [];
    try {
      final response = await DioHelper.getData(url: '/HelpingRefugee');
      if (response.statusCode == 200) {

        helpingRequestModel = (response.data as List)
            .map((e) => HelpingRequestModel.fromJson(e))
            .toList();
  // for (int i = 0; i < helpingRequestModel!.length; i++) {
  //   changeRequestStatus(
  //     requestId: helpingRequestModel![i].requestID,
  //     status: true,
  //   );
  // }

        emit(GetHelpingRequestSuccess());
      } else {
        emit(
            GetHelpingRequestError(errorMessage: response.data.toString()));
      }
    } catch (error) {
      emit(GetHelpingRequestError(errorMessage: error.toString()));
    }
  }


  changeRequestStatus({required int ?requestId,required bool ?status}) async {
    emit(ChangeRequestStatusLoading());
    try {
      final response = await DioHelper.putData(
          url: '/HelpingRefugee/EditRequestStatus/$requestId?RequestStatus=true',
          );
      if (response.statusCode == 200 || response.statusCode == 204) {
        await getHelpingRequest();
        emit(ChangeRequestStatusSuccess());
      } else {
        emit(
            ChangeRequestStatusError(errorMessage: response.data.toString()));
      }
    } catch (error) {
      emit(ChangeRequestStatusError(errorMessage: error.toString()));
    }
  }

  // fcmToken({
  //   String ?fcmTokenDevice,
  //   String ?title,
  //   String ?body,
  //   String ?text,
  //
  // })async{
  //
  //
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'key=AAAA6KXkzOk:APA91bFrhdHAUE5mI-ruovQ5mTYxvnU2OTM0kO6j6LBgURiGALM9BakFgT_xrILDVlK9BMjaC3ZC3pwiO52wlMKzIERXYzP0t9zul3hljKVaNSVXZyJk9--vJ25EKUmvKVFj-ld8BYQC'
  //   };
  //   var data = json.encode({
  //     "to": "$fcmTokenDevice",
  //     "notification": {
  //       "title": "$title",
  //       "text": "$text",
  //       "body": "$body",
  //       "sound": "default",
  //       "color": "#990000"
  //     },
  //     "priority": "high",
  //     "data": {
  //       "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //       "type": "COMMENT"
  //     }
  //   });
  //   var dio = Dio();
  //   var response = await dio.request(
  //     'https://fcm.googleapis.com/fcm/send',
  //     options: Options(
  //       method: 'POST',
  //       headers: headers,
  //     ),
  //     data: data,
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print(json.encode(response.data));
  //   }
  //   else {
  //     print(response.statusMessage);
  //   }
  //   // DioHelper.postData(
  //   //     url: 'fcm/send',
  //   //     data: {
  //   //       "to":"$fcmTokenDevice",
  //   //
  //   //       "notification": {
  //   //         "title": title,
  //   //         "text": text,
  //   //         "body": body,
  //   //         "sound": "default",
  //   //
  //   //         "color": "#990000"
  //   //       },
  //   //       "priority": "high",
  //   //       "data": {
  //   //         "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //   //         "type": "COMMENT"
  //   //       }
  //   //
  //   //     }
  //   // ).then((value) => print(value.data)).catchError((error) {
  //   //   print(error.toString());
  //   // });
  // }
}
