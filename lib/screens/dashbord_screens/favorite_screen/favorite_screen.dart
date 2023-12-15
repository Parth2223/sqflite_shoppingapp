import 'package:flutter/material.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/product_model.dart';
import 'package:sqlfliteshop/models/user_model.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/home_screen/full_show_image.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel?> productSearch = [];
  List<UserModel>? userList = [];
  UserHelper dbhelper = UserHelper();
  String seletedfillter = "Product A-Z";

  Future<void> getSearchProduct() async {
    String? searchText = searchController.text.trim();
    productSearch = await dbhelper.productSearch(
        searchText: searchText, filtter: seletedfillter);
    if (mounted) setState(() {});
  }

  Future<void> getBusinessNameData() async {
    userList = await dbhelper.getAllUserData();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getBusinessNameData();
    getSearchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: _buildSearchContainer(),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuPosition('Product A-Z'),
              PopupMenuPosition('Product Z-A'),
              PopupMenuPosition('Product High-Low'),
              PopupMenuPosition('Product Low-High'),
            ],
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  PopupMenuItem PopupMenuPosition(String title) {
    return PopupMenuItem(
        onTap: () {
          seletedfillter = title;
          getSearchProduct();
          setState(() {});
        },
        child: Text(title));
  }

  Widget _buildSearchContainer() {
    return Container(
      width: 335,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: _buildSearchTextField(),
    );
  }

  Widget _buildSearchTextField() {
    return Center(
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          if (searchController.text.trim().isNotEmpty) {
            getSearchProduct();
          } else {
            getSearchProduct();
          }
        },
        decoration: InputDecoration(
          prefixIcon: _buildSearchIcon(),
          // suffixIcon: _buildCancleIcon(),
          hintText: 'Search...',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSearchIcon() {
    return Icon(Icons.search);
  }

  Widget _buildBody() {
    return Listviewcard();
  }

  Widget _buildVerticleListview() {
    return ListView.builder(
      itemCount: userList?.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buisnessNamebyOwner(index),
            Listviewcard(),
            // _buildProductListCard(),
          ],
        );
      },
    );
  }

  Widget _buisnessNamebyOwner(index) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '${userList?[index].businessNameSignup?.toUpperCase()}',
        style: headlineNormal,
      ),
    );
  }

  Widget Listviewcard() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productSearch.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductViewScreen(
                          productList: productSearch[index],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProductImage(index),
                        Divider(thickness: 1, color: Colors.red),
                        Text(
                          '${productSearch[index]?.productName}',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '₹ ${productSearch[index]?.productPrice}',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Free delivery',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }

  Widget _buildProductImage(index) {
    Widget? image;
    if (productSearch[index]?.memoryImages != null &&
        (productSearch[index]?.memoryImages?.isNotEmpty ?? false)) {
      image = Image.memory(productSearch[index]!.memoryImages!.first);
    } else {
      image = Image.asset('assets/images/fruit_basket.png');
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        height: 90,
        width: 100,
        child: image,
      ),
    );
  }
}
