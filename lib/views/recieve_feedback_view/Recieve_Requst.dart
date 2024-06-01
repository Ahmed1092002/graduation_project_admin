import 'package:flutter/material.dart';
import 'package:graduation_project_admin/Widgets/Search.dart';
import 'package:graduation_project_admin/Widgets/UserList.dart';
import 'package:graduation_project_admin/Widgets/manegmentButtons.dart';

class RecieveRequst extends StatelessWidget {
  const RecieveRequst({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          search(),
          manegmentButtons(
              Managepage: "Manage User",
              Button1: "Add Feedback",
              Button2: "Delete Feedback"),
          UserList(),
        ],
      ),
    );
  }
}
