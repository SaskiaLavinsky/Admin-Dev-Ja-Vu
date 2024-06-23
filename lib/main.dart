import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soft_dev_ja_vu/controller/home_controller.dart';
import 'package:soft_dev_ja_vu/firebase_options.dart';
import 'package:soft_dev_ja_vu/pages/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  //? registering my controller
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 148, 45, 38),),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

