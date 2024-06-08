import 'package:flutter/material.dart';

class FilterJobsDialog extends StatefulWidget {
  const FilterJobsDialog({Key? key}) : super(key: key);

  @override
  _FilterJobsDialogState createState() => _FilterJobsDialogState();
}

class _FilterJobsDialogState extends State<FilterJobsDialog> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




Future<Map<String, dynamic>?> showJobFilterDialog(BuildContext context) {
  final TextEditingController jobNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController minSalaryController = TextEditingController();
  final TextEditingController maxSalaryController = TextEditingController();
  final TextEditingController specificSalaryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController minPublishDateController = TextEditingController();
  final TextEditingController maxPublishDateController = TextEditingController();
  final TextEditingController specificPublishDateController = TextEditingController();
  final TextEditingController yearsOfExperienceController = TextEditingController();

  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Job Parameters'),
        content: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: jobNameController,
                  decoration: InputDecoration(labelText: 'Job Name'),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: minSalaryController,
                  decoration: InputDecoration(labelText: 'Min Salary'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: maxSalaryController,
                  decoration: InputDecoration(labelText: 'Max Salary'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: specificSalaryController,
                  decoration: InputDecoration(labelText: 'Specific Salary'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                ),
                TextFormField(
                  controller: yearsOfExperienceController,
                  decoration: InputDecoration(labelText: 'Years of Experience'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: minPublishDateController,
                  decoration: InputDecoration(
                    labelText: 'Min Publish Date',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          minPublishDateController.text = pickedDate.toString().split(' ')[0];
                        }
                      },
                    ),
                  ),
                ),
                TextFormField(
                  controller: maxPublishDateController,
                  decoration: InputDecoration(
                    labelText: 'Max Publish Date',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          maxPublishDateController.text = pickedDate.toString().split(' ')[0];
                        }
                      },
                    ),
                  ),
                ),
                TextFormField(
                  controller: specificPublishDateController,
                  decoration: InputDecoration(
                    labelText: 'Specific Publish Date',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          specificPublishDateController.text = pickedDate.toString().split(' ')[0];
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Submit'),
            onPressed: () {
              final params = {
                'jobName': jobNameController.text,
                'description': descriptionController.text,
                'minSalary': int.tryParse(minSalaryController.text) ?? 0,
                'maxSalary': int.tryParse(maxSalaryController.text) ?? 0,
                'specificSalary': int.tryParse(specificSalaryController.text) ?? 0,
                'address': addressController.text,
                'location': locationController.text,
                'minPublishDate': minPublishDateController.text,
                'maxPublishDate': maxPublishDateController.text,
                'specificPublishDate': specificPublishDateController.text,
                'yearsOfExperience': int.tryParse(yearsOfExperienceController.text) ?? 0,
              };
              Navigator.of(context).pop(params);
            },
          ),
        ],
      );
    },
  );
}