import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/culture_content_view/ContentCubit/content_cubit.dart';
import 'package:graduation_project_admin/views/culture_content_view/content_model/ContentModel.dart';
import 'package:graduation_project_admin/views/main_screan.dart';

class AddContentView extends StatefulWidget {
   AddContentView({Key? key, this.title, this.contentModel }) : super(key: key);
  String ?title;
  ContentModel ?contentModel;

  @override
  State<AddContentView> createState() => _AddContentViewState();
}

class _AddContentViewState extends State<AddContentView> {
  
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if(widget.contentModel != null){
      titleController.text = widget.contentModel!.title!;
      descriptionController.text = widget.contentModel!.description!;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ContentCubit(),
  child: BlocBuilder<ContentCubit, ContentState>(
  builder: (context, state) {
    final cubit = ContentCubit.get(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title!),
      titleTextStyle: TextStyle(color: Colors.blue, fontSize: 20),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  )

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Description",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
            ),

            ElevatedButton(
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20)
              )
               , onPressed: () async{

              if(widget.contentModel != null){
                ContentModel contentModel = ContentModel(
                  title: titleController.text,
                  description: descriptionController.text,

                  ContentId: widget.contentModel!.ContentId
                );
               await cubit.editContent(contentModel: contentModel);
              }else{
                   cubit.addContent(title: titleController.text, description: descriptionController.text, Category: "Culture");
              }
navigateToScreen(context, MainScrean());
            }, child: Text("Submit",style: TextStyle(fontSize: 20,color: Colors.white),)
            )
          ],
        ),
      )
      
    );
  },
),
);
  }
}
