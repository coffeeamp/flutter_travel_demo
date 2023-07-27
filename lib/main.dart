import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_travel_demo/post/post_provider.dart'; // 위에서 정의한 PostProvider 클래스 파일
import 'package:flutter_travel_demo/screens/lobby_screen.dart';
import 'package:flutter_travel_demo/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: MaterialApp(
        title: 'travel app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(), // 로그인이 되어있는지 확인
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return LobbyScreen();
            }
            return LoginSignupScreen();
          },
        ),
      ),
    );
  }
}
