import 'package:flutter/material.dart';

class ManageUserView extends StatelessWidget {
  const ManageUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 400,
              child: TextField(

                decoration: InputDecoration(

                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("User manage",style: TextStyle(fontSize: 20),),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
    padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20)


    ),
                  child: Text("Add User")
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20)


                  ),
                  child: Text("Add User")
              ),


            ],
          ),
Container(
height: 800,
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
child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text("Users",style: TextStyle(fontSize: 20),),
    Container(
      width: 1500,
      height: 700,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "User Name",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "User Email",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
           SizedBox(
              width: 200,
           ),
            VerticalDivider(
              thickness: 2,
              color: Colors.black, width: 10,
            ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF00FF80),
                          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20)

                      ),
                      child: Text("Edit",style: TextStyle(fontSize: 20,color: Colors.white),)
                  ),
                  VerticalDivider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFFFF0000),
                          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20)

                      ),
                      child: Text("Delete",style: TextStyle(fontSize: 20,color: Colors.white),)
                  ),
                ],
              ),
            ),
          );
        },
      )
    )
  ],
) ,

)

        ],
      ),

    );
  }
}
