import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/view/products_view.dart';
import 'package:myshop/view/widgets/suffix_text_form_field.dart';
import 'package:myshop/view/widgets/text_form_field.dart';

import '../model/product_model.dart';
import '../view_model/product_view_model.dart';
import '../view_model/qr_view_model.dart';
import 'qr_screen.dart';
import 'widgets/custom_text.dart';

class DetailsProductView extends StatelessWidget {
  final ProductModel productModel;
  DetailsProductView({Key? key, required this.productModel}) : super(key: key);

  // String? _name, _price, _quantity, _barcodeNumber;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // دي علشان لما الكيبورد يظهر ميظهرش خطأ
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: const [
          CustomText(
            text: 'تعديل منتج ',
            alignment: Alignment.topRight,
            fontSize: 50,
          ),
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Form(
          key: formState,
          child: Column(
            children: [
              GetBuilder<QrViewModel>(
                init: QrViewModel(),
                builder: (controller) => CustomTextFormField(
                    qrTextController:
                        TextEditingController(text: productModel.barcodeNumber),
                    icon: Icons.qr_code_scanner,
                    onTap: () {
                      Get.to(QrScreen());
                    },
                    text: 'باركود ',
                    hint: 'باركود ',
                    textInputType: TextInputType.number,
                    onSave: (value) {
                      productModel.barcodeNumber = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' من فضلك ادخل الباركود الخاص بالمنتج';
                      }
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                qrTextController:
                    TextEditingController(text: productModel.name),
                text: 'اسم المنتج',
                hint: 'الاسم',
                onSave: (value) {
                  // controller.model!.name = value;
                  // Get.to(QrScreen());
                  productModel.name = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'من فضلك ادخل الاسم ';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SuffixTextFormField(
                qrTextController:
                    TextEditingController(text: productModel.price),
                text: 'سعر المنتج',
                hint: 'سعر المنتج',
                suffixText: 'جنيه',
                onSave: (value) {
                  // controller.model!.price = value;
                  // Get.to(QrScreen());

                  productModel.price = value;
                },
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ' من فضلك ادخل السعر';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                qrTextController:
                    TextEditingController(text: productModel.quantity),
                text: 'الكميه',
                hint: 'كميه هذا المنتج',
                textInputType: TextInputType.number,
                onSave: (value) {
                  // controller.model!.quantity = value;
                  // Get.to(QrScreen());
                  productModel.quantity = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return ' ادخل الكميه';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<ProductViewModel>(
                init: ProductViewModel(),
                builder: (controller) => ElevatedButton(
                  onPressed: () {
                    if (formState.currentState!.validate()) {
                      formState.currentState!.save();
                      controller.updateProduct(productModel);
                      Get.off(const ProductsView());
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
