import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../utils/dio_helper.dart';
import '../../dashboard_view/model/feedback_model.dart';

part 'feed_back_state.dart';

class FeedBackCubit extends Cubit<FeedBackState> {
  FeedBackCubit() : super(FeedBackInitial());
  static FeedBackCubit get(context) => BlocProvider.of(context);
  List <FeedbackModel> ? feedbackModel;

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

}
