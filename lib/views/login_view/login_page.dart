import 'package:flutter/material.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/main_screan.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           Image.asset('assets/image/preview-HMeq0RCYE-transformed-removebg-preview.png',height: 300,width: 800,),
              SizedBox(
                height: 20,
              ),
              Form(
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
                        Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF0C7AB7)),),

                        TextFormField(

                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Color(0xFF0C7AB7)),

                            label: Text('Email'),
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
                          decoration: InputDecoration(
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
                          onPressed: () {
                            navigateToScreenAndExit(context, MainScrean());
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
  }
}
