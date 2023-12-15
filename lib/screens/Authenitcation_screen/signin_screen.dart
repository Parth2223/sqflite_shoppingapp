import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/user_model.dart';
import 'package:sqlfliteshop/screens/Authenitcation_screen/login_screen.dart';
import 'package:sqlfliteshop/widget/bezierContainer.dart';
import 'package:sqlfliteshop/widget/custom_button.dart';
import 'package:sqlfliteshop/widget/custom_text_fields.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final birthdateController = TextEditingController();
  final businessNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? gender;
  String? selectUser;
  DateTime selectDate = DateTime.now();
  UserHelper dbHelper = UserHelper();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(height: 50),
                    _buildAllFieldsWidget(),
                    SizedBox(height: 20),
                    _submitButton(),
                    SizedBox(height: height * .10),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllFieldsWidget() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          _buildFirstName(),
          _buildLastName(),
          _buildUserName(),
          _buildMobileNumber(),
          _buildEmailId(),
          _buildPassword(),
          _buildGender(),
          _buildSelectUser(),
          selectUser == "Business A.C" ? _buildBusinessName() : Container(),
          _buildBirthdayDate(),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return customButton(
      title: 'Register Now',
      onTap: () {
        if (formKey.currentState!.validate()) {
          UserModel user = UserModel(
              firstname: firstNameController.text,
              lastname: lastNameController.text,
              username: usernameController.text,
              mobilenumber: numberController.text,
              emailaddress: emailController.text,
              password: passwordController.text,
              gender: gender,
              selectUser: selectUser,
              businessNameSignup: businessNameController.text,
              birthdate: birthdateController.text);
          dbHelper.userinsert(user);
          print("User Sign IN");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        }
      },
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'shop',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'app',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Bar',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  _buildSelectUser() {
    return Row(
      children: [
        Text(
          "Select User",
          style: TextStyle(
              fontSize: 18, color: Grey900, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 3,
        ),
        Radio(
            value: 'Business A.C',
            groupValue: selectUser,
            onChanged: (value) {
              selectUser = value.toString();
              setState(() {});
            }),
        Text("Business A.C"),
        Radio(
            value: "Customer A.C",
            groupValue: selectUser,
            onChanged: (val) {
              selectUser = val.toString();
              setState(() {});
            }),
        Text("Customer A.C"),
      ],
    );
  }

  _buildBusinessName() {
    return customTextFields(
      controller: businessNameController,
      // hintText: "Business Name",
      prefixIcon: Icon(Icons.business),
      keyboardType: TextInputType.text,
      title: 'Business Name',
    );
  }

  Widget _buildFirstName() {
    return customTextFields(
      controller: firstNameController,
      title: 'First Name',
      suffixIcon: Icon(Icons.person),
      validator: (val) {
        if (val!.length < 2) {
          return 'Name must be more than 3 charter';
        }
        return null;
      },
    );
  }

  Widget _buildLastName() {
    return customTextFields(
      controller: lastNameController,
      title: "Last Name",
      suffixIcon: Icon(Icons.person),
    );
  }

  Widget _buildUserName() {
    return customTextFields(
      controller: usernameController,
      title: "User Name",
      suffixIcon: Icon(Icons.person),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Please Enter UserName';
        }
        return null;
      },
    );
  }

  Widget _buildMobileNumber() {
    return customTextFields(
      controller: numberController,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      title: "Mobile Number",
      suffixIcon: Icon(Icons.phone),
      validator: (val) {
        if (val!.length != 10) {
          return 'Mobile Number must be of 10 digit';
        }
        return null;
      },
    );
  }

  Widget _buildEmailId() {
    return customTextFields(
      controller: emailController,
      title: 'Email id',
      suffixIcon: Icon(Icons.email_outlined),
      validator: (value) {
        if (value!.isEmpty ||
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
          return 'Enter a valid email !';
        }
        return null;
      },
    );
  }

  Widget _buildPassword() {
    return customTextFields(
      controller: passwordController,
      title: 'Password',
      suffixIcon: Icon(Icons.remove_red_eye),
      validator: (val) {
        if (val!.length < 7) {
          return ' Password must be of 8 digit';
        }
        return null;
      },
    );
  }

  Widget _buildBirthdayDate() {
    return customTextFields(
      controller: birthdateController,
      title: "Selected Birthday Date",
      hintText: "yyyy-MM-dd",
      readOnly: true,
      prefixIcon: Icon(Icons.calendar_month),
      keyboardType: TextInputType.datetime,
      onTap: () async {
        DateTime? PickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
        );
        if (PickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(PickedDate);
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

  _buildGender() {
    return Row(
      children: [
        Text(
          "Gender",
          style: TextStyle(
              fontSize: 18, color: Grey900, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 3,
        ),
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
}
