import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_travel_demo/screens/lobby_screen.dart';
import 'package:flutter_travel_demo/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  // 플러터에서 파베를 쓸려면 initializeApp()을 쓰는데 이게 비동기라서
  // 플러터 앱이 실행되기 전에 반드시 ensureInitialized로 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'travel app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), // 로그인이 되어있는지 확인
        builder: (context, snapshot){
          if(snapshot.hasData){
            return LobbyScreen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}