import 'package:flutter/material.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/job_view/job_model/PersonModel.dart';
import 'package:graduation_project_admin/views/job_view/job_model/RefugeeModel.dart';
import 'package:graduation_project_admin/views/manage_user_view/CountryModel/CountryModel.dart';
import 'package:graduation_project_admin/views/manage_user_view/pdf_page.dart';
import 'package:graduation_project_admin/views/manage_user_view/refugee_info.dart';

class RefugeeDataView extends StatefulWidget  {
   RefugeeDataView({Key? key, this.personModel,this.refugeeModel,this.countryModel}) : super(key: key);
  RefugeeModel? refugeeModel;
  PersonModel? personModel;
  CountryModel? countryModel;

  @override
  State<RefugeeDataView> createState() => _RefugeeDataViewState();
}

class _RefugeeDataViewState extends State<RefugeeDataView> with TickerProviderStateMixin {
  late TabController _tabController; // Declare the TabController
  late List<Tab> myTabs; // Declare the tabs list
  late List<Widget> myPages; // Declare the pages list
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Initialize the TabController

    myTabs = <Tab>[
      Tab(
        text: 'Refugee Details',


      ),
      Tab(text: 'Refugees cv'),
    ];
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
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 20,

            children: [
              RefugeeInfo(
                label: "Refugee Name",
                value: "${widget.personModel!.firstName} ${widget.personModel!.lastName}",
              ),
              RefugeeInfo(
                label: "Refugee Email",
                value: widget.personModel!.email!,
              ),
              RefugeeInfo(
                label: "Refugee Phone",
                value: widget.personModel!.phone1!,
              ),
              RefugeeInfo(
                label: "Refugee Address",
                value: widget.personModel!.address!,
              ),
              RefugeeInfo(
                label: "Refugee Country",
                value: widget.countryModel!.countryName!,
              ),
              RefugeeInfo(
                label: "Refugee Date Of Birth",
                value: widget.personModel!.dateOfBirth!,
              ),
              RefugeeInfo(
                label: "Refugee Gender",
                value: widget.personModel!.gender== "M"? "Male":"Female",
              ),
              RefugeeInfo(
                label: "Refugee Card Start Date",
                value: widget.refugeeModel!.cardStartDate!,
              ),
              RefugeeInfo(
                label: "Refugee Card End Date",
                value: widget.refugeeModel!.cardEndDate!,
              ),
              RefugeeInfo(
                label: "Refugee Card Number",
                value: widget.refugeeModel!.refugeeCardNo!,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                ),
                onPressed: (){
                navigateToScreen(context, PdfPage(path: widget.refugeeModel!.cv!),);
              },
                  child: Text("Show cv",style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        PdfPage(
          path: widget.refugeeModel!.cv!,
        )
  ]
    )
  );



  }
}
