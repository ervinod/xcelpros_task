import 'package:flutter/material.dart';
import 'package:xcel_pros_task/animation/fade_animation.dart';
import 'package:xcel_pros_task/util/constants.dart';
import 'package:xcel_pros_task/util/state_helper.dart';
import 'package:xcel_pros_task/views/get_started_creen.dart';
import 'package:xcel_pros_task/views/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> with Helper {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    super.init(context, _scaffoldState, state: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              //adding gradient color background
                begin: Alignment.topCenter, colors: [
                  Color(0xFF0F303D), Color(0xFF0F303D), Color(0xFF0F303D)
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(background1),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Container(
                      color: kWhiteColor,
                      width: 55,
                      height: 4,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FadeAnimation(
                      1,
                      Text(
                        welcome,
                        style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        roomControl,
                        style: TextStyle(color: Colors.white, fontSize: 27),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.asset(usernameIcon, fit: BoxFit.cover),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: TextField(
                                            focusNode: usernameFocus,
                                            controller: usernameController,
                                            decoration: InputDecoration(
                                              hintText: userName,
                                              hintStyle: TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(passwordIcon, fit: BoxFit.cover),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: TextField(
                                            obscureText: true,
                                            focusNode: passwordFocus,
                                            controller: passwordController,
                                            decoration: InputDecoration(
                                              hintText: password,
                                              hintStyle: TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 3, left: 3),
                                      child: MaterialButton(
                                        minWidth: double.infinity,
                                        height: 60,
                                        onPressed: () {
                                          validateInput();
                                        },
                                        color: Color(0xFF4FA89B),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          "SIGN IN",
                                          style:
                                              TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.grey, fontSize: 18),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    addRoute(SignUpScreen());
                                  },
                                  child: Text(
                                    signUp,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF4FA89B)),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //add screen
  void addRoute(Widget module) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => module),
    );
  }

  //replace screen
  void replaceRoute(Widget widget) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => widget,
        ));
  }

  //check user input validation
  void validateInput() {
    if (usernameController.text.isEmpty) {
      showShortToast(context, usernameEmptyMessage);
    } else if (passwordController.text.isEmpty) {
      showShortToast(context, passwordEmptyMessage);
    } else {
      usernameFocus.unfocus();
      passwordFocus.unfocus();
      replaceRoute(GetStartedScreen());
    }
  }
}
