import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/views/job_view/job_model/PersonModel.dart';
import 'package:graduation_project_admin/views/job_view/job_model/UserModel.dart';
import 'package:graduation_project_admin/views/login_view/loginMOdel/AdminModel.dart';
import 'package:graduation_project_admin/views/manage_admin_view/AdminCubit/admin_cubit.dart';
import 'package:intl/intl.dart';
import 'custom_text_form_field.dart';

class AddAdminView extends StatefulWidget {
  const AddAdminView({Key? key}) : super(key: key);

  @override
  State<AddAdminView> createState() => _AddAdminViewState();
}

class _AddAdminViewState extends State<AddAdminView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _genderController;
  late TextEditingController _addressController;
  late TextEditingController _phone1Controller;
  late TextEditingController _emailController;
  late TextEditingController _userNameController;
  late TextEditingController _passwordController;

  List<String> roles = ["Admin", "Sub Admin"];
  String? selectedRole;
  late DateTime _selectedDate;
  String? _gender;
  int? permissions;
  String? selectedGender;
  PersonModel? personModel;
  UserModel? userModel;
  AdminModel? adminModel;
  TextEditingController? dateOfBirthController;
  String? selectedgender ;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _genderController = TextEditingController();
    _addressController = TextEditingController();
    _phone1Controller = TextEditingController();
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _selectedDate = DateTime.now();
    dateOfBirthController = TextEditingController(); // Initialize dateOfBirthController
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _phone1Controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? SelectedDateformate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        SelectedDateformate = DateFormat('yyyy-MM-dd').format(_selectedDate).toString();
        print(_selectedDate);
      });
    }
  }
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          final cubit = AdminCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Add Admin"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),

                      CustomTextFormField(
                        controller: _firstNameController,
                        labelText: "First Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the first name";
                          }
                          return null;
                        }, hintText: '',
                      ),
                      SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _lastNameController,
                        labelText: "Last Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the last name";
                          }
                          return null;
                        }, hintText: '',
                      ),
                      SizedBox(height: 16),

                      CustomTextFormField(
                        controller: _addressController,
                        labelText: "Address",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the address";
                          }
                          return null;
                        }, hintText: '',
                      ),
                      SizedBox(height: 16),

                      CustomTextFormField(
                        controller: _phone1Controller,
                        labelText: "Phone",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the phone number";
                          }
                          return null;
                        }, hintText: '',
                      ),
                      SizedBox(height: 16),

                      CustomTextFormField(
                        controller: _emailController,
                        labelText: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the email address";
                          }
                          return null;
                        }, hintText: '',
                      ),
                      SizedBox(height: 16),

                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                            labelText: SelectedDateformate ?? 'Date of Birth',
                            validator: (value) {
                              if (SelectedDateformate == null) {
                                return 'Please select a date of birth';
                              }
                              return null;
                            }, controller:dateOfBirthController!  , hintText: '',
                          ),
                        ),

                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _gender,
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Male', 'Female']
                            .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                            if (_gender == "Male") {
                              selectedgender = "M";


                            }
                            else {
                              selectedgender = "F";
                            }
                          });
                        },
                      ),
                      SizedBox(height: 16),

                      CustomTextFormField(
                        controller: _userNameController,
                        labelText: "User Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the user name";
                          }
                          return null;
                        }, hintText: '',
                      ),
                      SizedBox(height: 16),

                      CustomTextFormField(
                        controller: _passwordController,
                        labelText: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the password";
                          }
                          return null;
                        }, hintText: '',
                      ),
                      SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        value: selectedRole,
                        decoration: InputDecoration(
                          labelText: 'Role',
                          border: OutlineInputBorder(),
                        ),
                        items: roles.map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a role';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                      ),

                      SizedBox(height: 16),
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
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              autovalidateMode = AutovalidateMode.onUserInteraction;
                            });
                            if (_formKey.currentState!.validate()) {
                              personModel = PersonModel(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                gender: selectedgender,
                                address: _addressController.text,
                                phone1: _phone1Controller.text,

                                dateOfBirth: _selectedDate.toIso8601String(),
                                email: _emailController.text,
                              );
                              await cubit.addPerson(personModel);
                              if (cubit.personModel != null) {
                                await cubit.addUser(
                                  personId: cubit.personModel!.personId,
                                  userName: _userNameController.text,
                                  passward: _passwordController.text,
                                );
                              }
                              if (cubit.userModel != null) {
                                await cubit.addAdmin(
                                  qualification: 'role ',
                                  roles: selectedRole,
                                  permission: permissions,
                                  userId: cubit.userModel!.userId,
                                );
                                if (cubit.adminModel != null) {
                                  Navigator.pop(context);
                                }
                              }
                            }
                          },
                          child: Text("Add Admin"),
                        ),
                      ),
                      if (state is AddPersonError)
                        Center(
                          child: Text(
                            'Failed to add person',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      if (state is AddUserError)
                        Center(
                          child: Text(
                            'Failed to add user',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      if (state is AddAdminError)
                        Center(
                          child: Text(
                            'Failed to add admin',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      if (state is AdminError)
                        Center(
                          child: Text(
                            'Failed to add person',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
