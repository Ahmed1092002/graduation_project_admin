import 'package:flutter/material.dart';

class manegmentButtons extends StatelessWidget {
  manegmentButtons(
      {super.key,
      required this.Managepage,
      required this.Button1,
      required this.Button2});
  String? Managepage;
  String? Button1;
  String? Button2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          Managepage!,
          style: TextStyle(fontSize: 20),
        ),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
            child: Text(Button1!)),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
            child: Text(Button2!)),
      ],
    );
  }
}
