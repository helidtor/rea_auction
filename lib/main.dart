import 'package:flutter/material.dart';
import 'package:swp_project_web/firebase/firebase_options.dart';
import 'package:swp_project_web/firebase/auth.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/screens/login/login_screen.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getUserInfor() async {
    await getUser();
    setState(() {});
    print(uid);
  }

  @override
  void initState() {
    getUserInfor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Rea Auction',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Pallete.mainBackground,
      ),
      routerConfig: router,
    );
  }
}
