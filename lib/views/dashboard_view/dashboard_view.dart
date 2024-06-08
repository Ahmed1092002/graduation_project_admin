import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/views/dashboard_view/dashboard_cubit/dashbored_cubit.dart';
import 'package:graduation_project_admin/views/dashboard_view/widget/custom_container_dash_board.dart';
import 'package:graduation_project_admin/views/dashboard_view/widget/doughnut_chart_widget.dart';
import 'package:graduation_project_admin/views/dashboard_view/widget/stacked_column__chart.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboredCubit()
        ..fetchRefugeeData()
        ..getNumberOfUsersPerMonth()
        ..countPerJob()
        ..getFeedback()
        ..getHelpingRequest(),
      child: BlocConsumer<DashboredCubit, DashboredState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = DashboredCubit.get(context);

          // Handle loading state
          if (state is DashboredLoading ||
              state is NumberOfUsersPerMonthLoading ||
              state is CountPerJobLoading ||
              state is GetFeedbackLoading ||
              cubit.helpingRequestModel == null
          || cubit.feedbackModel == null
              ||cubit.countPerJobModel == null||
              cubit.chartData == null||
              cubit.chartDataColumn==null||
              cubit.refugeeCount == null||
              cubit.refugeesByCountryModel == null||
              cubit.numberOfUsersPerMonthModel == null||



              state is GetHelpingRequestLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }

          // Handle error state
          if (state is DashboredError) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          }

          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (MediaQuery.of(context).size.width > 1300)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Dashboard Page',
                        style: TextStyle(fontSize: 20 , color: Colors.blue),
                      ),
                    ),
                  if (MediaQuery.of(context).size.width > 1300)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DoughnutChartWidget(
                              chartData: cubit.chartData ?? [],
                              title: cubit.refugeeCount?.toString() ?? '0',
                            ),
                            SizedBox(height: 50),
                            Stacked_column_Chart(
                              numberOfUsersPerMonthModel: cubit.numberOfUsersPerMonthModel!,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomContainerDashBoard(
                                title: "Number of Feedback",
                                count: cubit.feedbackModel?.length ?? 0,
                                imageUrl: 'assets/image/feedback.png',
                              ),
                              SizedBox(height: 50),

                              CustomContainerDashBoard(
                                title: "Number of Request",
                                count: cubit.helpingRequestModel!.length ?? 0,
                                imageUrl: 'assets/image/request.png',
                              ),

                              SizedBox(height: 50),
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
                                      "Jobs",
                                      style: TextStyle(fontSize: 20, color: Colors.blue),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Job Name",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "Job Count",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width > 1000 ? 400 : 200,
                                      height: 340,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: cubit.countPerJobModel?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final job = cubit.countPerJobModel![index];
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                job.jobName ?? 'N/A',
                                                style: TextStyle(fontSize: MediaQuery.of(context).size.width > 1000 ? 20 : 10),
                                              ),
                                              Text(
                                                job.count?.toString() ?? '0',
                                                style: TextStyle(fontSize: MediaQuery.of(context).size.width > 1000 ? 20 : 10),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (MediaQuery.of(context).size.width < 1300)
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "User",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          DoughnutChartWidget(
                            chartData: cubit.chartData ?? [],
                            title: cubit.refugeeCount?.toString() ?? '0',
                          ),
                          SizedBox(height: 50),
                          Stacked_column_Chart(
                            numberOfUsersPerMonthModel: cubit.numberOfUsersPerMonthModel!,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomContainerDashBoard(
                                    title: "Number of Feedback",
                                    count: cubit.feedbackModel?.length ?? 0,
                                    imageUrl: 'assets/image/feedback.png',
                                  ),
                                  SizedBox(height: 50),
                                  CustomContainerDashBoard(
                                    title: "Number of Request",
                                    count: cubit.helpingRequestModel!.length ?? 0,
                                    imageUrl: 'assets/image/request.png',
                                  ),
                                  SizedBox(height: 50),
                                ],
                              ),
                              Container(
                                width: 300,
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
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Jobs",
                                        style: TextStyle(fontSize: 20, color: Colors.blue),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "Job Name",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            "Job Count",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 350,
                                        height: 340,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: cubit.countPerJobModel?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            final job = cubit.countPerJobModel![index];
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  job.jobName ?? 'N/A',
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                                Text(
                                                  job.count?.toString() ?? '0',
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
