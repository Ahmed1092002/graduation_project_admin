import 'package:flutter/material.dart';
import 'package:graduation_project_admin/views/login_view/login_page.dart';
import 'package:graduation_project_admin/views/main_screan.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        useMaterial3: true,
      ),
      home:  MainScrean(),
    );
  }
}

