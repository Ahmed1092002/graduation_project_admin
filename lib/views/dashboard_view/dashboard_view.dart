import 'package:flutter/material.dart';
import 'package:graduation_project_admin/views/dashboard_view/widget/custom_container_dash_board.dart';
import 'package:graduation_project_admin/views/dashboard_view/widget/doughnut_chart_widget.dart';
import 'package:graduation_project_admin/views/dashboard_view/widget/stacked_column__chart.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "User",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,



                children: [
                  DoughnutChartWidget(),
                  SizedBox(height: 50,),

                  Stacked_column_Chart(),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomContainerDashBoard(),
                  SizedBox(height: 50,),
                  CustomContainerDashBoard(),
                  SizedBox(height: 50,),

                  CustomContainerDashBoard(),
                  SizedBox(height: 50,),

                  Container(
                    width: 400,
                    height: 400,
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

                    child: Column(
                      children: [
                        Text(
                          "Users",
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
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
                        Container(
                          width: 400,
                          height: 340,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,

                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                              );
                            },
                          )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
