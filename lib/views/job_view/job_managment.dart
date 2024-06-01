import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/Widgets/LIstIem.dart';
import 'package:graduation_project_admin/Widgets/Search.dart';
import 'package:graduation_project_admin/Widgets/UserList.dart';
import 'package:graduation_project_admin/Widgets/manegmentButtons.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/job_view/AddJobView.dart';
import 'package:graduation_project_admin/views/job_view/JobCubit/cubit/job_cubit_cubit.dart';

class JobView extends StatelessWidget {
  const JobView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobCubit()..getJobs(),
      child: BlocBuilder<JobCubit, JobCubitState>(
        builder: (context, state) {
          final cubit = JobCubit.get(context);
          return state is GetJobLoading || cubit.jobModel == null
              ? CircularProgressIndicator()
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      search(),
                      manegmentButtons(
                          Managepage: "Job Management",
                          Button1: "Add Job",
                          onPressedAdd: () =>
                              navigateToScreen(context, AddJobView()),
                          Button2: "Delete JOb"),
                      Expanded(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Job Management",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cubit.jobModel!.length,
                                  itemBuilder: (context, index) {
                                    return ListItem(
                                      firstTitle: cubit
                                          .jobModel![index].yearsOfExperience
                                          .toString(),
                                      SecondTitle:
                                          cubit.jobModel![index].jobName,
                                      onPressedEdit: () {
                                        navigateToScreen(context, AddJobView());
                                      },
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
    );
  }
}
