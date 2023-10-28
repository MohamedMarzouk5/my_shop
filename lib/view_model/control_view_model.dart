import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/data_analysis_view.dart';
import '../view/home.dart';
import '../view/products_view.dart';

class ControlViewModel extends GetxController {
  //دي علشان نخلي ال الهوم فيو في النص ولما نتحرك يغيرها
  //لو صفر هتبدأ من الشمال
  int _navigatorValue = 1;
  Widget _currentScreen = HomeScreen();

  int get navigatorValue => _navigatorValue;

  get currentScreen => _currentScreen;
  void changeSelectedValue(int selectedValue) {
    switch (selectedValue) {
      case 0:
        //علشان تبقي اول واحده
        _currentScreen = const DataAnalysisView();
        break;

      case 1:
        _currentScreen = const HomeScreen();

        break;
      case 2:
        _currentScreen = const ProductsView();
    }
    //هنا بنحط قيمه ال selected علشان يغير من قيمته
    _navigatorValue = selectedValue;
    update();
  }
}
