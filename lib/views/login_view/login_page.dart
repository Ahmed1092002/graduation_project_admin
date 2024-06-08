import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/login_view/LoginCubit/login_cubit.dart';
import 'package:graduation_project_admin/views/main_screan.dart';

class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);

TextEditingController userNameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
   final GlobalKey<FormState> formKey = GlobalKey();

   AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
   bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
  builder: (context, state) {
   final  cubit = LoginCubit.get(context);
    return Scaffold(

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/preview-HMeq0RCYE-transformed-removebg-preview.png',
                height: 300, width: 800,),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: Container(
                  width: 500,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xFF0C7AB7)),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Login', style: TextStyle(fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0C7AB7)),),

                        TextFormField(
controller: userNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },

                          decoration: InputDecoration(

                            hintText: 'Username',
                            hintStyle: TextStyle(color: Color(0xFF0C7AB7)),

                            label: Text('Username'),
                            labelStyle: TextStyle(color: Color(0xFF0C7AB7)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFF0C7AB7)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFF0C7AB7)),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFF0C7AB7)),
                            ),
                          ),
                        ),

                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          obscureText: isPassword,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(isPassword ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                isPassword = !isPassword;
                              },
                            ),
                            hintText: 'Password',
                            label: Text('Password'),
                            hintStyle: TextStyle(color: Color(0xFF0C7AB7)),
                            labelStyle: TextStyle(color: Color(0xFF0C7AB7)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFF0C7AB7)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFF0C7AB7)),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFF0C7AB7)),
                            ),

                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                           await     cubit.login(userName: userNameController.text, password: passwordController.text);
                                navigateToScreenAndExit(context, MainScrean());
                              }
                              else {
                                autovalidateMode = AutovalidateMode.always;
                              }



                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0C7AB7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            )
                        ),

                      ],
                    ),
                  ),

                ),
              ),
            ],
          ),
        ),


      );
  },
),
    );
  }
}
