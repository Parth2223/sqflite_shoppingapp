import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/product_model.dart';
import 'package:sqlfliteshop/widget/all_ctm_textformfield.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';
import 'package:sqlfliteshop/widget/custom_button.dart';
import 'package:sqlfliteshop/widget/utils.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key, this.productList, this.isloading = false});

  final ProductModel? productList;
  final bool isloading;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final fullDescController = TextEditingController();
  final manufacturingDateController = TextEditingController();
  UserHelper dbHelper = UserHelper();
  DateTime selectedDate = DateTime.now();
  bool isloading = false;
  Future<File>? imageFile;
  Image? image;
  List<ProductModel>? images;
  List<String> imgStrings = [];

  Future<void> createProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    ProductModel user = ProductModel(
        ProductUserId: userId,
        productImage: jsonEncode(imgStrings),
        productName: nameController.text,
        productPrice: priceController.text,
        productDesc: descController.text,
        productFullDesc: fullDescController.text,
        manufacturingDate: manufacturingDateController.text);
    widget.isloading
        ? dbHelper.productUpdate(user, widget.productList?.ProductId ?? 0)
        : dbHelper.productInsert(user);
    Navigator.pop(context, 'update');
    nameController.clear();
    priceController.clear();
    descController.clear();
    fullDescController.clear();
    manufacturingDateController.clear();
    // imageFile = null;

    // setState(() {});
  }

  pickImageFromGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) async {
      String convertimg = utils.base64String(await imgFile!.readAsBytes());
      imgStrings.add(convertimg);
      if (mounted) setState(() {});
    });
  }

  Widget _buildListViewImage() {
    return Expanded(
      child: Container(
        width: 130,
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imgStrings.length,
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                child: utils.imageFromBase64String(imgStrings[index]),
              ),
            );
          },
        ),
      ),
    );
  }

  Uint8List decodeImageFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  @override
  void initState() {
    nameController.text = widget.productList?.productName ?? "";
    priceController.text = widget.productList?.productPrice ?? "";
    descController.text = widget.productList?.productDesc ?? "";
    fullDescController.text = widget.productList?.productFullDesc ?? "";
    manufacturingDateController.text =
        widget.productList?.manufacturingDate ?? "";
    // refreshImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ProductClass productClass = Provider(create: create)

    return Scaffold(
      appBar: customAppBar(
        title: Text('added product'),
        icon: Icons.arrow_forward_ios,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildAddImageButton(),
              // _buildListViewImage(),
              SizedBox(height: 10),
              _buildName(),
              SizedBox(height: 10),
              _buildPrice(),
              SizedBox(height: 10),
              _buildDesc(),
              SizedBox(height: 10),
              _buildFullDesc(),
              SizedBox(height: 10),
              _buildmanufacturingDate(),
              SizedBox(height: 20),
              _buildAddDetailButton(),
              // gridView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return customTextFormField(
        controller: nameController,
        // controller: provider.nameController,
        hintText: "Product Name",
        keyboardType: TextInputType.text);
  }

  Widget _buildPrice() {
    return customTextFormField(
        controller: priceController,
        // controller: provider.priceController,
        hintText: "Product Price",
        keyboardType: TextInputType.text);
  }

  Widget _buildDesc() {
    return customTextFormField(
        controller: descController,
        // controller: provider.descController,
        hintText: "Short Desc",
        keyboardType: TextInputType.text);
  }

  Widget _buildFullDesc() {
    return customTextFormField(
        controller: fullDescController,
        // controller: provider.fullDescController,
        hintText: "Full Desc",
        keyboardType: TextInputType.text);
  }

  Widget _buildmanufacturingDate() {
    return customTextFormField(
      controller: manufacturingDateController,
      // controller: provider.manufacturingDateController,
      hintText: "YY | MM | DD",
      keyboardType: TextInputType.datetime,
      label: Text('Manufacturing Date'),
      prefixIcon: Icon(Icons.calendar_month),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1990),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          String formatedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          DateTime formate = DateTime.parse(formatedDate);
          setState(() {
            manufacturingDateController.text = formatedDate;
            selectedDate = formate;
          });
        } else {
          throw Exception('Failed to load data from ');
        }
      },
    );
  }

  Widget _buildAddDetailButton() {
    return customButton(
        onTap: () async {
          await createProduct();
        },
        title: widget.isloading ? 'Update Details' : 'Save Details');
  }

  //     Center(
  //       child: customButton(
  //           onTap: () async {
  //             createProduct();
  //           },
  //           title: 'Save Details'));
  // }

  _buildAddImageButton() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (imgStrings.length < 4) {
              pickImageFromGallery();
            } else {
              utils().toastMeassage("Maximum length is 4");
            }
          },
          child: Card(
            child: Container(
              height: 100,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        _buildListViewImage(),
      ],
    );
  }
}
