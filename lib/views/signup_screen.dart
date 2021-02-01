import 'package:flutter/material.dart';
import 'package:xcel_pros_task/animation/fade_animation.dart';
import 'package:xcel_pros_task/util/constants.dart';
import 'package:xcel_pros_task/util/state_helper.dart';
import 'package:xcel_pros_task/views/dashboard_screen.dart';
import 'package:xcel_pros_task/views/get_started_creen.dart';
import 'package:xcel_pros_task/views/signup_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> with Helper {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  bool _areTermsAccepted = false;

  @override
  void initState() {
    super.initState();
    super.init(context, _scaffoldState, state: this);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      key: _scaffoldState,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white,),
        ),
        title: new Text(
          back,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, colors: [Color(0xFF0F303D), Color(0xFF0F303D), Color(0xFF0F303D)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(background2),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1.3,
                      Text(
                        createAccount,
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
                                      Padding(
                                        padding: const EdgeInsets.only(top:12.0),
                                        child: Image.asset(usernameIcon, fit: BoxFit.cover),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left:10, right: 10, top: 20, bottom:10),
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
                                      Padding(
                                        padding: const EdgeInsets.only(top:12.0),
                                        child: Image.asset(passwordIcon, fit: BoxFit.cover),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left:10, right: 10, top: 20, bottom:10),
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
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top:12.0),
                                        child: Image.asset(emailIcon, fit: BoxFit.cover),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left:10, right: 10, top: 20, bottom:10),
                                          child: TextField(
                                            focusNode: emailFocus,
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              hintText: email,
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
                                          //check user inputs
                                        },
                                        color:Color(0xFF4FA89B),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Text(signUp, style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          color: Colors.white
                                        ),),
                                      ),
                                    ),
                                  ),                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                  value: _areTermsAccepted,
                                onChanged: (value){
                                    _areTermsAccepted = value;
                                    setState(() {});
                                },
                              ),
                              Text(haveAccepted,style: TextStyle(color: Colors.grey, fontSize: screenSize.width/30),),

                              InkWell(
                                  onTap: (){
                                  },
                                  child: Text(TNC,style: TextStyle(fontSize: screenSize.width/30,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline, color: Color(0xFF4FA89B)))),
                            ],
                          ),
                        ),
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
  void replaceRoute(Widget module){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => module,
        ));
  }
  void removeAndReplaceRoute(Widget module){
    Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => module), (Route<dynamic> route) => false);
  }

  //check if entered text is valid email address
  bool isValidEmail( String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  //check user input validation
  void validateInput() {
    if(usernameController.text.isEmpty){
      showShortToast(context, usernameEmptyMessage);
    }else if(passwordController.text.isEmpty){
      showShortToast(context, passwordEmptyMessage);
    }else if(emailController.text.isEmpty){
      showShortToast(context, emailEmptyMessage);
    }else if(!isValidEmail(emailController.text)){
      showShortToast(context, invalidEmailMessage);
    }else if(!_areTermsAccepted){
      showShortToast(context, termsAndConditions);
    }else{
      usernameFocus.unfocus();
      passwordFocus.unfocus();
      emailFocus.unfocus();
      removeAndReplaceRoute(GetStartedScreen());
    }
  }
}
