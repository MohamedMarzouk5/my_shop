class ProductModel {
  String? name;
  String? price;
  String? quantity;
  String? barcodeNumber;
  String? image;

  ProductModel({
    this.name,
    this.price,
    this.quantity,
    this.barcodeNumber,
    this.image,
  });
  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    price = map['price'];
    quantity = map['quantity'];
    barcodeNumber = map['barcodeNumber'];
    image = map['image'];
  }
  // ProductModel.fromJson(Map<dynamic, dynamic> map) {
  //   if (map == null) {
  //     return;
  //   }
  //   name = map['name'];
  //   price = map['price'];
  //   quantity = map['quantity'];
  //   barcodeNumber = map['barcodeNumber'];
  // }
  toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'barcodeNumber': barcodeNumber,
      'image': image,
    };
  }
}
