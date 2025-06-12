import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello/firebase_options.dart';
import 'package:hello/pages/home.dart';
import 'package:hello/provider/loading_provider.dart';
import 'package:hello/provider/message_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MessageProvider>(create:(context) => MessageProvider(),),
    ChangeNotifierProvider<IsLoading>(create:(context) => IsLoading(),),
  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

