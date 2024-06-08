import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/Widgets/Search.dart';
import 'package:graduation_project_admin/Widgets/UserList.dart';
import 'package:graduation_project_admin/Widgets/manegmentButtons.dart';

import '../../Widgets/LIstIem.dart';
import 'HelpingRequestCubit/recive_request_cubit.dart';

class RecieveRequst extends StatelessWidget {
  const RecieveRequst({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReciveRequestCubit()..getHelpingRequest(),
      child: BlocListener<ReciveRequestCubit, ReciveRequestState>(
  listener: (context, state) {
if (state is ChangeRequestStatusSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Request Status Changed Successfully'),
        ),
      );
    } else if (state is ChangeRequestStatusError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage),
        ),
      );
}

  },
  child: BlocBuilder<ReciveRequestCubit, ReciveRequestState>(
        builder: (context, state) {
          final cubit = ReciveRequestCubit.get(context);
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Text('Recieve Requst',
                  style: TextStyle(fontSize: 30, color: Colors.cyan),),
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

                        SizedBox(height: 8),
                       state is GetHelpingRequestLoading? CircularProgressIndicator(): Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,

                            itemCount: cubit.helpingRequestModel!.length,
                            itemBuilder: (context, index) {
                              final reversedIndex = cubit.helpingRequestModel!.length - 1 - index;
                              return ListItem(
                                BottomTitle1: "Accept",
                                BottomTitle2: "Reject",
                                firstTitle: cubit.helpingRequestModel![reversedIndex].requestID.toString(),
                                SecondTitle: cubit.helpingRequestModel![reversedIndex].message,
                                isPending: !cubit.helpingRequestModel![reversedIndex].requestStatus!,
                                onPressedEdit: () async {
                                  await cubit.changeRequestStatus(requestId: cubit.helpingRequestModel![reversedIndex].requestID, status: true);


                                },
                                onPressedDelete: () async {
                                  await cubit.changeRequestStatus(requestId: cubit.helpingRequestModel![reversedIndex].requestID, status: false);

                                },



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
),
    );
  }
}
