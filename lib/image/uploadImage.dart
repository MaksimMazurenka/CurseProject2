// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:helper_app/network/network_kall.dart';
import 'package:helper_app/state/image_state.dart';
import 'package:helper_app/state/result_state.dart';
import 'package:helper_app/state/upload_state.dart';
import 'package:image_picker/image_picker.dart';

class Imaginate extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("UPLOAD_IMAGE"),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ignore: deprecated_member_use
                    RaisedButton(onPressed: () async {
                      var picker =  ImagePicker();
                      var pickedFile = await picker.getImage(source: ImageSource.gallery); //change to camera in future
                      if(pickedFile != null){
                        context.read(imageProvider).state = pickedFile.path;
                        context.read(uploadState).state = STATE.PICKED;
                      }
                    },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.brown)
                        ),
                        color: Colors.brown,
                        textColor: Colors.white,
                        child: Text('Pick Image'.toUpperCase(), style: TextStyle(fontSize: 14))),
                    // ignore: deprecated_member_use
                    RaisedButton(onPressed: () async {
                      context.read(uploadState).state = STATE.UPLOAD;
                      var imageUri = await uploadImageApi(context.read(imageProvider).state);
                      if(imageUri != null){
                        context.read(uploadState).state = STATE.SUCCESS;
                        context.read(resultProvider).state = imageUri;
                      }else{
                        context.read(uploadState).state = STATE.ERROR;
                      }
                    },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.brown)
                        ),
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: Text('Upload image'.toUpperCase(), style: TextStyle(fontSize: 14))),
                    // Expanded(child: Consumer(builder:(context, watch,_){
                    //   final _imageUri = watch(imageProvider).state;
                    //   final _uploadState = watch(uploadState).state;
                    //   return _imageUri == null ? Center(child: Text('Image not found')) :
                    //   _uploadState ==  STATE.NORMAL ? Center(child: Text('Please select image')):
                    //   _uploadState ==  STATE.PICKED ? Image.file(File(_imageUri)) :
                    //   _uploadState ==  STATE.ERROR ? Center(child: Text('Error while upload')):
                    //   _uploadState ==  STATE.SUCCESS ? Center(child: Text('Successfully uploaded')) :
                    //   Center(child: CircularProgressIndicator());
                    // }),)
                  ],
                )
              ],
            ),
          ),

        )
    );
  }
}

