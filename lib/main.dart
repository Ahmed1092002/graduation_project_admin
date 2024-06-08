import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_admin/src/app_root.dart';
import 'package:graduation_project_admin/utils/bloc_opserver.dart';
import 'package:graduation_project_admin/utils/dio_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';
String boxName = 'user';
void main() async {
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  await DioHelper.init();

  await Hive.initFlutter();
  await Hive.openBox(boxName);
  var box = Hive.box(boxName);
  runApp( MyApp());
}

