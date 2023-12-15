import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';
import 'package:sqlfliteshop/comman/all_list.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/user_model.dart';
import 'package:sqlfliteshop/widget/all_ctm_textformfield.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';
import 'package:sqlfliteshop/widget/custom_button.dart';
import 'package:sqlfliteshop/widget/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final birthdateController = TextEditingController();

  String? gender;
  DateTime selectDate = DateTime.now();
  File? imageFile;
  UserModel? profilelist;
  int? id;
  UserHelper dbHelper = UserHelper();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('userId');
    profilelist = await dbHelper.getDataById(id ?? 0);
    firstNameController.text = profilelist?.firstname ?? "";
    lastNameController.text = profilelist?.lastname ?? "";
    usernameController.text = profilelist?.username ?? "";
    numberController.text = profilelist?.mobilenumber ?? "";
    emailController.text = profilelist?.emailaddress ?? "";
    passwordController.text = profilelist?.password ?? "";
    gender = profilelist?.gender ?? "";
    birthdateController.text = profilelist?.birthdate ?? "";
    setState(() {});
  }

  Future<void> _getFromGallery(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: source,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> editandupdate() async {
    UserModel user = UserModel(
        firstname: firstNameController.text.trim(),
        lastname: lastNameController.text.trim(),
        username: usernameController.text.trim(),
        mobilenumber: numberController.text.trim(),
        emailaddress: emailController.text.trim(),
        password: passwordController.text.trim(),
        gender: gender,
        birthdate: birthdateController.text.trim());
    UserHelper().userupdate(user, ListData().profileListData?.userId ?? 0);
    utils().toastMeassage("Update Your Profile");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "Profile Edit",
            style: appBarStyle,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildFirstName(),
              SizedBox(height: 10),
              _buildLastName(),
              SizedBox(height: 10),
              _buildUserName(),
              SizedBox(height: 10),
              _buildMobileNumber(),
              SizedBox(height: 10),
              _buildEmailAddress(),
              SizedBox(height: 10),
              _buildPassword(),
              SizedBox(height: 10),
              _buildMaleAndFemale(),
              SizedBox(height: 10),
              _buildBirthdayDate(),
              SizedBox(height: 20),
              _buildUpdateButton(),
            ],
          ),
        ),
      ),
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

  Widget _buildImageChange() {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CircleAvatar(
                radius: 50,
                backgroundImage: imageFile == null
                    ? AssetImage('assets/images/person_icon.png')
                        as ImageProvider
                    : FileImage(File(imageFile!.path))),
          ),
          Positioned(
              bottom: 10,
              right: 4,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: white,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _buildBottomSheet(context),
                    );
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: myHexColor,
                    size: 20.0,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildFirstName() {
    return customTextFormField(
      controller: firstNameController,
      hintText: 'Enter First Name',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.person),
    );
  }

  Widget _buildLastName() {
    return customTextFormField(
      controller: lastNameController,
      hintText: 'Enter Last Name',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.person),
    );
  }

  Widget _buildUserName() {
    return customTextFormField(
      controller: usernameController,
      hintText: 'Enter User Name',
      keyboardType: TextInputType.text,
      prefixIcon: Icon(Icons.person),
    );
  }

  Widget _buildMobileNumber() {
    return customTextFormField(
      controller: numberController,
      hintText: 'Enter Mobile Number',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.phone),
    );
  }

  Widget _buildEmailAddress() {
    return customTextFormField(
      controller: emailController,
      hintText: 'Enter Email Address',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.email),
    );
  }

  Widget _buildPassword() {
    return customTextFormField(
      controller: passwordController,
      hintText: 'Enter Password',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.password),
    );
  }

  Widget _buildMaleAndFemale() {
    return Row(
      children: [
        Radio(
            value: 'Male',
            groupValue: gender,
            onChanged: (value) {
              gender = value.toString();
              setState(() {});
            }),
        Text("Male"),
        Radio(
            value: "Female",
            groupValue: gender,
            onChanged: (val) {
              gender = val.toString();
              setState(() {});
            }),
        Text("Female"),
      ],
    );
  }

  Widget _buildBirthdayDate() {
    return customTextFormField(
      controller: birthdateController,
      hintText: "YY|MM|DD",
      keyboardType: TextInputType.datetime,
      prefixIcon: Icon(Icons.calendar_month),
      label: Text("BirthDay Date"),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          DateTime formate = DateTime.parse(formattedDate);

          setState(() {
            birthdateController.text = formattedDate;
            selectDate = formate;
          });
        } else {
          throw Exception('Failed to load data from ');
        }
      },
    );
  }

  Widget _buildUpdateButton() {
    return customButton(
        onTap: () {
          editandupdate();
        },
        title: "Update Profile");
  }
}
