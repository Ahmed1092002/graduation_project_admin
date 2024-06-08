import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/views/login_view/loginMOdel/AdminModel.dart';
import 'package:graduation_project_admin/views/manage_admin_view/custom_text_form_field.dart';

import 'AdminCubit/admin_cubit.dart';

class EditDialog extends StatefulWidget {
  EditDialog({Key? key, this.adminModel}) : super(key: key);
  AdminModel? adminModel;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  TextEditingController userIdController = TextEditingController();

  TextEditingController qualificationController = TextEditingController();

  TextEditingController rolesController = TextEditingController();

  TextEditingController permissionController = TextEditingController();

  TextEditingController statusController = TextEditingController();

  int? permissions;
  @override
  void initState() {
    super.initState();
    userIdController.text = widget.adminModel!.userId.toString();
    qualificationController.text = widget.adminModel!.qualification!;
    rolesController.text = widget.adminModel!.roles!.toString();
    permissionController.text = widget.adminModel!.permission.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocProvider(
        create: (context) => AdminCubit(),
        child: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            final cubit = AdminCubit.get(context);
            return Container(


              child: Column(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Text('Edit Admin'),
                  Text('User ID: ${widget.adminModel!.userId}'),
                  Text('Qualification: ${widget.adminModel!.qualification}'),
                  Text('Roles: ${widget.adminModel!.roles}'),
                  Text('Permission: ${widget.adminModel!.permission}'),
                  CustomTextFormField(
                    controller: userIdController,
                    labelText: 'User ID',
                    hintText: 'User ID',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter User ID';
                      }
                    },
                  ),
                  CustomTextFormField(
                    controller: qualificationController,
                    labelText: 'Qualification',
                    hintText: 'Qualification',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Qualification';
                      }
                    },
                  ),
                  CustomTextFormField(
                    controller: rolesController,
                    labelText: 'Roles',
                    hintText: 'Roles',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Roles';
                      }
                    },
                  ),


                  Row(
                    children: [
                      Text(
                        "Permission",
                        style: TextStyle(fontSize: 16),
                      ),
                      Radio(
                        value: 0,
                        groupValue: permissions,
                        onChanged: (int? value) {
                          setState(() {
                            permissions = value;
                          });
                        },
                      ),
                      Text("0"),
                      Radio(
                        value: -1,
                        groupValue: permissions,
                        onChanged: (int? value) {
                          setState(() {
                            permissions = value;
                          });
                        },
                      ),
                      Text("-1"),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await cubit.editAdmin(
                        permission: permissions,
                        qualification: qualificationController.text,
                        roles: rolesController.text,
                        admin: widget.adminModel!.adminId,
                        userId: widget.adminModel!.userId,

                      );

                      Navigator.pop(context);
                    },
                    child: Text('Edit'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
