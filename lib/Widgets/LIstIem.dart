import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  ListItem(
      {super.key,
      this.firstTitle,
      this.SecondTitle,
      this.BottomTitle1,
      this.BottomTitle2,
      this.onPressedDelete,
        this.isPending = false,

      this.onPressedEdit});
  String? firstTitle;
  String? SecondTitle;
  Function()? onPressedEdit;
  Function()? onPressedDelete;
  String?  BottomTitle1;
  String?  BottomTitle2;
bool isPending = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.5)),
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
            isPending?     CircleAvatar(
              backgroundColor: Colors.green,
              radius: 10,
            ):SizedBox(
              width: 0,
              height: 0,
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
              color: Colors.black.withOpacity(0.5),
              width: 10,
              endIndent: 10,
              indent: 10,
            ),
            ElevatedButton(
                onPressed: onPressedEdit,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00FF80),
                    padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                child: Text(
                  BottomTitle1!,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
            VerticalDivider(
              thickness: 2,
              color: Colors.black.withOpacity(0.5),
              width: 10,
              endIndent: 10,
              indent: 10,
            ),
            ElevatedButton(
                onPressed: onPressedDelete,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF0000),
                    padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                child: Text(
                  BottomTitle2!,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
