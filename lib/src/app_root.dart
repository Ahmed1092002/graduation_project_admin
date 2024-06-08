import 'package:flutter/material.dart';
import 'package:graduation_project_admin/views/login_view/login_page.dart';
import 'package:graduation_project_admin/views/main_screan.dart';
import 'package:hive/hive.dart';

import '../main.dart';

class MyApp extends StatelessWidget {
   MyApp({super.key});

  var box=Hive.box(boxName);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        useMaterial3: true,
      ),
      home:           box.get('adminId')!=null?MainScrean():
        LoginPage(),
    );
  }
}

