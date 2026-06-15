
import 'package:fitlife/Reposetory/Firebase/Firebase_Auth/check_user.dart';
import 'package:fitlife/Reposetory/Firebase/firebase_options.dart';
import 'package:fitlife/ViewModel/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(ChangeNotifierProvider(create: (_) => CurrentUserProvider(),child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitLife',
      debugShowCheckedModeBanner: false,
      home: checkuser(),
    );
  }
}

