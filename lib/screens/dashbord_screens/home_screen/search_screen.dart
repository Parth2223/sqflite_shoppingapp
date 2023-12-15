import 'package:flutter/material.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/product_model.dart';
import 'package:sqlfliteshop/models/user_model.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/home_screen/full_show_image.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel>? productSearch = [];
  List<UserModel?> userList = [];
  List<int> list = [];
  String? filterItem = "Product A-Z";
  UserModel? userModel;

  UserHelper dbhelper = UserHelper();

  @override
  void initState() {
    getBusinessNameData();
    getProductsearch();
    super.initState();
  }

  Future<void> getProductsearch() async {
    String? searchText = searchController.text;
    productSearch = await dbhelper.productSearch(
        searchText: searchText, filtter: filterItem);
    setState(() {});
  }

  Future<void> getBusinessNameData() async {
    userList = await dbhelper.getAllUserData();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _buildVerticleListview();
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return customAppBar(
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
    );
  }

  PopupMenuItem PopupMenuPosition(String title) {
    return PopupMenuItem(
        onTap: () {
          filterItem = title;
          getProductsearch();
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
            getProductsearch();
          } else {
            getProductsearch();
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

// ================================ AppBar End ======================================

  Widget _buildVerticleListview() {
    return ListView.builder(
      itemCount: userList.length,
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
        '${userList[index]?.businessNameSignup?.toUpperCase()}',
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
              itemCount: productSearch?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductViewScreen(
                          productList: productSearch![index],
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
                          '${productSearch?[index].productName}',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '₹ ${productSearch?[index].productPrice}',
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
    if (productSearch?[index].memoryImages != null &&
        (productSearch?[index].memoryImages?.isNotEmpty ?? false)) {
      image = Image.memory(productSearch![index].memoryImages!.first);
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
