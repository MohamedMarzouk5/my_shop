import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/view/control_view.dart';
import 'package:myshop/view/new_product_view.dart';
// import 'package:mystore/view_model/product_view_model.dart';
import 'helper/binding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  // Get.lazyPut(() => ProductViewModel());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (constex, con) => GetMaterialApp(
        initialBinding: Binding(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.red,
          primaryColorDark: Colors.yellow,
          bottomAppBarColor: Colors.red,
        ),
        home: const ControlView(),
        routes: {
          '/DetailsView': (context) => NewProductView(),
        },
        getPages: [
          GetPage(name: '/DetailsView', page: () => NewProductView()),
        ],
      ),
      designSize: const Size(360, 640),
    );
  }
}
