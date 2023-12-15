class BusinessModel {
  int? businessId;
  int? businessUserId;
  String? fandlname;
  String? businessNumber;
  String? industry;
  String? businessPan;
  String? businessName;

  BusinessModel(
      {this.businessId,
      this.businessUserId,
      this.fandlname,
      this.businessNumber,
      this.industry,
      this.businessPan,
      this.businessName});

  Map<String, dynamic> toMap() {
    var maps = <String, dynamic>{
      'businessUserId': businessUserId,
      'fandlname': fandlname,
      'businessNumber': businessNumber,
      'industry': industry,
      'businessPan': businessPan,
      'businessName': businessName,
    };
    return maps;
  }

  BusinessModel.fromMap(Map<String, dynamic> map) {
    businessId = map['businessId'];
    businessUserId = map['businessUserId'];
    fandlname = map['fandlname'];
    businessNumber = map['businessNumber'];
    industry = map['industry'];
    businessPan = map['businessPan'];
    businessName = map['businessName'];
  }
}
