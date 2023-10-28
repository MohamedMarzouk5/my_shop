import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/view/qr_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //شكل متدرج بالالوان
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Colors.blue[500]!,
            const Color.fromRGBO(83, 184, 187, 1),
            Colors.teal
          ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd)),
      child: Center(
        child: ElevatedButton(
          style: ButtonStyle(elevation: MaterialStateProperty.all(.5)),
          onPressed: () {
            Get.to(() => const QrScreen());
          },
          child: const Text('button'),
        ),
      ),
    );
  }
}
