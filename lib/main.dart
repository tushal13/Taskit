import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taskit/controller/taskitcontroller.dart';
import 'package:taskit/helper/fb_authhelper.dart';
import 'package:taskit/views/screen/homepage.dart';
import 'package:taskit/views/screen/loginpage.dart';

import 'controller/registercontroller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => RegistrationController()),
    ChangeNotifierProvider(create: (_) => TaskitController()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      home: FBAuthHelper.fbAuthHelper.auth.currentUser == null
          ? LoginPage()
          : HomePage(),
    );
  }
}
