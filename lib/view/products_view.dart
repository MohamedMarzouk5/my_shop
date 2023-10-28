import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:myshop/view/widgets/custom_text.dart';

import '../helper/extenstion.dart';
import '../view_model/product_view_model.dart';
import 'details_product_view.dart';
import 'new_product_view.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(
      init: ProductViewModel(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.to(() => NewProductView());
                          },
                          child: const Text('+')
                          // Image.asset(
                          //   'assets/images/chat.png',
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .1,
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          onChanged: (value) {
                            controller.filter(value);
                          },
                          controller: controller.searchEditController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.black),
                            suffixIcon: controller.clearButton,
                            hintText: "Type To Search....",
                            hintStyle: const TextStyle(color: Colors.black),
                            fillColor: Colors.white70,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // controller.itemNotFound  ?
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#1E2336'),
                    ),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 120,
                          child: Card(
                            elevation: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            color: HexColor.fromHex('#1E2336'),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: [
                                  controller.productModel[index].image!.isEmpty
                                      ? Image.asset(
                                          'assets/images/reject.jpg',
                                          width: 80,
                                          fit: BoxFit.fitHeight,
                                          height: 150,
                                        )
                                      : Image.file(
                                          File(
                                              '${controller.pathWithoutName + '/' + controller.productModel[index].image}'),
                                          width: 80,
                                          fit: BoxFit.fitHeight,
                                          height: 150,
                                        ),
                                  // Container(
                                  //   width: 80,
                                  //   decoration: BoxDecoration(
                                  //     image: DecorationImage(
                                  //       colorFilter: ColorFilter.mode(
                                  //         Colors.black.withOpacity(0.4),
                                  //         BlendMode.darken,
                                  //       ),
                                  //       image: const AssetImage(
                                  //           'assets/images/reject.jpg'),
                                  //       fit: BoxFit.cover,
                                  //     ),
                                  //   ),
                                  // ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 9),
                                        child: Row(
                                          children: [
                                            const CustomText(
                                              text: 'الاسم : ',
                                              fontSize: 15,
                                              alignment: Alignment.topRight,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            230),
                                                child: CustomText(
                                                  text: controller
                                                      .productModel[index].name
                                                      .toString(),
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(
                                          children: [
                                            const CustomText(
                                              color: Colors.blue,
                                              text: 'السعر : ',
                                              fontSize: 20,
                                            ),
                                            CustomText(
                                              text: controller
                                                  .productModel[index].price
                                                  .toString(),
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                const CustomText(
                                                  color: Colors.blue,
                                                  text: 'الكميه : ',
                                                  fontSize: 20,
                                                ),
                                                CustomText(
                                                  text: controller
                                                      .productModel[index]
                                                      .quantity
                                                      .toString(),
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // const ListTile(
                                      //   //i want to display different items for each list in the leading property.
                                      //   leading: Icon(
                                      //     Icons.access_alarms,
                                      //   ),
                                      //   title: Text('nnnnn'),
                                      // ),
                                    ],
                                  ),

                                  Expanded(
                                    child: Container(
                                      alignment: AlignmentDirectional.centerEnd,
                                      // child: Padding(
                                      //   padding:
                                      //       AlignmentDirectional.centerEnd,
                                      child: IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            Get.to(DetailsProductView(
                                              productModel: controller
                                                  .productModel[index],
                                            ));
                                          }),
                                    ),
                                  ),

                                  //i want to display different items for each list in the leading property.
                                  // Expanded(
                                  //   child: ListTile(
                                  //     //i want to display different items for each list in the leading property.
                                  //     trailing: IconButton(
                                  //         icon: const Icon(
                                  //           Icons.edit,
                                  //           color: Colors.red,
                                  //         ),
                                  //         onPressed: () {
                                  //           Get.to(DetailsProductView(
                                  //             productModel: controller
                                  //                 .productModel[index],
                                  //           ));
                                  //         }),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: controller.productModel.length,
                    ),
                  ),
                )
                // : Center(
                //     child: Text('mohamed'),
                //   ),
              ],
            )),
      ),
    );
  }
}
