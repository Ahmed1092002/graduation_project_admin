import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  ListItem(
      {super.key,
      this.firstTitle,
      this.SecondTitle,
      this.onPressedDelete,
      this.onPressedEdit});
  String? firstTitle;
  String? SecondTitle;
  Function()? onPressedEdit;
  Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
        width: 400,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  firstTitle!,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  SecondTitle!,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            VerticalDivider(
              thickness: 2,
              color: Colors.black,
              width: 10,
            ),
            ElevatedButton(
                onPressed: onPressedEdit,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00FF80),
                    padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                child: Text(
                  "Edit",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
            VerticalDivider(
              thickness: 2,
              color: Colors.black,
            ),
            ElevatedButton(
                onPressed: onPressedDelete,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF0000),
                    padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                child: Text(
                  "Delete",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
