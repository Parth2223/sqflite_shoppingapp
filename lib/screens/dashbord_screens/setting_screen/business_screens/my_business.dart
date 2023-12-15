import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/businss_model.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/setting_screen/business_screens/Business_profile.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/setting_screen/product_screens/show_product_list.dart';
import 'package:sqlfliteshop/widget/icon_button.dart';

class MyBusinessCard extends StatefulWidget {
  const MyBusinessCard({super.key});

  @override
  State<MyBusinessCard> createState() => _MyBusinessCardState();
}

class _MyBusinessCardState extends State<MyBusinessCard> {
  List<BusinessModel>? businessDataList = [];
  int? businessid;
  Future<void> getBusinessData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    businessid = pref.getInt('userId');
    businessDataList = await UserHelper().getAllBusinessDetails(businessid!);
    if (mounted) {}
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getBusinessData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 40,
      backgroundColor: Colors.white,
      color: Colors.grey,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await getBusinessData();
        if (mounted) setState(() {});
      },
      child: Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: yellow200,
      title: Text(
        "My Business",
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        ListView.builder(
          // scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: businessDataList?.length,
          itemBuilder: (context, index) => _buildCard(index),
        )
      ],
    );
  }

  _buildCard(index) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        child: Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: yellow200,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                offset: Offset(
                  2.0,
                  2.0,
                ),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${businessDataList?[index].businessName.toString()}",
                      style: headline2,
                    ),
                    customIcon(
                        icon: Icons.edit,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusinessProfile(
                                  businessDataList: businessDataList?[index],
                                  businessid:
                                      businessDataList?[index].businessId,
                                ),
                              ));
                          // Get.to(() => );
                        }),
                  ],
                ),
                Text(
                  "${businessDataList?[index].fandlname?.toUpperCase() ?? ""}",
                  style: headline3,
                ),
                Text(
                  "Contact Number:- ${businessDataList?[index].businessNumber.toString()}",
                  style: headline3bold,
                ),
                Text(
                  "Business Categories:- ${businessDataList?[index].industry.toString()}",
                  overflow: TextOverflow.ellipsis,
                  style: headline1bold,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewShowProduct(),
                              ));
                          // Get.to(() => NewShowProduct());
                        },
                        child: Text("Add Product")),
                    customIcon(
                        icon: Icons.delete,
                        onTap: () {
                          UserHelper().businessDelete(
                              businessDataList?[index].businessId ?? 0);
                          setState(() {});
                          print("deleted data");
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildFloatingActionButton() {
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessProfile(),
              ));
          // Get.to(() => BusinessProfile());
        },
        child: Icon(Icons.add));
  }
}
