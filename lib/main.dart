import 'package:admob_flutter/admob_flutter.dart';
import 'package:check_list_app/sign_process.dart';
import 'package:check_list_app/auth_service.dart';
import 'package:check_list_app/child_task_service.dart';
import 'package:check_list_app/parent_task_service.dart';
import 'package:check_list_app/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService.instance()),
        ChangeNotifierProvider(create: (_) => ParentTaskService()),
        ChangeNotifierProvider(create: (_) => ChildTaskService())
      ],
      child: MyApp(),
    )
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSansCondensed',
        primarySwatch: mainColor,
      ),
      home: SignProcess(),
    );
  }
}
