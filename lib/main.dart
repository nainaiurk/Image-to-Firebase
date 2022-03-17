// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_to_firebase/Image-picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
  // if(Firebase.apps.isEmpty){
   await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyA1iKODLUsTJzarMCdzy5CXxvL64_DvXtQ",
        authDomain: "imagepicker-adfc0.firebaseapp.com",
        projectId: "imagepicker-adfc0",
        storageBucket: "imagepicker-adfc0.appspot.com",
        messagingSenderId: "711140926864",
        appId: "1:711140926864:web:4535a75c3ebc7082cdff15",
        measurementId: "G-06QSZER1M5"
      )
    ).whenComplete(() => runApp(MyApp()));
  }

  else {
    await Firebase.initializeApp();
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Image_picker(),
    );
  }
}

