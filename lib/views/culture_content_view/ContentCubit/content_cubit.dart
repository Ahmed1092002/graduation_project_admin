import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../content_model/ContentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  ContentCubit() : super(ContentInitial());
  static ContentCubit get(context) => BlocProvider.of(context);

  List<ContentModel> ? contentModel;


  addContent( { String?title,String?description,String?Category } )async{

    ContentModel contentModel = ContentModel(
      title: title,
      description: description,


    );

    emit(AddContentLoading());
    await FirebaseFirestore.instance.collection('Content').add(
contentModel.toJson()
    ).then((value) {

      emit(AddContentSuccess());
    }).catchError((error){
      emit(AddContentFailure());
    });

  }
  editContent( { ContentModel? contentModel  } )async {


    emit(UpdateContentLoading());
    await FirebaseFirestore.instance.collection('Content')
        .doc(contentModel!.ContentId)
        .update(
        contentModel.toJson()
    )
        .then((value) {
      emit(UpdateContentSuccess());
    }).catchError((error) {
      emit(UpdateContentFailure());
    });
  }


  deleteContent({String?ContentId})async{
    emit(DeleteContentLoading());
    await FirebaseFirestore.instance.collection('Content')
        .doc(ContentId)
        .delete()
        .then((value) {
      emit(DeleteContentSuccess());
    }).catchError((error) {
      emit(DeleteContentFailure());
    });
  }


  getContent()async{
    emit(GetContentLoading());
    await FirebaseFirestore.instance.collection('Content').get().then((value) {


      contentModel = value.docs.map((e) => ContentModel.fromJson(e.data(),e.id)).toList();

      emit(GetContentSuccess());
    }).catchError((error){
      emit(GetContentFailure());
    });
  }

}
