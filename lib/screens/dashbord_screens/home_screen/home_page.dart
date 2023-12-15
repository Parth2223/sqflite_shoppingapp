import 'package:flutter/material.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/user_model.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/home_screen/search_screen.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/home_screen/business_list_item.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sqlfliteshop/widget/icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  UserHelper dbhelper = UserHelper();
  List<UserModel?> userList = [];

  int _cartBadgeAmount = 0;
  late bool _showCartBadge;
  Color color = Colors.black;

  @override
  void initState() {
    getBusinessNameData();
    super.initState();
  }

  Future<void> getBusinessNameData() async {
    userList = await dbhelper.getAllUserData();
    if (mounted) setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: userList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => BusinessListItem(
            userModel: userList[index],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return customAppBar(
      automaticallyImplyLeading: false,
      title: _buildSearchContainer(),
      actions: [
        _shoppingCartBadge(),
      ],
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
        // controller: searchController,
        // readOnly: true,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
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
    return customIcon(icon: Icons.search, onTap: () {});
  }

  Widget _addRemoveCartButtons() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton.icon(
              onPressed: () => setState(() {
                    _cartBadgeAmount++;
                    if (color == Colors.blue) {
                      color = Colors.red;
                    }
                  }),
              icon: Icon(Icons.add),
              label: Text('Add to cart')),
          ElevatedButton.icon(
              onPressed: _showCartBadge
                  ? () => setState(() {
                        _cartBadgeAmount--;
                        color = Colors.blue;
                      })
                  : null,
              icon: Icon(Icons.remove),
              label: Text('Remove from cart')),
        ],
      ),
    );
  }
}
