import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/manage_admin_view/AdminCubit/admin_cubit.dart';
import 'package:graduation_project_admin/views/manage_admin_view/add_admin_view.dart';

import '../../Widgets/LIstIem.dart';
import '../../Widgets/UserList.dart';
import '../../Widgets/manegmentButtons.dart';
import 'edit_dialog.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit()..getAllAdmins(),
      child: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          final cubit = AdminCubit.get(context);
          if (state is AdminLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AdminError) {
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
                  'Manage Admin',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    ElevatedButton(
                        onPressed: () {
                          navigateToScreen(context, AddAdminView());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20)),
                        child: Text('Add Admin',
                            style: TextStyle(
                                fontSize: 20, color: Colors.white))),

                  ],
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
                          "Admins",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.ListAdminModel.length,
                            itemBuilder: (context, index) {
                              final reversedIndex = cubit.ListAdminModel!.length - 1 - index;

                              return ListItem(
                                firstTitle: "Admin id  ${cubit.ListAdminModel[reversedIndex].adminId.toString()}",
                                SecondTitle: cubit.ListAdminModel[reversedIndex].permission==-1?"Super Admin":"Admin",
                                BottomTitle1: "Edit",
                                onPressedEdit: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditDialog(
                                          adminModel: cubit.ListAdminModel[reversedIndex],
                                        );
                                      });
                                },
                                BottomTitle2: "Delete",
                                onPressedDelete: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Delete Admin'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                           await     cubit.deleteAdmin(cubit.ListAdminModel[reversedIndex].adminId!);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        );
                                      });
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
    );
  }
}
