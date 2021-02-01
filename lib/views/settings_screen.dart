import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:xcel_pros_task/animation/fade_animation.dart';
import 'package:xcel_pros_task/models/color_item.dart';
import 'package:xcel_pros_task/models/dashboard_item.dart';
import 'package:xcel_pros_task/models/gradient_item.dart';
import 'package:xcel_pros_task/util/constants.dart';
import 'package:xcel_pros_task/util/state_helper.dart';

class SettingsScreen extends StatefulWidget {
  DashboardItem data;
  int selectedPosition;
  int prevSelectedPosition;
  int selectedColorPosition;

  SettingsScreen(this.data, this.selectedPosition);

  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> with Helper {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  List<DashboardItem> _categoryList = [];
  List<ColorItem> _colorList = [];
  List<GradientItem> _scenesList = [];
  bool _didGetData = false;
  int _index = 0;
  double _intensity = 10;
  double bulbOpacity = 0.5;
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    super.init(context, _scaffoldState, state: this);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    //getting screen width and height

    if (!_didGetData) {
      _didGetData = true;
      getCategoryData();
      //getting dummy data
    }
    return Scaffold(
      key: _scaffoldState,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Image.asset(icBulb, fit: BoxFit.cover), title: Text("")),
          BottomNavigationBarItem(icon: Image.asset(icHome, fit: BoxFit.cover), title: Text("")),
          BottomNavigationBarItem(icon: Image.asset(icSettings, fit: BoxFit.cover), title: Text("")),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, colors: [Color(0xFF0F303D), Color(0xFF0F303D), Color(0xFF0F303D)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 25.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0, right: 10),
                                  child: Image.asset(backIcon, fit: BoxFit.cover),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.data.title,
                                  style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(
                              widget.data.quantity,
                              style: TextStyle(color: Colors.amberAccent, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: FadeAnimation(
                        1,
                        Column(
                          children: <Widget>[
                            SizedBox(
                                width: 150,
                                height: 150,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(lampIcon),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )),
                            Container(
                              height: 13,
                              width: 25,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.selectedColorPosition != null
                                          ? _colorList[widget.selectedColorPosition].color.withOpacity(bulbOpacity)
                                          : kWhiteColor.withOpacity(bulbOpacity),
                                      blurRadius: 4.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0.0, 0.0), // shadow direction: bottom right
                                    )
                                  ],
                                  color: widget.selectedColorPosition != null
                                      ? _colorList[widget.selectedColorPosition].color.withOpacity(bulbOpacity)
                                      : kWhiteColor.withOpacity(bulbOpacity),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    height: 50,
                    child: _buildCategoryList(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: kSettingBackgroundColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 10),
                      child: Text(
                        intensity,
                        style: TextStyle(color: kBlackColor, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                            width: 30,
                            child: Image.asset(bulbInActive, fit: BoxFit.cover, color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                              value: _intensity.toDouble(),
                              min: 1,
                              max: 100,
                              divisions: 100,
                              activeColor: kSeekbarColor,
                              inactiveColor: Colors.grey,
                              onChanged: (double newValue) {
                                setState(() {
                                  _intensity = newValue;
                                  bulbOpacity = _intensity / 100;
                                  // log("OPACITY: ${_intensity/10}");
                                });
                              },
                              semanticFormatterCallback: (double newValue) {
                                return '${newValue.round()}';
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20.0,
                          ),
                          child: SizedBox(
                            width: 30,
                            child: Image.asset(bulbActive, fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 10),
                      child: Text(
                        colors,
                        style: TextStyle(color: kBlackColor, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _colorList.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.selectedColorPosition = index;
                            });
                          },
                          child: index==_categoryList.length?Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              left: kDefaultPadding,
                              // At end item it add extra 20 right  padding
                              right: index == _colorList.length - 1 ? kDefaultPadding : 0,
                            ),
                            child: ClipOval(
                              child: Material(
                                color: Colors.white, // button color
                                child: InkWell(
                                  splashColor: Colors.grey, // inkwell color
                                  child: SizedBox(width: 42, height: 42, child: Icon(Icons.add)),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ):Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              left: kDefaultPadding,
                              // At end item it add extra 20 right  padding
                              right: index == _colorList.length - 1 ? kDefaultPadding : 0,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            decoration: BoxDecoration(
                              color: _colorList[index].color,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 10),
                      child: Text(
                        scenes,
                        style: TextStyle(color: kBlackColor, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(10),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 2.8,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: _scenesList[0].gradientColor,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 21,
                                    height: 21,
                                    child: Image.asset(
                                      bulbInActive,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    _scenesList[0].title,
                                    style: TextStyle(color: kWhiteColor),
                                  ),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: _scenesList[1].gradientColor,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 21,
                                    height: 21,
                                    child: Image.asset(
                                      bulbInActive,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    _scenesList[1].title,
                                    style: TextStyle(color: kWhiteColor),
                                  ),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: _scenesList[2].gradientColor,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 21,
                                    height: 21,
                                    child: Image.asset(
                                      bulbInActive,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    _scenesList[2].title,
                                    style: TextStyle(color: kWhiteColor),
                                  ),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: _scenesList[3].gradientColor,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 21,
                                    height: 21,
                                    child: Image.asset(
                                      bulbInActive,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    _scenesList[3].title,
                                    style: TextStyle(color: kWhiteColor),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //adding route to navigator
  void addRoute(Widget module) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => module),
    );
  }

  //this function will return horizontal list of categories
  Widget _buildCategoryList() {
    return AnimationLimiter(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categoryList.length,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                horizontalOffset: width * 0.5,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.data = _categoryList[index];
                      _categoryList[widget.selectedPosition].isSelected = false;
                      widget.selectedPosition = index;
                      _categoryList[widget.selectedPosition].isSelected = true;
                      getProductDetails();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: kDefaultPadding,
                      // At end item it add extra 20 right  padding
                      right: index == _categoryList.length - 1 ? kDefaultPadding : 0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      color: index == widget.selectedPosition ? kAccentColor : kWhiteColor,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 21,
                          height: 21,
                          child: Image.asset(
                            _categoryList[index].img,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          _categoryList[index].title,
                          style: TextStyle(color: _categoryList[index].isSelected ? kWhiteColor : kAccentColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void getCategoryData() {
    _categoryList.add(DashboardItem("Bed Room", "4 Lights", "assets/images/bed.png"));
    _categoryList.add(DashboardItem("Living Room", "2 Lights", "assets/images/room.png"));
    _categoryList.add(DashboardItem("Kitchen", "5 Lights", "assets/images/kitchen.png"));
    _categoryList.add(DashboardItem("Bathroom", "1 Light", "assets/images/bathtube.png"));
    _categoryList.add(DashboardItem("Outdoor", "5 Lights", "assets/images/house.png"));
    _categoryList.add(DashboardItem("Balcony", "2 Lights", "assets/images/balcony.png"));

    widget.prevSelectedPosition = widget.selectedPosition;
    _categoryList[widget.selectedPosition].isSelected = true;

    _colorList.add(ColorItem(Color(0xFFEF999A), false, false));
    _colorList.add(ColorItem(Color(0xFF94EB9E), false, false));
    _colorList.add(ColorItem(Color(0xFF94CAEB), false, false));
    _colorList.add(ColorItem(Color(0xFFA594EB), false, false));
    _colorList.add(ColorItem(Color(0xFFDE94EB), false, false));
    _colorList.add(ColorItem(Color(0xFFEBD094), false, false));
    _colorList.add(ColorItem(Color(0xFFFFFFFF), false, true));

    _scenesList.add(GradientItem("Birthday", [Color(0xFFEF999A), Color(0xFFF1A596), Color(0xFFF4B892)], false));
    _scenesList.add(GradientItem("Party", [Color(0xFFA893EB), Color(0xFFC193EB), Color(0xFFD293EB)], false));
    _scenesList.add(GradientItem("Fun", [Color(0xFF93CAEB), Color(0xFF93D3EB), Color(0xFF94DAEB)], false));
    _scenesList.add(GradientItem("Relax", [Color(0xFF8DDE94), Color(0xFFA4E493), Color(0xFFB7EA92)], false));

    setState(() {});
  }

  void getProductDetails() {

  }
}
