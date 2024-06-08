import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/utils/navigator.dart';
import 'package:graduation_project_admin/views/culture_content_view/ContentCubit/content_cubit.dart';

import '../../Widgets/LIstIem.dart';
import '../../Widgets/UserList.dart';
import '../../Widgets/manegmentButtons.dart';
import 'add_content_view.dart';

class CultureView extends StatelessWidget {
  const CultureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContentCubit()..getContent(),
      child: BlocBuilder<ContentCubit, ContentState>(
        builder: (context, state) {
          final cubit = ContentCubit.get(context);

          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [

                Text(
                  "Culture Content",
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                    onPressed: () {
                    navigateToScreen(context, AddContentView(title: "Add Content"));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                    child: Text('Add Content', style: TextStyle(fontSize: 20, color: Colors.white))),
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
                      "Content",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    state is GetContentLoading?CircularProgressIndicator(): Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cubit.contentModel!.length,
                        itemBuilder: (context, index) {
                          print (cubit.contentModel![index].ContentId);
                          return ListItem(
                            firstTitle: cubit.contentModel![index].title!,
                            SecondTitle: cubit.contentModel![index].description!,
                            BottomTitle1: "Edit",
                            BottomTitle2: "Delete",
                            onPressedEdit: () {
                              navigateToScreen(context, AddContentView(title: "Edit Content",contentModel: cubit.contentModel![index],));
                            },
                            onPressedDelete: () {

                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Text("Are you sure you want to delete this content?"),
                                  actions: [
                                    TextButton(onPressed: (){
                                      cubit.deleteContent(ContentId: cubit.contentModel![index].ContentId);
                                      cubit .getContent();
                                      Navigator.pop(context);
                                    }, child: Text("Yes")),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("No")),
                                  ],
                                );
                              });

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
