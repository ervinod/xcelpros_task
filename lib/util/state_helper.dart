import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  BuildContext _context;
  bool _isProgressDialogShowing = false;
  GlobalKey<ScaffoldState> _scaffoldState;

  ///This method must be called in the initState method of the inheriting class
  init(BuildContext context, GlobalKey<ScaffoldState> scaffoldState, {State state}) {
    this._context = context;
    this._scaffoldState = scaffoldState;

  }


  void showProgressDialog() {
    showDialog(
        context: _context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 16,
                  ),
                  Text("Please wait..."),
                ],
              ),
            ),
          );
        });
    _isProgressDialogShowing = true;
  }

  void hideProgressDialog() {
    if (_isProgressDialogShowing) {
      Navigator.pop(_context);
      _isProgressDialogShowing = false;
    }
  }


  void showSnackBar(String text, {Color color = Colors.red}) {
    _scaffoldState.currentState
        .showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }

  void showServerError() {
    showSnackBar("Server error occured", color: Colors.red.shade800);
  }

  //function to show toast message on screen
  void showShortToast(BuildContext context, String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT);
  }

  //function to show long time toast message on screen
  void showLongToast(BuildContext context, String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG);
  }

  static void showSnackBarMessage(GlobalKey<ScaffoldState> scaffoldState, String text, {Color color = Colors.red}) {
    scaffoldState.currentState
        .showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }

  void printLog(String text) {
    final pattern = RegExp('.{2048}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }


  static Future<bool> isOnline() async{
    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.none) {
      return false;
    } else if (connection == ConnectivityResult.mobile || connection == ConnectivityResult.wifi) {
      return true;
    }else{
      return true;
    }
  }

}
