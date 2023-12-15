import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/screens/Authenitcation_screen/signin_screen.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/bottom_pages.dart';
import 'package:sqlfliteshop/widget/bezierContainer.dart';
import 'package:sqlfliteshop/widget/custom_button.dart';
import 'package:sqlfliteshop/widget/custom_text_fields.dart';
import 'package:sqlfliteshop/widget/icon_button.dart';
import 'package:sqlfliteshop/widget/utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final UserHelper dbHelper = UserHelper();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    String? login = loginController.text.trim();
    String? password = passwordController.text.trim();
    if (formKey.currentState!.validate()) {
      final user = await dbHelper.getUserLogin(login, password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', user?.userId ?? 0);
      prefs.setString('selectedBusiness', user?.selectUser ?? "");
      if (user != null && user.selectUser == 'Business A.C' ||
          user?.selectUser == 'Customer A.C') {
        print("already use Business Login");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomScreen(),
            ));
      } else {
        utils().toastMeassage("Please valid username and password");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
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
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Text('Forgot Password ?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500))),
                  _divider(),
                  _facebookButton(),
                  SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _submitButton() {
    return customButton(
      title: "Login",
      onTap: () {
        if (formKey.currentState!.validate()) {
          login();
          print("on tapped");
        }
      },
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignupScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
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

  Widget _emailPasswordWidget() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          customTextFields(
            controller: loginController,
            title: "Email id OR user name ",
            suffixIcon: Icon(Icons.email_outlined),
            validator: (val) {
              if (val!.length < 5) {
                return 'Please enter your email id';
              } else {
                return null;
              }
            },
          ),
          customTextFields(
            controller: passwordController,
            title: 'Password',
            suffixIcon: customIcon(icon: Icons.remove_red_eye, onTap: () {}),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Please Enter UserName\ Email Id';
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
