import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/views/job_view/JobCubit/cubit/job_cubit_cubit.dart';
import 'package:graduation_project_admin/views/job_view/job_model/JobModel.dart';

import '../../utils/navigator.dart';
import '../manage_user_view/refugee_data_view.dart';

class JobDetails extends StatefulWidget {
  JobDetails({Key? key, this.jobModel}) : super(key: key);
  JobModel? jobModel;

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> with TickerProviderStateMixin {
  late TabController _tabController; // Declare the TabController
  late List<Tab> myTabs; // Declare the tabs list

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Initialize the TabController

    myTabs = <Tab>[
      Tab(
        text: 'Job Details',


      ),
      Tab(text: 'Refugees Applied On This Job'),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the TabController when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueAccent),
        title: Text('Job Details'),
        titleTextStyle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        bottom: TabBar(
          tabs: myTabs,

          controller: _tabController, // Pass the TabController to TabBar
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.blue.withOpacity(0.5),
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Pass the TabController to TabBarView
        children: [
Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Job Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                if (widget.jobModel != null)
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Job Name: ${widget.jobModel!.jobName}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (widget.jobModel != null)
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Description: ${widget.jobModel!.description}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (widget.jobModel != null)
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Min Salary: ${widget.jobModel!.salary}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (widget.jobModel != null)
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Location: ${widget.jobModel!.location}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (widget.jobModel != null)
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Publish Date: ${widget.jobModel!.publishDate}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (widget.jobModel != null)
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Years Of Experience: ${widget.jobModel!.yearsOfExperience}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),

              ],
            ),
          ),


          BlocProvider(
  create: (context) => JobCubit()..getAllRefugeesAppliedOnThisJob(id: widget.jobModel!.jobId),
  child: BlocConsumer<JobCubit, JobCubitState>(
  listener: (context, state) {
    if (state is GetAllRefugeesAppliedOnThisJobError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error"),
        ),
      );
    }
    if (state is GetAllRefugeesAppliedOnThisJobSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success"),
        ),
      );
    }

    if (state is AcceptOrRejectRefugeeError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error"),
        ),
      );
    }
    if (state is AcceptOrRejectRefugeeSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success"),
        ),
      );
    }
  },
  builder: (context, state) {
    return BlocBuilder<JobCubit, JobCubitState>(
  builder: (context, state) {
    final cubit = JobCubit.get(context);
    return state is GetAllRefugeesAppliedOnThisJobLoading || cubit.refugeeModel==null ?CircularProgressIndicator( color: Colors.cyanAccent ,): Container(
            child:ListView.builder(
              itemCount: cubit.refugeeModel!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      await cubit.getRefugeeById(cubit.refugeeModel![index].refugeeId!);
                      navigateToScreen(context, RefugeeDataView(
                        countryModel: cubit.countryModel,
                        refugeeModel: cubit.refugeeModel![index],
                        personModel: cubit.personModel,
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),




                      child: Row(
                        children: [

                          if(cubit.jobAppliedModelList==null)...[
                            //   if (cubit.jobAppliedModelList![index].jobStatus == 1)
                            //     Row(
                            //
                            //       children: [
                            //         Text("Accepted",
                            //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.green),
                            //         ),
                            //         SizedBox(width: 10,),
                            //         CircleAvatar(
                            //           backgroundColor: Colors.green,
                            //           child: Icon(Icons.check, color: Colors.white,),
                            //           radius: 10,),
                            //
                            //       ],
                            //     ),
                            //   if (cubit.jobAppliedModelList![index].jobStatus == 2)
                            //     Row(
                            //       children: [
                            //         Text("Rejected",
                            //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.red),
                            //         ),
                            //         SizedBox(width: 10,),
                            //         CircleAvatar(
                            //           backgroundColor: Colors.red,
                            //           child: Icon(Icons.close, color: Colors.white,),
                            //           radius: 10,),
                            //       ],
                            //     ),
                            // if (cubit.jobAppliedModelList![index].jobStatus == 0)
                            //   Row(
                            //     children: [
                            //       Text("Pending",
                            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.grey),
                            //       ),
                            //       SizedBox(width: 10,),
                            //       CircleAvatar(
                            //         backgroundColor: Colors.grey,
                            //         child: Icon(Icons.pending, color: Colors.grey,),
                            //         radius: 10,),
                            //     ],
                            //   ),
                      ],



                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Refugee id: ${cubit.refugeeModel![index].refugeeId}",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                          SizedBox(width: 10,),
                          Row(
                            children: [
                              ElevatedButton(


                                  style:  ElevatedButton.styleFrom(

                                   backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  )
                                  ,onPressed: () async {
                                  await   cubit.AcceptOrRejectRefugee(jobid: widget.jobModel!.jobId, refugeeid: cubit.refugeeModel![index].refugeeId!, jobstatus: 1);
                                  // await cubit.getAllRefugeesAppliedOnThisJob(id: widget.jobModel!.jobId);
                              }, child: Text("Accept", style: TextStyle(color: Colors.white  )) ),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                    style:  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),

                                    onPressed: () async{
                                      await   cubit.AcceptOrRejectRefugee(jobid: widget.jobModel!.jobId, refugeeid: cubit.refugeeModel![index].refugeeId!, jobstatus: 2);
                                      // await cubit.getAllRefugeesAppliedOnThisJob(id: widget.jobModel!.jobId);

                                    }, child: Text("Reject", style: TextStyle(color: Colors.white)) ),
                              SizedBox(width: 10,),
                              Icon(Icons.keyboard_arrow_right_outlined)
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                );
              },
            )
          );
  },
);
  },
),
),
        ],
      ),
    );
  }
}
