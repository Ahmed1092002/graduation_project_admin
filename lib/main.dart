import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_admin/src/app_root.dart';
import 'package:graduation_project_admin/utils/dio_helper.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  await DioHelper.init();
  runApp(const MyApp());
}

