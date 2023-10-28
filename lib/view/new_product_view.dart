import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myshop/view/qr_screen.dart';
import 'package:myshop/view/widgets/suffix_text_form_field.dart';
import 'package:myshop/view/widgets/text_form_field.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../model/product_model.dart';
import '../view_model/product_view_model.dart';
import '../view_model/qr_view_model.dart';
import 'widgets/custom_text.dart';

class NewProductView extends StatelessWidget {
  String? _name, _price, _quantity, _barcodeNumber;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(
      init: ProductViewModel(),
      builder: (controller) => Scaffold(
        // دي علشان لما الكيبورد يظهر ميظهرش خطأ
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: const [
            CustomText(
              text: 'اضافه منتج جديد',
              alignment: Alignment.topRight,
              fontSize: 50,
            ),
          ],
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('Circular image',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    Stack(children: [
                      Container(
                        width: 75.h,
                        height: 75.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: Image.asset(
                            'assets/images/reject.jpg',
                            width: 75,
                            height: 75,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.onImageButtonPressed();
                        },
                        icon: Icon(Icons.add_a_photo),
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Form(
                  key: formState,
                  child: Column(
                    children: [
                      GetBuilder<QrViewModel>(
                        init: QrViewModel(),
                        builder: (controller) => CustomTextFormField(
                            qrTextController:
                                TextEditingController(text: controller.c),
                            icon: Icons.qr_code_scanner,
                            onTap: () {
                              Get.to(QrScreen());
                            },
                            text: 'باركود ',
                            hint: 'باركود ',
                            textInputType: TextInputType.number,
                            onSave: (value) {
                              _barcodeNumber = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' من فضلك ادخل الباركود الخاص بالمنتج';
                              }
                            }),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextFormField(
                        text: 'اسم المنتج',
                        maxLetter: 38,
                        hint: 'الاسم',
                        onSave: (value) {
                          // controller.model!.name = value;
                          // Get.to(QrScreen());
                          _name = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل الاسم ';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SuffixTextFormField(
                        maxLetter: 7,
                        text: 'سعر المنتج',
                        hint: 'سعر المنتج',
                        suffixText: 'جنيه',
                        onSave: (value) {
                          // controller.model!.price = value;
                          // Get.to(QrScreen());

                          _price = value;
                        },
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' من فضلك ادخل السعر';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextFormField(
                        maxLetter: 7,
                        text: 'الكميه',
                        hint: 'كميه هذا المنتج',
                        textInputType: TextInputType.number,
                        onSave: (value) {
                          // controller.model!.quantity = value;
                          // Get.to(QrScreen());
                          _quantity = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' ادخل الكميه';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formState.currentState!.validate()) {
                            formState.currentState!.save();
                            controller.addProduct(
                              ProductModel(
                                name: _name,
                                price: _price,
                                quantity: _quantity,
                                barcodeNumber: _barcodeNumber,
                                image: controller.imageName,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
