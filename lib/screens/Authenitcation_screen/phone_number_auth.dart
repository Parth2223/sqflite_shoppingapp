import 'package:flutter/material.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';
import 'package:sqlfliteshop/widget/all_ctm_textformfield.dart';
import 'package:sqlfliteshop/widget/custom_button.dart';

class PhoneNumberAuthentication extends StatefulWidget {
  const PhoneNumberAuthentication({super.key});

  @override
  State<PhoneNumberAuthentication> createState() =>
      _PhoneNumberAuthenticationState();
}

class _PhoneNumberAuthenticationState extends State<PhoneNumberAuthentication> {
  final phoneNumberController = TextEditingController();
  final otpController = TextEditingController();
  String? startingnumber = "+91";
  String? verificationId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            _buildGetStarted(),
            SizedBox(height: 20),
            _buildText2(),
            _buildText3(),
            SizedBox(height: 20),
            _buildEnterNumber(),
            // _buildotpEnter(),
            SizedBox(height: 20),
            _buildSendOtp(),
            SizedBox(height: 10),
            _buildDividerLine(),
            _buildContinueWithGoogle(),
            _buildContinueWithFacebook(),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStarted() {
    return Center(
      child: Text(
        "Get Started",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontFamily: 'oswald',
            fontSize: 25),
      ),
    );
  }

  Widget _buildEnterNumber() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: customTextFormField(
          controller: phoneNumberController,
          hintText: "Enter Your Number",
          prefixIcon: Icon(
            Icons.call,
            color: Colors.black,
          ),
          fillColor: Colors.grey.shade300,
          filled: true,
          keyboardType: TextInputType.phone),
    );
  }

  Widget _buildSendOtp() {
    return Center(
      child: customButton(
        // onTap: () {
        //   AuthHelper().auth.verifyPhoneNumber(
        //       phoneNumber: "+${startingnumber}${phoneNumberController.text}",
        //       verificationCompleted: (PhoneAuthCredential credential) async {
        //         await AuthHelper().auth.signInWithCredential(credential);
        //       },
        //       verificationFailed: (FirebaseAuthException e) {
        //         if (e.code == 'invalid-phone-number') {
        //           utils().toastMeassage(
        //               'The provided phone number is not valid.');
        //         }
        //       },
        //       codeSent: (String verificationId, int? resendToken) async {
        //         Get.to(() => verifyOtp());
        //       },
        //       codeAutoRetrievalTimeout: (String verificationId) {});
        // },
        title: "Send OTP", onTap: () {},
      ),
    );
  }

  Widget _buildDividerLine() {
    return Row(
      children: [
        Flexible(
            child: Divider(
          color: Colors.grey,
          height: 4,
          thickness: 1,
          indent: 20,
        )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "OR",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.normal),
          ),
        ),
        Flexible(
            child: Divider(
          color: Colors.grey,
          thickness: 1,
          height: 4,
          endIndent: 20,
        )),
      ],
    );
  }

  Widget _buildContinueWithGoogle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.4,
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        height: 50,
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Image.asset('assets/images/googleIcon.png'),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Continue With Google',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueWithFacebook() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.4,
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        height: 50,
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Image.asset('assets/images/facebook.png'),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Continue With Facebook',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          ),
        ),
      ),
    );
  }

  // _buildotpEnter() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 80),
  //     child: PinFieldAutoFill(
  //         currentCode: verificationId,
  //         controller: otpController,
  //         codeLength: 6,
  //         onCodeChanged: (code) {
  //           print("onCodeChange $code");
  //           setState(() {
  //             verificationId = code.toString();
  //           });
  //         },
  //         onCodeSubmitted: (val) {
  //           print("onCodeSubmitted $val");
  //           setState(() {
  //             verificationId = val.toString();
  //           });
  //         }),
  //   );
  // }

  _buildText2() {
    return Text(
      "Add your phone number.",
      style: headline3bold,
    );
  }

  _buildText3() {
    return Text(
      "we'll send you a verification code",
      style: headline3bold,
    );
  }
}
