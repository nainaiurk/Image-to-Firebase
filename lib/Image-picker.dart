// ignore_for_file: camel_case_types, prefer_const_constructors, file_names


import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Image_picker extends StatefulWidget {
  const Image_picker({ Key? key }) : super(key: key);

  @override
  State<Image_picker> createState() => _Image_pickerState();
}

class _Image_pickerState extends State<Image_picker> {
  var pimage;
  var image;
  FirebaseStorage storage = FirebaseStorage.instance;
  Future getImage() async{
    ImagePicker _picked = ImagePicker();
    image = await _picked.pickImage(
      source: ImageSource.gallery,
      maxHeight: 500
    );
    if (kIsWeb){
      setState(() {
        pimage = Image.network(image!.path);
      });
    }
    else{
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false
          ),
        // iosUiSettings: IOSUiSettings(
        //   minimumAspectRatio: 1.0,
        // )
      );
      setState(() {
        pimage = Image.file(
          File(croppedFile!.path,)
        );
      });
    }
    
  }

  Future uploadImage() async {
    var file = File(image!.path);
    if (image != null){
        //Upload to Firebase
        var snapshot = await storage.ref('files/')
        .child('image')
        .putFile(file);
      } 
      else {
        print('No Image Path Received');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  [
            Container(
              height: 500,
              child: pimage,
            ),
            IconButton(
              onPressed: (){
                getImage();
              }, 
              icon: const Icon(Icons.camera)
            ),
            ElevatedButton(
              onPressed: (){
                uploadImage();
              }, 
              child: const Text('Submit')
            )
          ],
        ),
      ),
    );
  }
}