// ignore_for_file: camel_case_types


import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Image_picker extends StatefulWidget {
  const Image_picker({ Key? key }) : super(key: key);

  @override
  State<Image_picker> createState() => _Image_pickerState();
}

class _Image_pickerState extends State<Image_picker> {
  var pimage;
  Future getImage() async{
    final ImagePicker _picked = ImagePicker();
    final XFile? image = await _picked.pickImage(
      source: ImageSource.gallery,
      maxHeight: 500
    );
    setState(() {
      pimage = kIsWeb? Image.network(image!.path):Image.file(File(image!.path));
    });
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
              child: pimage == null? Text('data'): pimage,
            ),
            IconButton(
              onPressed: (){
                getImage();
              }, 
              icon: const Icon(Icons.camera)
            ),
            ElevatedButton(
              onPressed: (){}, 
              child: const Text('Submit')
            )
          ],
        ),
      ),
    );
  }
}