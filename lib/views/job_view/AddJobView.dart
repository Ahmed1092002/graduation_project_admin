import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/job_view/JobCubit/cubit/job_cubit_cubit.dart';
import 'package:graduation_project_admin/views/job_view/job_model/JobModel.dart';
import 'package:graduation_project_admin/views/main_screan.dart';

class AddJobView extends StatefulWidget {
  AddJobView({super.key, this.jobModel, this.AppBarTitle});
  JobModel? jobModel;
  String? AppBarTitle;

  @override
  State<AddJobView> createState() => _AddJobViewState();
}

class _AddJobViewState extends State<AddJobView> {
  final jobNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final salaryController = TextEditingController();
  final countryController = TextEditingController();
  final locationController = TextEditingController();
  String? publishDate; // Initially null
  final yearsOfExperienceController = TextEditingController();
  bool? isView = true; // Assuming initial visibility to be true

  @override
  void initState() {
    if (widget.jobModel != null) {
      jobNameController.text = widget.jobModel!.jobName!;
      descriptionController.text = widget.jobModel!.description!;
      salaryController.text = widget.jobModel!.salary.toString();
      countryController.text = widget.jobModel!.country!;
      locationController.text = widget.jobModel!.location!;
      yearsOfExperienceController.text = widget.jobModel!.yearsOfExperience.toString();
      isView = widget.jobModel!.isView!;
      publishDate = widget.jobModel!.publishDate ?? DateTime.now().toIso8601String();
    } else {
      publishDate = DateTime.now().toIso8601String(); // Set to current date if no jobModel
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(publishDate!),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked.toIso8601String() != publishDate) {
      setState(() {
        publishDate = picked.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobCubit(),
      child: BlocListener<JobCubit, JobCubitState>(
        listener: (context, state) {
          if (state is GetJobSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Job Added Successfully'),
              ),
            );
          } else if (state is GetJobError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Job Error"),
              ),
            );
          }
          if (state is AddJobLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Loading...'),
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
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.AppBarTitle ?? 'Add Job',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                backgroundColor: Colors.white,
                actions: [
                  Text('Is View'),
                  Checkbox(
                    value: isView,
                    onChanged: (newValue) => setState(() => isView = newValue!),
                    activeColor: Colors.blue,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: jobNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Job Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        maxLines: 5, // Adjust for multi-line descriptions
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: salaryController,
                        decoration: InputDecoration(
                          labelText: 'Salary',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number, // For numeric input
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: countryController,
                        decoration: InputDecoration(
                          labelText: 'Country',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: locationController,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      // Row for Publish Date with Date Picker Button
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Publish Date:',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          if (widget.jobModel!=null)
                          Expanded(
                            child: Text(
                              publishDate != null
                                  ? DateTime.parse(publishDate!).toLocal().toString().split(' ')[0]
                                  : 'Select Date',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                          else
                            Text(
                              publishDate != null
                                  ? DateTime.parse(publishDate!).toLocal().toString().split(' ')[0]
                                  : 'Select Date',
                              style: TextStyle(fontSize: 16),

                            ),
                          ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: Text('Select Date'),
                          ),
                        ],
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: yearsOfExperienceController,
                        decoration: InputDecoration(
                          labelText: 'Years of Experience',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number, // For numeric input
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          final jobModel = JobModel(
                            jobId: widget.jobModel?.jobId,
                            jobName: jobNameController.text,
                            description: descriptionController.text,
                            salary: int.parse(salaryController.text),
                            country: countryController.text,
                            location: locationController.text,
                            publishDate: publishDate.toString(),
                            yearsOfExperience: int.parse(yearsOfExperienceController.text),
                            isView: isView,
                          );
                          if (widget.AppBarTitle == 'Edit Job') {
                            await cubit.editJob(jobModel);
                          } else {
                            await cubit.addJob(jobModel);
                          }
                          navigateToScreen(context, MainScrean());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        ),
                        child: Text('Submit', style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
