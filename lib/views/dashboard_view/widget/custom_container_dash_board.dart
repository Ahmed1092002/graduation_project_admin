import 'package:flutter/material.dart';

class CustomContainerDashBoard extends StatelessWidget {
   CustomContainerDashBoard({
    super.key,
    this.title,
    this.count,
     this.imageUrl,

  });
String ? title;
String? imageUrl;
int ? count;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title!,
                style: TextStyle(fontSize: 20,color: Colors.blue),
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFFE5EEFF),
            child: Image.asset(
              imageUrl!,
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
