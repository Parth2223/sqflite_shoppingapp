import 'package:flutter/material.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/product_model.dart';
import 'package:sqlfliteshop/models/user_model.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/home_screen/full_show_image.dart';

class BusinessListItem extends StatefulWidget {
  BusinessListItem({super.key, required this.userModel});

  final UserModel? userModel;

  @override
  State<BusinessListItem> createState() => _BusinessListItemState();
}

class _BusinessListItemState extends State<BusinessListItem> {
  final searchController = TextEditingController();
  UserHelper dbhelper = UserHelper();
  List<ProductModel>? productList = [];
  // int _cartBadgeAmount = 0;
  Color color = Colors.black;

  @override
  void initState() {
    getShowProducts();
    super.initState();
  }

  Future<void> getShowProducts() async {
    productList = await dbhelper.allUserProductShow(widget.userModel!);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buisnessNamebyOwner(),
        _buildProductListCard(),
      ],
    );
  }

  Widget _buisnessNamebyOwner() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '${widget.userModel?.businessNameSignup?.toUpperCase()}',
        style: headlineNormal,
      ),
    );
  }

  Widget _buildProductListCard() {
    return Container(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList?.length,
          itemBuilder: (context, index) {
            return _buildProductCard(index);
          }),
    );
  }

  Widget _buildProductImage(index) {
    Widget? image;
    if (productList?[index].memoryImages != null &&
        (productList?[index].memoryImages?.isNotEmpty ?? false)) {
      image = Image.memory(productList![index].memoryImages!.first);
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

  // Widget _buisnessNamebyOwner() {
  //   return Padding(
  //     padding: EdgeInsets.all(8.0),
  //     child: Text(
  //       '${widget.userModel?.businessNameSignup?.toUpperCase()}',
  //       style: headlineNormal,
  //     ),
  //   );
  // }

  Widget _buildProductCard(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductViewScreen(
              productList: productList![index],
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(index),
            // Divider(thickness: 10, color: Colors.red),
            Text(
              '${productList?[index].productName}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              '₹ ${productList?[index].productPrice}',
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
  }

  Widget _buildFavoriteItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("vdsvbs"),
        Icon(Icons.favorite, color: Colors.red),
        // customIcon(icon: Icons.favorite, color: Colors.red, onTap: () {}),
      ],
    );
  }
}
