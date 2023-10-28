import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_model/control_view_model.dart';

class ControlView extends StatelessWidget {
  const ControlView();
// bottom navigation bar دي علشان اظهر الصفحه مع ال
  @override
  Widget build(BuildContext context) {
    //زي ال get builder بس من غير ال controller
    return GetBuilder<ControlViewModel>(
      //init بديها الكنترولر بتاعي
      init: Get.put(ControlViewModel()),
      builder: (controller) => Scaffold(
        bottomNavigationBar: _BottomNavigationBar(),
        body: controller.currentScreen,
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  // const bottomNavigationBar();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => CurvedNavigationBar(
        index: controller.navigatorValue,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          //علشان لما ادوس يغير المكان
          controller.changeSelectedValue(index);
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
