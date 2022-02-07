import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  String? uid = GetStorage().read('uid');
  bool? isGoogle = GetStorage().read('isGoogle');
  runApp(MyApp(uid, isGoogle));
}

class MyApp extends StatelessWidget {
  final String? uid;
  final bool? isGoogle;
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  MyApp(this.uid, this.isGoogle);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: uid == null ? AppPages.INITIAL : Paths.HOME,
      getPages: AppPages.routes,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
