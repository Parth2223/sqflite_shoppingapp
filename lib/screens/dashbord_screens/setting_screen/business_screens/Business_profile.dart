import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';
import 'package:sqlfliteshop/comman/all_string.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/businss_model.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/setting_screen/business_screens/my_business.dart';
import 'package:sqlfliteshop/widget/all_ctm_textformfield.dart';

class BusinessProfile extends StatefulWidget {
  final BusinessModel? businessDataList;
  final int? businessid;
  BusinessProfile({super.key, this.businessDataList, this.businessid});

  @override
  State<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  @override
  void initState() {
    firstAndLastNameController.text = widget.businessDataList?.fandlname ?? "";
    businessNumberController.text =
        widget.businessDataList?.businessNumber ?? "";
    businessPanNumberController.text =
        widget.businessDataList?.businessPan ?? "";
    businessNameController.text = widget.businessDataList?.businessName ?? "";
    super.initState();
  }

  final firstAndLastNameController = TextEditingController();
  final businessNumberController = TextEditingController();
  final businessPanNumberController = TextEditingController();
  final businessNameController = TextEditingController();
  bool isUpadate = true;

  String dropdownvalue = 'Manufacturing';
  var items = [
    'Manufacturing',
    'Automotive',
    'Business & Services',
    'Construction',
    'Education',
    'Financial & Services',
    'Government',
    'Healthcare',
    'Lab & Scientific',
    'Media & Entertainment',
    ' Restaurant & Food Services',
    'Retail',
    'Technology',
    'Wholesale',
    'other',
  ];

  Future<void> CreateBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    prefs.setString(
        'SelectedCategories', widget.businessDataList?.industry ?? "");
    BusinessModel user = BusinessModel(
      businessUserId: userId,
      fandlname: firstAndLastNameController.text,
      businessNumber: businessNumberController.text,
      industry: dropdownvalue.toString(),
      businessPan: businessPanNumberController.text,
      businessName: businessNameController.text,
    );
    isUpadate
        ? UserHelper().businessInsert(user)
        : UserHelper()
            .businessUpdateData(user, widget.businessDataList?.businessId ?? 0);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyBusinessCard(),
        ));
    // Get.to(() =>);
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
              _buildSizeBox10(),
              _buildHeadline1(),
              _buildHeadline2(),
              _buildDivider(),
              _buildSizeBox10(),
              _buildContactInformation(),
              _buildSizeBox10(),
              _buildFirstAndLastName(),
              _buildSizeBox8(),
              _buildfirstAndLastNameController(),
              _buildSizeBox10(),
              _buildBusinessPhone(),
              _buildSizeBox8(),
              _buildbusinessNumberController(),
              _buildSizeBox8(),
              _buildSizeBox10(),
              _buildDivider(),
              _buildBusinessInformation(),
              _buildSizeBox10(),
              _buildIndustry(),
              _buildSizeBox8(),
              _buildDropDownList(),
              _buildSizeBox10(),
              _buildBusinessPan(),
              _buildSizeBox8(),
              _buildbusinessPanNumberController(),
              _buildSizeBox10(),
              _buildBusinessName(),
              _buildSizeBox8(),
              _buildBusinessNameController(),
              _buildSizeBox10(),
              _buildDivider(),
              _buildBusinessAddresses(),
              _buildSizeBox10(),
              _buildHaveMultipleLocation(),
              _buildSizeBox10(),
              _buildOldAddress(),
              _buildSizeBox8(),
              _buildAddNewAddress(),
              _buildSizeBox10(),
              _buildCreateBussinessAccountButton(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildSizeBox10() {
    return SizedBox(height: 10);
  }

  Widget _buildHeadline1() {
    return Text(
      EnterYourBusinessDetails,
      style: headline1,
    );
  }

  Widget _buildHeadline2() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        TellUsAboutYou,
        style: headline3,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      thickness: 1,
      color: Grey900,
    );
  }

  Widget _buildContactInformation() {
    return Text(
      ContactInformation,
      style: headline2,
    );
  }

  Widget _buildFirstAndLastName() {
    return Text(
      FirstAndLastName,
      style: headline3,
    );
  }

  Widget _buildSizeBox8() {
    return SizedBox(height: 8);
  }

  Widget _buildfirstAndLastNameController() {
    return customTextFormField(
      controller: firstAndLastNameController,
      hintText: '',
      fillColor: Colors.grey.shade300,
      filled: false,
      contentPadding: EdgeInsets.all(8),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildBusinessPhone() {
    return Text(
      BusinessPhone,
      style: headline3,
    );
  }

  Widget _buildbusinessNumberController() {
    return customTextFormField(
      controller: businessNumberController,
      hintText: '',
      fillColor: Colors.grey.shade300,
      filled: false,
      contentPadding: EdgeInsets.all(8),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildBusinessInformation() {
    return Text(
      BusinessInformation,
      style: headline2,
    );
  }

  Widget _buildIndustry() {
    return Text(
      Industry,
      style: headline3,
    );
  }

  _buildbusinessPanNumberController() {
    return customTextFormField(
      controller: businessPanNumberController,
      hintText: '',
      fillColor: Colors.grey.shade300,
      filled: false,
      contentPadding: EdgeInsets.all(8),
      keyboardType: TextInputType.text,
    );
  }

  _buildDropDownList() {
    return Form(
      child: Container(
        child: FormField<String>(
          builder: (FormFieldState<String> field) {
            return InputDecorator(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: dropdownvalue,
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
                      dropdownvalue = newValue!;
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

  _buildBusinessPan() {
    return Text(
      BusinessPan,
      style: headline3,
    );
  }

  _buildBusinessName() {
    return Text(
      BusinessName,
      style: headline3,
    );
  }

  _buildBusinessNameController() {
    return customTextFormField(
      controller: businessNameController,
      hintText: '',
      fillColor: Colors.grey.shade300,
      filled: false,
      contentPadding: EdgeInsets.all(8),
      keyboardType: TextInputType.text,
    );
  }

  _buildBusinessAddresses() {
    return Text(
      BusinessAddresses,
      style: headline2,
    );
  }

  _buildHaveMultipleLocation() {
    return Text(
      HaveMultipleLocation,
      style: headline3,
    );
  }

  _buildOldAddress() {
    return Container(
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black,
            width: 1,
          )),
    );
  }

  _buildAddNewAddress() {
    return Center(
        child: InkWell(
      onTap: () {},
      child: Text(
        AddANewAddress,
        style: TextStyle(
            color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ));
  }

  _buildCreateBussinessAccountButton() {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: () {
          CreateBusiness();
        },
        child: Text(
          isUpadate ? CreateBusinessAccount : UpdateBusinessAccount,
          style: TextStyle(fontSize: 18),
        ),
      ),
    ));
  }
}
//
