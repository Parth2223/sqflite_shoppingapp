import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/user_model.dart';
import 'package:sqlfliteshop/screens/Authenitcation_screen/login_screen.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/setting_screen/addres_screen/show_address.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/setting_screen/edite_profile.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/setting_screen/product_screens/show_product_list.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';
import 'package:sqlfliteshop/widget/ctm_list_tile_btn.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  File? imageFile;
  Color? color;
  UserModel? profilelist;
  int? id;
  _getFromGallery(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: source,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('userId');
    profilelist = await UserHelper().getDataById(id ?? 0);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageProfile(context),
            _buildSizeHeight10(),
            _buildUserName(),
            _buildSizeHeight10(),
            Container(
              height: 550,
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: yellow300,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12))),
              child: _buildSettingList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageProfile(context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
              backgroundImage: imageFile == null
                  ? AssetImage('assets/images/person_icon.png') as ImageProvider
                  : FileImage(
                      File(imageFile!.path),
                    )),
        ),
        Positioned(
            bottom: 0,
            right: 5,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => _buildBottomSheet(context),
                  );
                  print("on Tapped");
                },
                child: Icon(
                  Icons.camera_alt,
                  color: bottomcolor,
                  size: 23.0,
                ),
              ),
            ))
      ],
    );
  }

  Widget _buildBottomSheet(context) {
    return Container(
      height: 140.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        Text(
          "Choose Profile Photo",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    _getFromGallery(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.camera),
                ),
                Text("Camera"),
              ],
            ),
            SizedBox(width: 80),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    _getFromGallery(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.image),
                ),
                Text("Gallery"),
              ],
            ),
          ],
        )
      ]),
    );
  }

  Widget _buildUserName() {
    return Text(
      " ${profilelist?.firstname?.toUpperCase() ?? ""} ${profilelist?.lastname?.toUpperCase() ?? ""}",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _buildSettingList() {
    return Column(
      children: [
        _buildChangePassword(),
        _buildSizeHeight5(),
        profilelist?.selectUser == "Business A.C"
            ? _buildBusinessAccount()
            : _buildDeliveryAddress(),
        _buildSizeHeight5(),
        // _buildBusinessAccount(),
        // _buildSizeHeight5(),
        _buildPayment(),
        _buildSizeHeight5(),
        _buildOrderHistory(),
        _buildSizeHeight5(),
        _buildFavoriteCart(),
        _buildSizeHeight5(),
        _buildTermsCondition(),
        _buildSizeHeight5(),
        _buildHelp(),
        _buildSizeHeight5(),
        _buildLogout(),
      ],
    );
  }

  Widget _buildChangePassword() {
    return ListTileButton(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfile(),
            ));
      },
      leading: Icon(Icons.lock),
      title: 'Change Profile',
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildPayment() {
    return ListTileButton(
      onTap: () {},
      leading: Icon(Icons.payment),
      title: 'Payment',
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildOrderHistory() {
    return ListTileButton(
      onTap: () {},
      leading: Icon(Icons.access_time_rounded),
      title: 'Order History',
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildFavoriteCart() {
    return ListTileButton(
      onTap: () {},
      leading: Icon(Icons.favorite),
      title: 'Favorite Cart',
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildDeliveryAddress() {
    return ListTileButton(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowAddressScreen(),
            ));

        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => AddAddressScreen()));
      },
      leading: Icon(Icons.location_on),
      title: ' Delivery Address',
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildBusinessAccount() {
    return ListTileButton(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewShowProduct(),
            ));
        // Get.to(() => NewShowProduct());
      },
      leading: Icon(Icons.storefront_sharp),
      title: 'Business Account',
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildTermsCondition() {
    return ListTileButton(
      onTap: () {},
      leading: Icon(Icons.article_rounded),
      title: 'Terms & Condition',
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildHelp() {
    return ListTileButton(
      onTap: () {},
      leading: Icon(Icons.message_rounded),
      title: 'Help',
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildLogout() {
    return ListTileButton(
      onTap: () {
        showAlertDialog(context);
      },
      leading: Icon(Icons.logout),
      title: 'Logout',
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildSizeHeight5() {
    return SizedBox(
      height: 5,
    );
  }

  Widget _buildSizeHeight10() {
    return SizedBox(
      height: 10,
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel", style: headlineNormal),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget LogoutButton = ElevatedButton(
      child: Text(
        "Logout",
        style: TextStyle(color: white, fontSize: 15),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        // primary: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
          child: Text(
        "Logout",
        style: TextStyle(color: blackColor, fontWeight: FontWeight.w700),
      )),
      content: Text("Are you sure you want to logout?",
          style: TextStyle(color: blackColor, fontSize: 18)),
      actions: [
        cancelButton,
        LogoutButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
