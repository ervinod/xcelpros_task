import 'package:flutter/material.dart';
import 'package:xcel_pros_task/util/PortraitModeMixin.dart';
import 'package:xcel_pros_task/views/signin_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget with PortraitModeMixin {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //calling super.build() for locking screen rotation
    super.build(context);

    return MaterialApp(
      title: 'Assignment Task',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF0F303D, {
          50: Color(0xFF0F303D),
          100: Color(0xFF0F303D),
          200: Color(0xFF0F303D),
          300: Color(0xFF0F303D),
          400: Color(0xFF0F303D),
          500: Color(0xFF0F303D),
          600: Color(0xFF0F303D),
          700: Color(0xFF0F303D),
          800: Color(0xFF0F303D),
          900: Color(0xFF0F303D),
        }),
        fontFamily: 'ProductSans',
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInScreen(),
    );
  }
}
