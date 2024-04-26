import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taskit/controller/TaskitController.dart';
import 'package:taskit/helper/FbAuthHelper.dart';
import 'package:taskit/views/screen/HomePage.dart';
import 'package:taskit/views/screen/LoginPage.dart';

import 'controller/RegisterController.dart';
import 'controller/ThemeController.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => RegistrationController()),
    ChangeNotifierProvider(create: (_) => TaskitController()),
    ChangeNotifierProvider(create: (_) => ThemeController()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskit',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeController>(context).isDark
          ? ThemeData.dark()
          : ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff0f1933)),
              useMaterial3: true,
              textTheme: GoogleFonts.openSansTextTheme(),
            ),
      home: FBAuthHelper.fbAuthHelper.auth.currentUser == null
          ? LoginPage()
          : HomePage(),
    );
  }
}
