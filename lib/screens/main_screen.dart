import 'package:flutter/material.dart';
import 'package:flutter_travel_demo/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_travel_demo/screens/lobby_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance; // 사용자등록, 로그인 메서드 제공
  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/kislev.jpg'),
                    fit: BoxFit.fill,
                  )
                ),
                padding: EdgeInsets.only(top: 60, left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Welcome',
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                        children: [
                          TextSpan(
                          text: isSignupScreen ? ' to kislev': ' to kislev',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        ] 
                      )
                    ),
                    Text(
                      isSignupScreen ? 'Signup to continue' : 'Login to continue',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ),
            // 뒷배경
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: 260,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                padding: EdgeInsets.all(20),
                height: isSignupScreen ? 300 : 240,
                width: MediaQuery.of(context).size.width-40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      spreadRadius: 5,
                      color: Colors.black.withOpacity(0.3),
                    )
                  ]
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom:20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  '로그인',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen ? Palette.activeColor : Palette.textColor1
                                  ),
                                ),
                                if(!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Color.fromARGB(255, 24, 82, 129),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  '회원가입',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:isSignupScreen ? Palette.activeColor : Palette.textColor1
                                  ),
                                ),
                                if(isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 75,
                                  color: Color.fromARGB(255, 24, 82, 129),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      if (isSignupScreen)
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                key: ValueKey(1),
                                validator: (value) { // 유효성 검사
                                  if(value!.isEmpty || value.length < 4){
                                    return 'Please enter at least 4 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value) { // 저장
                                  userName = value!;
                                },
                                onChanged: (value) {
                                  userName = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Palette.iconColor,
                                  ), 
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  hintText: 'User Name',
                                  hintStyle: TextStyle(
                                    color: Palette.textColor1,
                                    fontSize: 15
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              // 유저 이름

                              SizedBox(height: 10),

                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey(2),
                                validator: (value) {
                                  if(value!.isEmpty || !value.contains('@')){
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userEmail = value!;
                                },
                                onChanged: (value) {
                                  userName = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.mail_outlined,
                                    color: Palette.iconColor,
                                  ), 
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  hintText: 'E-mail',
                                  hintStyle: TextStyle(
                                    color: Palette.textColor1,
                                    fontSize: 15
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              // 유저 이메일
                              SizedBox(height:10),

                              TextFormField(
                                obscureText: true,
                                key: ValueKey(3),
                                validator: (value) {
                                  if(value!.isEmpty || value.length < 6){
                                    return 'Password must be at least 7 characters long';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userPassword = value!;
                                },
                                onChanged: (value) {
                                  userName = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_rounded,
                                    color: Palette.iconColor,
                                  ), 
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Palette.textColor1,
                                    fontSize: 15
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              // 유저 비밀번호
                            ],
                          ),
                        ),
                      ),
                      // 회원가입 화면

                      if (!isSignupScreen)
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                key: ValueKey(4),
                                validator: (value) {
                                  if(value!.isEmpty || !value.contains('@')){
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userEmail = value!;
                                },
                                onChanged: (value) {
                                  userEmail = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.mail_outlined,
                                    color: Palette.iconColor,
                                  ), 
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  hintText: 'E-mail',
                                  hintStyle: TextStyle(
                                    color: Palette.textColor1,
                                    fontSize: 15
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                key: ValueKey(5),
                                validator: (value) {
                                  if(value!.isEmpty || value.length < 6){
                                    return 'Password must be at least 7 characters long';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userPassword = value!;
                                },
                                onChanged: (value) {
                                  userPassword = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_rounded,
                                    color: Palette.iconColor,
                                  ), 
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Palette.textColor1,
                                    fontSize: 15
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                      // 로그인 화면
                    ],
                  ),
                ),
              ),
            ),
            // 텍스트 필드
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: isSignupScreen ? 500 : 450,
              right: 0,
              left: 0,
              child: Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: EdgeInsets.all(15),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: GestureDetector(
                    onTap: () async{
                      if(isSignupScreen){
                        _tryValidation(); // 로그인 시도

                        try{
                          final newUser = await _authentication.createUserWithEmailAndPassword( 
                            email: userEmail, 
                            password: userPassword,
                          );

                          if(newUser.user != null){ 
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context){
                                return LobbyScreen();
                              }),
                            );
                          }// 회원가입 성공 시 로비 화면으로 이동
                        } catch(e){ // 회원가입 실패 시
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar( // 에러 메시지 출력
                            SnackBar(
                              content: Text('이메일 혹은 비밀번호를 다시 확인하십시오.'),
                            ),
                          );
                        }
                      } // 회원가입 창에서 로그인 버튼을 눌렀을 때

                      if(!isSignupScreen){
                        _tryValidation(); // 로그인 시도

                        try{
                          final newUser = await _authentication.signInWithEmailAndPassword(
                            email: userEmail, 
                            password: userPassword,
                          );
                          if(newUser.user != null){ 
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context){
                                  return LobbyScreen();
                                }
                              ),
                            );
                          }
                        }catch(e){
                          print(e);
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:[
                            Colors.blue,
                            Color.fromARGB(255, 166, 192, 236),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                          // gradientDirection: GradientDirection.,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset:Offset(0,1)
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              )
            ),
            // 중앙 화살표 버튼
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn, 
              top:isSignupScreen ? MediaQuery.of(context).size.height-125 : MediaQuery.of(context).size.height-165,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(isSignupScreen ? 'or sign up with' : 'or login with', style: TextStyle(color: Colors.grey[700], fontSize: 16),),
                  SizedBox(height: 10,),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: Size(155, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    icon: Icon(Icons.add), 
                    label: Text('Google'),
                  )
                ],
              )
            ),
            // 구글 로그인 버튼
            
          ],
        ),
      ),
    );
  }
}