import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/Widgets/LIstIem.dart';
import 'package:graduation_project_admin/Widgets/Search.dart';
import 'package:graduation_project_admin/Widgets/UserList.dart';
import 'package:graduation_project_admin/Widgets/manegmentButtons.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/job_view/AddJobView.dart';
import 'package:graduation_project_admin/views/job_view/JobCubit/cubit/job_cubit_cubit.dart';
import 'package:graduation_project_admin/views/job_view/job_details.dart';

import 'filter_jobs_dialog.dart';

class JobView extends StatelessWidget {
  const JobView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobCubit()..getJobs(),
      child: BlocListener<JobCubit, JobCubitState>(
  listener: (context, state) {
if (state is AddJobLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully'),
        ),
      );
    } else if (state is AddJobError) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Error"),
    ),
  );
}
  },
  child: BlocBuilder<JobCubit, JobCubitState>(
        builder: (context, state) {
          final cubit = JobCubit.get(context);
          return state is GetJobLoading || cubit.jobModel == null
              ? Center(
                child: CircularProgressIndicator(
                    color: Colors.blue,

                          ),
              )
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 10),

                      manegmentButtons(
                          Managepage: "Job Management",
                          Button1: "Add Job",
                          onPressedAdd: () =>
                              navigateToScreen(context, AddJobView(
                                AppBarTitle: "Add Job",
                              )),
                    onPressedSearch: () async {
                      final params = await showJobFilterDialog(context);
                      if (params != null) {
                await    cubit.filterJobs(
                          jobName: params['jobName'],
                          description: params['description'],
                          minSalary: params['minSalary'],
                          maxSalary: params['maxSalary'],
                          specificSalary: params['specificSalary'],
                          address: params['address'],
                          location: params['location'],
                          minPublishDate: params['minPublishDate'],
                          maxPublishDate: params['maxPublishDate'],
                          specificPublishDate: params['specificPublishDate'],
                          yearsOfExperience: params['yearsOfExperience'],
                        );
                      }



                    },




                          Button2: "FIlter job"),

SizedBox(height: 10),

                      Expanded(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              SizedBox(height: 8),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cubit.jobModel!.length,
                                  itemBuilder: (context, index) {
                                    final reversedIndex = cubit.jobModel!.length - 1 - index;

                                    return InkWell(
                                      onTap: () {
                                        print(cubit.jobModel![reversedIndex].jobId);
                                        navigateToScreen(context, JobDetails(
                                          jobModel: cubit.jobModel![reversedIndex],
                                        ));
                                      },
                                      child: ListItem(
                                        BottomTitle1: 'Edit Job',
                                        BottomTitle2: 'Delete Job',
                                        firstTitle:  cubit.jobModel![reversedIndex].jobName,
                                        SecondTitle:" Experience: ${cubit.jobModel![reversedIndex].yearsOfExperience} years",
                                        onPressedDelete: ()  async {
                                          return showDialog(context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text('Are you sure you want to delete this job?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('No'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        print (cubit.jobModel![reversedIndex].jobId);
                                                        await cubit.changeJobStatus(cubit.jobModel![reversedIndex].jobId!, false );
                                                        await cubit.deleteJob(cubit.jobModel![reversedIndex].jobId!);
                                                        await cubit.getJobs();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Yes'),
                                                    ),
                                                  ],
                                                );
                                              });

                                        },
                                        onPressedEdit: () {
                                          navigateToScreen(context, AddJobView(
                                            AppBarTitle: 'Edit Job',
                                            jobModel: cubit.jobModel![reversedIndex],
                                          ));
                                        },
                                      ),
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
                );
        },
      ),
),
    );
  }
}
