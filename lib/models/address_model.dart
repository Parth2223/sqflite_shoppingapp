class AddressModel {
  int? addressId;
  int? addressUserId;
  String? addressOne;
  String? addressArea;
  String? pincode;
  String? townCity;
  String? state;

  AddressModel(
      {this.addressId,
      this.addressUserId,
      this.addressOne,
      this.addressArea,
      this.pincode,
      this.townCity,
      this.state});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'addressOne': addressOne,
      'addressUserId': addressUserId,
      'addressArea': addressArea,
      'pincode': pincode,
      'townCity': townCity,
      'state': state,
    };
    return map;
  }

  AddressModel.fromMap(Map<String, dynamic> map) {
    addressId = map['addressId'];
    addressUserId = map['addressUserId'];
    addressOne = map['addressOne'];
    addressArea = map['addressArea'];
    pincode = map['pincode'];
    townCity = map['townCity'];
    state = map['state'];
  }
}
