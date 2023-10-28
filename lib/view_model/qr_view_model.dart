import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:mystore/view/details_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';

import '../core/services/database.dart';
import '../model/product_model.dart';
import '../view/data_analysis_view.dart';
import '../view/new_product_view.dart';

class QrViewModel extends GetxController {
  List<ProductModel> _productModel = [];
  List<ProductModel> get productModel => _productModel;
  Future<ProductModel>? _model;
  var dbHelper = ProductDatabaseHelper.db;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // TextEditingController c = TextEditingController();
  String? c;
// if (fromBarcode.toString()) {

// }

  onQRViewCreated(QRViewController controller) async {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      result = scanData;

      // queryProduct(result!.code);
      print(_productModel.isEmpty);

      // if (_model! == null) {
      //   Get.snackbar(
      //     'mohamed',
      //     'no',
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      //   // Get.to(ProductsView());
      // } else {
      //   // Get.to(DetailsView());
      //   // fromBarcode.text = result!.code;
      //   c = result!.code;
      //   Get.off(NewProductView());
      // }
      update();
    });
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
    update();
  }

  queryProduct(String model) async {
    _productModel = await dbHelper.queryProduct(model);
    if (_productModel.isEmpty) {
      c = result!.code;
      Get.off(NewProductView());
    } else {
      Get.to(const DataAnalysisView());
    }
    update();
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }
}
