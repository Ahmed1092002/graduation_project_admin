import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/Widgets/Search.dart';
import 'package:graduation_project_admin/Widgets/UserList.dart';
import 'package:graduation_project_admin/Widgets/manegmentButtons.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/manage_user_view/RefugeeCubit/refugee_cubit.dart';
import 'package:graduation_project_admin/views/manage_user_view/refugee_data_view.dart';

import '../../Widgets/LIstIem.dart';

class ManageUserView extends StatelessWidget {
  const ManageUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RefugeeCubit()..getAllRefugees(),
      child: BlocListener<RefugeeCubit, RefugeeState>(
  listener: (context, state) {
 if (state is BlockUserLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User Blocked Successfully'),
        ),
      );
    }
 else if (state is BlockUserError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error"),
        ),
      );
    }
 else if (state is UnblockUserLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User UnBlocked Successfully'),
        ),
      );
    }
 else if (state is UnblockUserError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User UnBlocked'),
        ),
      );
    }
  },
  child: BlocBuilder<RefugeeCubit, RefugeeState>(
        builder: (context, state) {
          final cubit = RefugeeCubit.get(context);
          if (state is RefugeeLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RefugeeError) {
            return Center(
              child: Text('Error'),
            );
          }
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Text(
                  'Manage Refugeee',
                  style: TextStyle(fontSize: 20),
                ),

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
                          "Refugee",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.ListrefugeeModel.length,

                              itemBuilder: (context, index) {
                                final reversedIndex = cubit.ListrefugeeModel!.length - 1 - index;

                                return InkWell(
                                onTap: () async {
                                 await cubit.getRefugeeById(cubit.ListrefugeeModel[reversedIndex].refugeeId!);
                                  navigateToScreen(context, RefugeeDataView(
                                    countryModel: cubit.countryModel,
                                    refugeeModel: cubit.refugeeModel,
                                    personModel: cubit.personModel,
                                  ));
                                },
                                child: ListItem(
                                  firstTitle:  " Refugee id  ${cubit.ListrefugeeModel[reversedIndex].refugeeId.toString()}",
                                  SecondTitle: cubit.ListrefugeeModel[reversedIndex].countryId.toString(),
                                  BottomTitle1: 'UnBlock',
                                  BottomTitle2: "Block",
                              onPressedEdit: () {
                                    showDialog(context: context, builder:
                                    (context) {
                                      return AlertDialog(
                                        title: Text('UnBlock Refugee'),

                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              cubit.unblockUser(cubit.ListrefugeeModel[reversedIndex].userId!);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Save'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                                onPressedDelete: () {
                                    showDialog(context: context, builder:
                                    (context) {
                                      return AlertDialog(
                                        title: Text('Block Refugee'),

                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              cubit.blockUser(cubit.ListrefugeeModel[reversedIndex].userId!);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Save'),
                                          ),
                                        ],
                                      );
                                    });

                              },
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
),
    );
  }
}
