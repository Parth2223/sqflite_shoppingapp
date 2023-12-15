import 'dart:typed_data';
import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sqlfliteshop/models/product_model.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';
import 'package:sqlfliteshop/widget/custom_button.dart';
import 'package:sqlfliteshop/widget/icon_button.dart';

class ProductViewScreen extends StatefulWidget {
  ProductViewScreen({super.key, this.productList});

  final ProductModel? productList;

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  int _cartBadgeAmount = 3;
  // late bool _showCartBadge;
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        automaticallyImplyLeading: true,
        actions: [
          _shoppingCartBadge(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            _buildFavorite(),
            SizedBox(height: 100),
            _buildCarouselSlider(),
            Divider(thickness: 1.5),
            _buildNameAndPrice(),
            SizedBox(height: 10),
            _buildProductDetails(),
            SizedBox(height: 10),
            _buildFullDetailsView(),
            SizedBox(height: 15),
            _buildDateProduct(),
            SizedBox(height: 15),
            _buildAddToCartButton(),
            SizedBox(height: 15),
            _buildByNowButton(),
            SizedBox(height: 15),
            // _buildProductListCard(),
          ],
        ),
      ),
    );
  }

  Widget _shoppingCartBadge() {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      badgeAnimation: badges.BadgeAnimation.slide(),
      badgeStyle: badges.BadgeStyle(
        badgeColor: color,
      ),
      badgeContent: Text(
        _cartBadgeAmount.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
    );
  }

  List<Widget> _buildAllproductImage() {
    List<Widget> image = [];
    if (widget.productList?.memoryImages != null &&
        (widget.productList?.memoryImages?.isNotEmpty ?? false)) {
      for (Uint8List im in widget.productList!.memoryImages!) {
        image.add(Image.memory(im));
      }
    } else {
      image.add(Image.asset('assets/images/fruit_basket.png'));
    }

    return image;
  }

  _buildCarouselSlider() {
    return CarouselSlider(
      items: _buildAllproductImage(),

      //Slider Container properties
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }

  Widget _buildNameAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${widget.productList?.productName}",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
        ),
        Text(
          "₹ ${widget.productList?.productPrice}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ],
    );
  }

  _buildProductDetails() {
    return Row(
      children: [
        Text(
          "Product Details: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        Text(
          "${widget.productList?.productDesc} ",
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          softWrap: false,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
        ),
      ],
    );
  }

  _buildFullDetailsView() {
    return Row(
      children: [
        Text(
          "Full Details View: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Expanded(
          child: Text(
            "${widget.productList?.productFullDesc}",
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            softWrap: false,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
          ),
        ),
      ],
    );
  }

  _buildDateProduct() {
    return Row(
      children: [
        Text(
          "Manufacturing Date: ",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        Text(
          "${widget.productList?.manufacturingDate} ",
          style: TextStyle(fontSize: 17),
        ),
      ],
    );
  }

  _buildFavorite() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        customIcon(
          icon: Icons.favorite_border,
          onTap: () {},
          color: Colors.redAccent,
        ),
        customIcon(
          icon: Icons.share,
          onTap: () {},
          color: Colors.grey.shade900,
        )
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return customButton(
        title: 'Add To Cart',
        onTap: () => setState(() {
              _cartBadgeAmount++;
              if (color == Colors.blue) {
                color = Colors.red;
              }
            }));
  }

  Widget _buildByNowButton() {
    return customButton(title: 'By Now', onTap: () {});
  }
  //
  // _buildProductListCard() {
  //   return Container(
  //     height: 150,
  //     width: 100,
  //     child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: widget.productList,
  //         itemBuilder: (context, index) {
  //           return _buildProductCard(index);
  //         }),
  //   );
  // }

  Widget _buildProductCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductViewScreen(
              productList: widget.productList,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            // Divider(thickness: 10, color: Colors.red),
            Text(
              '${widget.productList?.productName}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              '₹ ${widget.productList?.productPrice}',
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

  _buildProductImage() {
    Widget? image;
    if (widget.productList?.memoryImages != null &&
        (widget.productList?.memoryImages?.isNotEmpty ?? false)) {
      image = Image.memory(widget.productList!.memoryImages!.first);
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
