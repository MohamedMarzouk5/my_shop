import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../core/services/database.dart';
import '../model/product_model.dart';
import '../view/products_view.dart';
import '../view/widgets/custom_text.dart';

class ProductViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  List<ProductModel> _productModel = [];
  List<ProductModel> get productModel => _productModel;

  var dbHelper = ProductDatabaseHelper.db;

  //images
  final ImagePicker _picker = ImagePicker();
  File file = File('');
  String _imageName = '';
  get imageName => _imageName;
  String _appDocumentsPath = '/data/user/0/com.example.mystore/app_flutter';
  get pathWithoutName => _appDocumentsPath;

//search
  TextEditingController searchEditController = TextEditingController();
  IconButton? _clearButton;
  get clearButton => _clearButton;
  // String? _itemNotFound;
  // get itemNotFound => _itemNotFound;

  ProductViewModel() {
    getAllProduct();
  }
  getAllProduct() async {
    _loading.value = true;
    _productModel = await dbHelper.getAllProduct();
    // print(_productModel.length);
    _loading.value = false;
    update();
  }

  addProduct(ProductModel productModel) async {
    //نشوف الاول الباركود ده موجود ولا لأ
    for (int i = 0; i < _productModel.length; i++) {
      if (_productModel[i].barcodeNumber == productModel.barcodeNumber) {
        Get.snackbar(
          '',
          '',
          titleText: const CustomText(
            text: 'هذا المنتج موجود بالفعل',
            alignment: Alignment.bottomCenter,
          ),
          messageText: const CustomText(
            text: '',
          ),
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }
    await dbHelper.insert(productModel);
    _productModel.add(productModel);
    Get.to(const ProductsView());
    update();
  }

  updateProduct(ProductModel productModel) async {
    await dbHelper.updateProduct(productModel);
    update();
  }

  //images
  onImageButtonPressed() async {
    try {
      final fileFromPicker =
          await _picker.pickImage(source: ImageSource.camera);
      // print('before' + '${file}');
      file = File(fileFromPicker!.path);
      _imageName = file.path.split('/').last;
      // print('name ' + _imageName);
      setImage(file, _imageName);
      // print('filename' + '${file}');
    } catch (e) {
      print(e);
    }
    // dbHelper.insert();
//     setState(() async {
//       file = File(myfile!.path);
//       String base64 = base64Encode(file.readAsBytesSync());
//       String imageName = file.path.split('/').last;
// //ده الص هعلشان تحطه
//       Directory appDocumentsDirectory =
//           await getApplicationDocumentsDirectory(); // 1
//       String appDocumentsPath = appDocumentsDirectory.path; // 2
//       final File newImage = await file.copy('$appDocumentsPath/images.png');

//       img.photoName = base64;
//       dbHelper.save(img);
//       print('name ' + img.photoName);
//       // print('base64 ' + base64);
//       print('m ' + '${newImage}');
//       // getAllProduct(img.photoName);
//       // print('newImage ' + '${newImage}');
//       // print('base64 ' + img.photoName);
//     },);
  }

  setImage(File file, String imageName) async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    _appDocumentsPath = appDocumentsDirectory.path; // 2
    print('_appDocumentsPath' + _appDocumentsPath);
    // String filePath = '$appDocumentsPath/demoTextFile.txt';
    final File pathInPhone =
        await file.copy('$_appDocumentsPath/$imageName'); // 3
  }

  //===========================================
  // function to filter list and return result
  //===========================================
  void filter(String query) {
    // List<ProductModel> mockList = [];
    // mockList.addAll(productModel);

    if (query.isNotEmpty) {
      List<ProductModel> tempListData = [];

      _productModel.forEach((item) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          tempListData.add(item);
        }
        // else {
        //   _itemNotFound = 'لا يوجد هذا العنصر';
        // }
      });

      _productModel.clear();
      _productModel.addAll(tempListData);
      _clearButton = IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          searchEditController.clear();
          _clearButton = null;

          _productModel.clear();
          getAllProduct();
        },
      );
      update();
      return;
    } else {
      _clearButton = null;
      getAllProduct();
      update();
    }
  }
}
