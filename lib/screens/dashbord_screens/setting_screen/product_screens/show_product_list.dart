import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/product_model.dart';
import 'package:sqlfliteshop/screens/Authenitcation_screen/login_screen.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/setting_screen/business_screens/Business_profile.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/setting_screen/product_screens/addd_product.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/home_screen/full_show_image.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';
import 'package:sqlfliteshop/widget/icon_button.dart';
import 'package:sqlfliteshop/widget/utils.dart';

class NewShowProduct extends StatefulWidget {
  const NewShowProduct({super.key});

  @override
  State<NewShowProduct> createState() => _NewShowProductState();
}

class _NewShowProductState extends State<NewShowProduct> {
  List<ProductModel>? productList = [];
  final UserHelper dbHelper = UserHelper();
  int? userID;
  bool isloading = true;

  Future<void> getProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getInt('userId');
    productList = await dbHelper.getProductData(userID ?? 0);
    if (mounted) {
      isloading = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    setState(() {
      getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return customAppBar(
        title: Text(
          "Show All Product",
          style: appBarStyle,
        ),
        icon: Icons.exit_to_app,
        automaticallyImplyLeading: true,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        });
  }

  Widget _buildDrawer() {
    return Drawer(
        width: 250,
        child: Column(
          children: [
            _buildLogo(),
            SizedBox(height: 30),
            // _buildMyAccount(),
          ],
        ));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: productList?.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductViewScreen(
                          productList: productList![index],
                        ),
                      ));
                },
                child: Card(
                  child: _buildContainer(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProduct(),
              )).then((value) async {
            if (value == 'update') {
              await getProducts();
            }
          });
          // Get.to(() => AddProduct())?.then((value) async {
          //   if (value == 'update') {
          //     await getProducts();
          //   }
          // });
          // print("Add Product Screens");
        },
        child: Icon(Icons.add));
  }

  Widget _buildEditButton(index) {
    return customIcon(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduct(
                isloading: true,
                productList: productList![index],
              ),
            ));
        // Get.to(() =>);
      },
      icon: Icons.edit,
      // color: Colors.grey.shade900,
    );
  }

  void deleteItem(index) async {
    await dbHelper.productDelete(productList?[index].ProductId ?? 0);
    print("Deleted Product ${productList?[index].ProductId}");
    print("Successfully deleted!");
    utils().toastMeassage("Successfully deleted!");
    getProducts();

    setState(() {});
  }

  Widget _buildDeleteButton(index) {
    return customIcon(
      onTap: () {
        deleteItem(index);
      },
      icon: Icons.delete_forever,
      // color: Colors.red,
    );
  }

  _buildProductImage(index) {
    Widget? image;
    if (productList?[index].memoryImages != null &&
        (productList?[index].memoryImages?.isNotEmpty ?? false)) {
      image = Image.memory(productList![index].memoryImages!.first);
    } else {
      image = Image.asset('assets/images/fruit_basket.png');
    }

    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        height: double.infinity,
        width: 60,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: image,
        ));
  }

  _buildProductTitle(index) {
    return Text("${productList?[index].productName}");
  }

  _buildSubTitle(index) {
    return Text("${productList?[index].productPrice}.00");
  }

  _buildButton(index) {
    return Column(
      children: [
        _buildEditButton(index),
        SizedBox(height: 7),
        _buildDeleteButton(index),
      ],
    );
  }

  Widget _buildMyAccount() {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessProfile(),
            ));
      },
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: brown800,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Business Details",
        style: TextStyle(color: Colors.black87, fontSize: 18),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            _buildLogoContainer(),
            SizedBox(height: 5),
            _buildName(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: 100,
        child: Image.asset("assets/images/fruit_basket.png"),
      ),
    );
  }

  Widget _buildName() {
    return Text(
      "Vagetable",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
    );
  }

  _buildContainer(index) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
          leading: _buildProductImage(index),
          title: _buildProductTitle(index),
          subtitle: _buildSubTitle(index),
          trailing: _buildButton(index)),
    );
  }
}
