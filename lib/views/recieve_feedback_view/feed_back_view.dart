import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/views/recieve_feedback_view/FeedBackCubit/feed_back_cubit.dart';

import '../../Widgets/LIstIem.dart';
import '../../Widgets/manegmentButtons.dart';

class FeedBackView extends StatelessWidget {
  const FeedBackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedBackCubit()..getFeedback(),
      child: BlocBuilder<FeedBackCubit, FeedBackState>(
        builder: (context, state) {
          final cubit = FeedBackCubit.get(context);
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [


                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Feedbacks",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 8),
                 state is GetFeedbackLoading ? CircularProgressIndicator():       Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.feedbackModel!.length,
                            itemBuilder: (context, index) {
                              final reversedIndex = cubit.feedbackModel!.length - 1 - index;

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black.withOpacity(0.5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  width: 400,

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
SizedBox(
  width: 10,
),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "FeedBack Id : ${cubit.feedbackModel![index].feedbackID.toString()}",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            "massage: ${cubit.feedbackModel![index].message!}",
                                            style: TextStyle(fontSize: 20),
                                          ),


                                          Text(
                                            "Rating: ${cubit.feedbackModel![index].rating.toString()}",
                                            style: TextStyle(fontSize: 20),
                                          ),

                                        ],
                                      ),
                                      Spacer()


                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
