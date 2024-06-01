import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/job_view/JobCubit/cubit/job_cubit_cubit.dart';
import 'package:graduation_project_admin/views/job_view/job_model/JobModel.dart';
import 'package:graduation_project_admin/views/main_screan.dart';

class AddJobView extends StatefulWidget {
  AddJobView({super.key, this.jobModel});
  JobModel? jobModel;
  String? AppBarTitle;

  @override
  State<AddJobView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddJobView> {
  final jobNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final salaryController = TextEditingController();
  final countryController = TextEditingController();
  final locationController = TextEditingController();
  final publishDate = DateTime.now(); // Assuming you want current date
  final yearsOfExperienceController = TextEditingController();
  bool isView = true; // Assuming initial visibility to be true

  @override
  void initState() {
    // TODO: implement initState

    if (widget.jobModel != null) {
      jobNameController.text = widget.jobModel!.jobName!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobCubit(),
      child: BlocBuilder<JobCubit, JobCubitState>(
        builder: (context, state) {
          final cubit = JobCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Job Add Form'),
              actions: [
                Text('Is View'),
                Checkbox(
                  value: isView,
                  onChanged: (newValue) => setState(() => isView = newValue!),
                  activeColor: Colors.blue,
                  materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // Reduce tap area
                ),
              ],
            ),
            body: Form(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: jobNameController,
                    decoration: InputDecoration(labelText: 'Job Name'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 5, // Adjust for multi-line descriptions
                  ),
                  TextField(
                    controller: salaryController,
                    decoration: InputDecoration(labelText: 'Salary'),
                    keyboardType: TextInputType.number, // For numeric input
                  ),
                  TextField(
                    controller: countryController,
                    decoration: InputDecoration(labelText: 'Country'),
                  ),
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(labelText: 'Location'),
                  ),
                  Row(
                    children: [
                      Text('Publish Date: '),
                      Text(publishDate.toString()), // Display formatted date
                    ],
                  ),
                  TextField(
                    controller: yearsOfExperienceController,
                    decoration:
                        InputDecoration(labelText: 'Years of Experience'),
                    keyboardType: TextInputType.number, // For numeric input
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      await cubit.AddJob(
                          country: countryController.text,
                          description: descriptionController.text,
                          jobName: jobNameController.text,
                          location: locationController.text,
                          salary: int.tryParse(salaryController.text),
                          yearsOfExperience:
                              int.tryParse(salaryController.text));
                      navigateToScreenAndExit(context, MainScrean());
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
