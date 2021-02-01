import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xcel_pros_task/models/dashboard_item.dart';
import 'package:xcel_pros_task/util/constants.dart';
import 'package:xcel_pros_task/util/state_helper.dart';
import 'package:xcel_pros_task/views/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardScreenState();
  }
}

class DashboardScreenState extends State<DashboardScreen> with Helper {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  List<DashboardItem> _itemList = [];
  bool _didGetData = false;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    super.init(context, _scaffoldState, state: this);
  }

  @override
  Widget build(BuildContext context) {

    if(!_didGetData){
      _didGetData = true;
      getDashboardData();
    }
    return Scaffold(
      key: _scaffoldState,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Image.asset(icBulb, fit: BoxFit.cover), title: Text("")),
          BottomNavigationBarItem(icon: Image.asset(icHome, fit: BoxFit.cover), title: Text("")),
          BottomNavigationBarItem(icon: Image.asset(icSettings, fit: BoxFit.cover), title: Text("")),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xFF0F303D),
            height: 220,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    controlPanel,
                    style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  SizedBox(child: Image.asset(userIcon, fit: BoxFit.cover)),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 180),
            child: Container(
              padding: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  color: Color(0xFFF6F8FB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  )),
              child: GridView.count(
                  childAspectRatio: 1.0,
                  padding: EdgeInsets.only(left: 25, right: 25),
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  children: List.generate(_itemList.length, (index) {

                    DashboardItem data = _itemList[index];
                    return GestureDetector(
                      onTap: (){
                        addRoute(SettingsScreen(data, index));
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                data.img,
                                width: 52,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                data.title,
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(color: Color(0xFF393939), fontSize: 16, fontWeight: FontWeight.w600)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                              child: Text(
                                data.quantity,
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(color: Color(0xFFF3A836), fontSize: 14, fontWeight: FontWeight.w600)),
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          )
        ],
      ),
    );
  }

  //add screen to navigator
  void addRoute(Widget module) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => module),
    );
  }

  //add dummy data to list
  void getDashboardData() {
    _itemList.add(DashboardItem("Bed Room","4 Lights","assets/images/bed.png" ));
    _itemList.add(DashboardItem("Living Room","2 Lights","assets/images/room.png" ));
    _itemList.add(DashboardItem("Kitchen","5 Lights","assets/images/kitchen.png" ));
    _itemList.add(DashboardItem("Bathroom","1 Light","assets/images/bathtube.png" ));
    _itemList.add(DashboardItem("Outdoor","5 Lights","assets/images/house.png" ));
    _itemList.add(DashboardItem("Balcony","2 Lights","assets/images/balcony.png" ));
  }
}
