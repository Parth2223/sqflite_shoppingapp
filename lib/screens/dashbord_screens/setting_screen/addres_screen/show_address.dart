import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/address_model.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/setting_screen/addres_screen/add_address.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';
import 'package:sqlfliteshop/widget/utils.dart';

class ShowAddressScreen extends StatefulWidget {
  const ShowAddressScreen({super.key});

  @override
  State<ShowAddressScreen> createState() => _ShowAddressScreenState();
}

class _ShowAddressScreenState extends State<ShowAddressScreen> {
  final fullAddressController = TextEditingController();
  final searchController = TextEditingController();
  UserHelper dbHelper = UserHelper();

  List<AddressModel>? addressData = [];
  int? id;
  int? userID;
  bool isloading = true;
  //
  Future<void> getAddressData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getInt('userId');

    String search = searchController.text.trim();
    addressData = await dbHelper.getAddressItem(userID!, searchedText: search);
    if (mounted) {
      isloading = true;
    }
    setState(() {});
  }

  void deleteItem(index) async {
    await dbHelper.addressDelete(addressData?[index].addressId ?? 0);
    print("Successfully deleted!");
    utils().toastMeassage("Successfully deleted!");
    getAddressData();
    setState(() {});
  }

  @override
  void initState() {
    getAddressData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildYourAddresses(),
              _buildAddNewAddress(),
              SizedBox(height: 10),
              _buildListViewBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return customAppBar(
        automaticallyImplyLeading: false, title: _buildSearchContainer());
  }

  Widget _buildSearchContainer() {
    return Container(
      width: double.infinity,
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
          setState(() {
            if (searchController.text.trim().isNotEmpty) {
              getAddressData();
            }
          });
        },
        decoration: InputDecoration(
            prefixIcon: _buildSearchIcon(),
            // suffixIcon: _buildCancleIcon(),
            hintText: 'Search...',
            border: InputBorder.none),
      ),
    );
  }

  Widget _buildSearchIcon() {
    return Icon(Icons.search);
  }

  Widget _buildYourAddresses() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Your Addresses",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _buildAddNewAddress() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewAddresses(),
            )).then((value) {
          if (value == 'update') {
            getAddressData();
          }
        });
      },
      child: Card(
          color: Grey700,
          child: ListTile(
            leading: Text(
              "Add a new address",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
          )),
    );
  }

  Widget _buildListViewBuilder() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: addressData?.length,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          height: 150,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFlatHousenoBuilding(index),
              _buildAreaStreetSectorVillage(index),
              _buildTownAndCity(index),
              SizedBox(height: 20),
              _buildEditAndRemoveBTN(index),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black,
                width: 1,
              )),
        );
      },
    );
  }

  Widget _buildFlatHousenoBuilding(index) {
    return Text(
      '${addressData?[index].addressOne}',
      style: TextStyle(color: Colors.black, fontSize: 17),
    );
  }

  Widget _buildAreaStreetSectorVillage(index) {
    return Text(
      '${addressData?[index].addressArea}',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
    );
  }

  Widget _buildTownAndCity(index) {
    return Text(
      '${addressData?[index].townCity},${addressData?[index].state} ,${addressData?[index].pincode}',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17),
    );
  }

  Widget _buildEditAndRemoveBTN(index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildEditButton(index),
        SizedBox(width: 10),
        _buildRemoveButton(index),
      ],
    );
  }

  Widget _buildEditButton(index) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewAddresses(
                      isloading: true,
                      updatelist: addressData![index],
                      id: addressData?[index].addressId,
                    )));
        print("On tapped");
      },
      child: Text(
        "Edit",
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: white),
    );
  }

  Widget _buildRemoveButton(index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          deleteItem(index);
        });
        print("On tapped");
      },
      child: Text(
        "Remove",
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: white),
    );
  }
}
