import 'package:flutter/widgets.dart';
import 'package:sqlfliteshop/models/product_model.dart';

class ProductsVM with ChangeNotifier {
  // List<Products> lst = List<Products>();
  List<ProductModel>? productList = [];

  add(String? productImage, String? productPrice, String? productName) {
    productList?.add(ProductModel(
        productImage: productImage,
        productPrice: productPrice,
        productName: productName));
    notifyListeners();
  }

  // del(int index) {
  //   ProductModel!.removeAt(index);
  //   notifyListeners();
  // }
}
