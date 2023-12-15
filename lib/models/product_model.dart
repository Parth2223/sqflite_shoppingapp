import 'dart:convert';
import 'dart:typed_data';

import 'package:sqlfliteshop/widget/utils.dart';

class ProductModel {
  int? ProductId;
  int? ProductUserId;
  String? productName;
  String? productCategories;
  String? productImage;
  String? productPrice;
  String? productDesc;
  String? productFullDesc;
  String? manufacturingDate;
  List<Uint8List>? memoryImages;

  ProductModel(
      {this.ProductId,
      this.ProductUserId,
      this.productImage,
      this.productCategories,
      this.productName,
      this.productPrice,
      this.productDesc,
      this.productFullDesc,
      this.manufacturingDate,
      this.memoryImages});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'productImage': productImage,
      'ProductUserId': ProductUserId,
      'productCategories': productCategories,
      'productName': productName,
      'productPrice': productPrice,
      'productDesc': productDesc,
      'productFullDesc': productFullDesc,
      'manufacturingDate': manufacturingDate,
    };
    return map;
  }

  ProductModel.fromMap(Map<String, dynamic> map) {
    ProductId = map['ProductId'];
    ProductUserId = map['ProductUserId'];
    productImage = map['productImage'];
    productCategories = map['productCategories'];
    productName = map['productName'];
    productPrice = map['productPrice'];
    productDesc = map['productDesc'];
    productFullDesc = map['productFullDesc'];
    manufacturingDate = map['manufacturingDate'];
    memoryImages = getMemoryImage(map['productImage']);
  }

  List<Uint8List>? getMemoryImage(String imageString) {
    try {
      List<Uint8List> listOfImage = [];

      List<dynamic> imagesInString = jsonDecode(imageString);

      for (dynamic image in imagesInString) {
        Uint8List uIntList = utils.dataFromBase64String(image.toString());
        listOfImage.add(uIntList);
      }
      return listOfImage;
    } catch (error) {
      utils().toastMeassage("Image in error");
    }
    return null;
  }
}
