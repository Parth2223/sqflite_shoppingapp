import 'dart:io';

class UserModel {
  int? userId;
  String? firstname;
  String? lastname;
  String? username;
  String? mobilenumber;
  String? emailaddress;
  String? password;
  String? gender;
  String? selectUser;
  String? businessNameSignup;
  String? birthdate;
  File? image;

  UserModel({
    this.userId,
    this.firstname,
    this.lastname,
    this.mobilenumber,
    this.username,
    this.emailaddress,
    this.password,
    this.gender,
    this.selectUser,
    this.businessNameSignup,
    this.birthdate,
    this.image,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "firstname": firstname,
      "lastname": lastname,
      "username": username,
      "mobilenumber": mobilenumber,
      "emailaddress": emailaddress,
      "password": password,
      "gender": gender,
      'selectUser': selectUser,
      'businessNameSignup': businessNameSignup,
      "birthdate": birthdate,
      "image": image,
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    userId = map['userId'];
    firstname = map['firstname'];
    lastname = map['lastname'];
    username = map['username'];
    mobilenumber = map['mobilenumber'];
    emailaddress = map['emailaddress'];
    password = map['password'];
    gender = map['gender'];
    selectUser = map['selectUser'];
    businessNameSignup = map['businessNameSignup'];
    birthdate = map['birthdate'];
    image = map['image'];
  }
}
