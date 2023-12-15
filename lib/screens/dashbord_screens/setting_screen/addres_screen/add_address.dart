import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/address_model.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';
import 'package:sqlfliteshop/widget/custom_address_textfield.dart';
import 'package:sqlfliteshop/widget/custom_button.dart';
import 'package:sqlfliteshop/widget/icon_button.dart';

class NewAddresses extends StatefulWidget {
  NewAddresses({super.key, this.updatelist, this.isloading = false, this.id});

  final AddressModel? updatelist;
  final bool isloading;
  final int? id;

  @override
  State<NewAddresses> createState() => _NewAddressesState();
}

class _NewAddressesState extends State<NewAddresses> {
  int? userId;
  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final addressOneController = TextEditingController();
  final addressTwoController = TextEditingController();
  final pincodeController = TextEditingController();
  final towncityController = TextEditingController();

  @override
  void initState() {
    addressOneController.text = widget.updatelist?.addressOne ?? "";
    addressTwoController.text = widget.updatelist?.addressArea ?? "";
    pincodeController.text = widget.updatelist?.pincode ?? "";
    towncityController.text = widget.updatelist?.townCity ?? "";
    super.initState();
  }

  String SelectState = 'Gujarat';
  var items = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];
  final UserHelper dbHelper = UserHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildCanclebtn() {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "CANCLE",
          style: TextStyle(color: white),
        ));
  }

  Widget _buildFlatHousenoBuilding() {
    return Text(
      " Flat, House no., Building, Company, Apartment",
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
    );
  }

  Widget _buildAreaStreetSectorVillage() {
    return Text(
      " Area, Street, Sector, Village ",
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
    );
  }

  Widget _buildaddressone() {
    return customAddressTextField(
      controller: addressOneController,
    );
  }

  Widget buildSecoundAddress() {
    return customAddressTextField(
      controller: addressTwoController,
    );
  }

  Widget _buildPincodeText() {
    return Text(
      " Pincode",
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
    );
  }

  Widget _buildPincode() {
    return customAddressTextField(
      controller: pincodeController,
    );
  }

  Widget _buildTownAndCity() {
    return Text(
      " Town/City",
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
    );
  }

  Widget _buildTownCity() {
    return customAddressTextField(
      controller: towncityController,
    );
  }

  Widget _buildSaveAndUpdateButton() {
    return Center(
        child: customButton(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              userId = prefs.getInt('userId');
              AddressModel user = AddressModel(
                  addressUserId: userId,
                  addressOne: addressOneController.text.trim(),
                  addressArea: addressTwoController.text.trim(),
                  pincode: pincodeController.text.trim(),
                  townCity: towncityController.text.trim(),
                  state: SelectState);
              setState(() {
                widget.isloading
                    ? UserHelper()
                        .addressUpdate(user, widget.updatelist?.addressId ?? 0)
                    : UserHelper().addressinsert(user);
              });
              Navigator.pop(context, "update");
            },
            title: widget.isloading ? "Update Address" : "Add Address"));
  }

  PreferredSizeWidget _buildAppBar() {
    return customAppBar(
      automaticallyImplyLeading: false,
      icon: Icons.arrow_forward,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _buildFlatHousenoBuilding(),
            _buildaddressone(),
            SizedBox(height: 10),
            _buildAreaStreetSectorVillage(),
            buildSecoundAddress(),
            SizedBox(height: 10),
            _buildPincodeText(),
            _buildPincode(),
            SizedBox(height: 10),
            _buildTownAndCity(),
            _buildTownCity(),
            SizedBox(height: 10),
            _buildSelectState(),
            _buildState(),
            SizedBox(height: 20),
            _buildSaveAndUpdateButton(),
          ],
        ),
      ),
    );
  }

  _buildState() {
    return Form(
      child: Container(
        child: FormField<String>(
          builder: (FormFieldState<String> field) {
            return InputDecorator(
              decoration: InputDecoration(
                  hintText: "Select State",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: SelectState,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          Text(items),
                        ],
                      ),
                    );
                  }).toList(),
                  isDense: true,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      SelectState = newValue!;
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildSelectState() {
    return Text(
      "Select State",
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
    );
  }

  _buildFullName() {
    return customAddressTextField(
      controller: fullNameController,
      suffixIcon: customIcon(
          icon: Icons.cancel_outlined,
          // color: Colors.black,
          onTap: () {
            setState(() {
              fullNameController.clear();
            });
          }),
    );
  }

  _buildMobileNumberText() {
    return Text(
      "Mobile Number",
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
    );
  }
}
