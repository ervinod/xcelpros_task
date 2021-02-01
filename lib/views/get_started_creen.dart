import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xcel_pros_task/animation/icon_rotator.dart';
import 'package:xcel_pros_task/animation/rotation_animation.dart';
import 'package:xcel_pros_task/util/constants.dart';
import 'package:xcel_pros_task/util/state_helper.dart';
import 'package:xcel_pros_task/views/dashboard_screen.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return GetStartedScreenState();
  }
}

class GetStartedScreenState extends State<GetStartedScreen> with Helper, TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

  @override
  void initState() {
    super.initState();
    super.init(context, _scaffoldState, state: this);
    Timer(Duration(seconds: 3), () async {
      replaceRoute(DashboardScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, colors: [Color(0xFF061B22), Color(0xFF113442), Color(0xFF184455)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(background3),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child:
                          /*LoadingRotating.square(
                          borderColor: Colors.white,
                          size: 60.0,
                        )*/

                          IconRotator.InOutRotation(
                            color: Colors.white,
                            size: 60.0,
                            controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Let's get you started",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
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

  void replaceRoute(Widget widget) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => widget,
        ));
  }
}
