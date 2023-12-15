import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlfliteshop/models/address_model.dart';
import 'package:sqlfliteshop/models/businss_model.dart';
import 'package:sqlfliteshop/models/product_model.dart';
import 'package:sqlfliteshop/models/user_model.dart';

class UserHelper {
  static Database? _db;

  static const String datatableName = "shoppingapp";
  static const String userTable = "userTable";
  static const int version = 1;

  static const String userId = "userId";
  static const String firstname = "firstname";
  static const String lastname = "lastname";
  static const String username = "username";
  static const String mobilenumber = "mobilenumber";
  static const String emailaddress = "emailaddress";
  static const String password = "password";
  static const String gender = "gender";
  static const String selectUser = "selectUser";
  static const String businessNameSignup = "businessNameSignup";
  static const String birthdate = "birthdate";
  static const String image = "image";

  static const String addressTable = "addressTable";
  static const String addressUserId = 'addressUserId';
  static const String addressId = "addressId";
  static const String addressOne = "addressOne";
  static const String addressArea = "addressArea";
  static const String pincode = "pincode";
  static const String townCity = "townCity";
  static const String state = "state";

  static const String businessTable = "businessTable";
  static const String businessId = "businessId";
  static const String businessUserId = "businessUserId";
  static const String fandlname = "fandlname";
  static const String businessNumber = "businessNumber";
  static const String businessName = "businessName";
  static const String businessPan = "businessPan";
  static const String industry = "industry";

  static const String productTable = 'productTable';
  static const String ProductId = 'ProductId';
  static const String ProductUserId = 'ProductUserId';
  static const String productCategories = 'productCategories';
  static const String productImage = 'productImage';
  static const String productName = 'productName';
  static const String productPrice = 'productPrice';
  static const String productDesc = 'productDesc';
  static const String productFullDesc = 'productFullDesc';
  static const String manufacturingDate = 'manufacturingDate';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, datatableName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intversion) async {
    await db.execute('''CREATE TABLE $userTable( 
        $userId INTEGER PRIMARY KEY AUTOINCREMENT,
        $firstname TEXT,
        $lastname TEXT,
        $username TEXT,
        $mobilenumber TEXT,
        $emailaddress TEXT,
        $password TEXT,
        $gender TEXT,
        $selectUser TEXT,
        $businessNameSignup TEXT,
        $birthdate TEXT,
        $image TEXT)''');

    await db.execute('''CREATE TABLE $addressTable(
        $addressId INTEGER PRIMARY KEY AUTOINCREMENT,
        $addressUserId INTEGER,
        $addressOne TEXT,
        $addressArea TEXT,
        $pincode TEXT,
        $townCity TEXT,  
        $state TEXT)''');

    await db.execute('''CREATE TABLE $businessTable(
        $businessId INTEGER PRIMARY KEY AUTOINCREMENT,
        $businessUserId INTEGER,
        $businessName TEXT,
        $businessNumber TEXT,
        $industry TEXT,
        $businessPan TEXT,
        $fandlname TEXT)''');

    await db.execute('''CREATE TABLE $productTable(
        $ProductId INTEGER PRIMARY KEY AUTOINCREMENT,
        $ProductUserId INTEGER,
        $productCategories TEXT,
        $productName TEXT,
        $productImage TEXT,
        $productPrice TEXT,
        $productDesc TEXT,
        $productFullDesc TEXT,
        $manufacturingDate TEXT)''');
  }

  // ============================ PRODUCT DETAILS START ============================

  // ====================== Product Insert ====================================

  Future<int?> productInsert(ProductModel user) async {
    Database? dbClient = await db;
    var response = await dbClient?.insert(productTable, user.toMap());
    return response;
  }

  Future<List<ProductModel>> allUserProductShow(UserModel userModel) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>>? maps = await dbClient?.query('$productTable',
        where: "$ProductUserId = ?", whereArgs: [userModel.userId!]);
    List<ProductModel>? alldata = maps?.isNotEmpty ?? false
        ? maps?.map((e) => ProductModel.fromMap(e)).toList()
        : [];

    return alldata ?? [];
  }

  Future<List<ProductModel>> productSearch(
      {String? searchText, String? filtter}) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>>? maps = await dbClient?.query('$productTable',
        where: '$productName Like ?',
        whereArgs: ['$searchText%'],
        orderBy: getProductByFiltter(filtter));
    List<ProductModel>? data = maps?.isNotEmpty ?? false
        ? maps?.map((e) => ProductModel.fromMap(e)).toList()
        : [];
    return data ?? [];
  }

  getProductByFiltter(String? filtter) {
    if (filtter == 'Product A-Z') {
      return '$productName ASC';
    } else if (filtter == 'Product Z-A') {
      return '$productName DESC';
    } else if (filtter == 'Product High-Low') {
      return '$productPrice ASC';
    } else if (filtter == 'Product Low-High') {
      return '$productPrice  DESC';
    }
    return null;
  }

  Future<List<ProductModel>> getProductData(int id) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>>? maps = await dbClient
        ?.query('$productTable', where: '$ProductUserId = ?', whereArgs: [id]);
    List<ProductModel>? alldata = maps?.isNotEmpty ?? false
        ? maps?.map((e) => ProductModel.fromMap(e)).toList()
        : [];

    return alldata ?? [];
  }

  Future<int?> productUpdate(ProductModel user, int id) async {
    Database? dbClient = await db;
    var response =
        dbClient?.update(productTable, user.toMap(), where: '$ProductId = $id');
    return response;
  }

  Future<int?> productDelete(int id) async {
    Database? dbClient = await db;
    var response = dbClient?.delete(productTable, where: '$ProductId = $id');
    return response;
  }

  // ============================ PRODUCT DETAILS END ============================
  //                ==========================================
//                  ==========================================
//                  ==========================================
// ============================== BUSINESS START =====================================

  Future<int?> businessInsert(BusinessModel user) async {
    Database? dbClient = await db;
    var response = await dbClient?.insert(businessTable, user.toMap());
    return response;
  }

  Future<List<BusinessModel>> getAllBusinessDetails(int id) async {
    Database? dbClient = await db;
    final List<Map<String, dynamic>>? maps = await dbClient?.query(
        '$businessTable',
        where: "$businessUserId = ?",
        whereArgs: [id]);
    List<BusinessModel>? alldata = maps?.isNotEmpty ?? false
        ? maps?.map((e) => BusinessModel.fromMap(e)).toList()
        : [];

    return alldata ?? [];
  }

  Future<int?> businessUpdateData(BusinessModel user, int id) async {
    Database? dbClient = await db;
    final response = dbClient?.update(businessTable, user.toMap(),
        where: '$businessId = $id');
    return response;
  }

  Future<int?> businessDelete(int id) async {
    Database? dbClient = await db;
    final response =
        dbClient?.delete(businessTable, where: '$businessId = $id');
    return response;
  }

// ============================== BUSINESS END =====================================
  //                ==========================================
//                  ==========================================
//                  ==========================================
// ============================== USER START =================================

// ============================== USER INSERT =====================================
  Future<int?> userinsert(UserModel user) async {
    Database? dbClient = await db;
    var res = await dbClient?.insert(userTable, user.toMap());
    return res;
  }

// =========================== USER GET ALL DATA ===================================
  Future<List<UserModel>> getAllUserData() async {
    Database? dbClient = await db;
    final List<Map<String, dynamic>>? maps = await dbClient?.query(userTable);
    List<UserModel>? alldata = maps?.isNotEmpty ?? false
        ? maps?.map((e) => UserModel.fromMap(e)).toList()
        : [];
    return alldata ?? [];
  }

// ===================================USER GET DATA BY ID =============================
  Future<UserModel?> getDataById(int id) async {
    Database? dbClient = await db;
    var response =
        await dbClient?.query(userTable, where: '$userId = ?', whereArgs: [id]);
    if (response!.isNotEmpty) {
      return UserModel.fromMap(response.first);
    }
    return null;
  }

// ===================================USER LOGIN DATA ================================
  Future<UserModel?> getUserLogin(String login, String Password) async {
    Database? dbClient = await db;
    final List<Map<String, dynamic>>? maps = await dbClient?.query(userTable,
        where: '$emailaddress = ? OR $username = ? AND $password = ?',
        whereArgs: [login, login, Password]);
    if (maps!.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int?> userupdate(UserModel user, int id) async {
    Database? dbClient = await db;
    var res =
        await dbClient?.update(userTable, user.toMap(), where: '$userId = $id');
    return res;
  }

  Future<int?> userdelete(int id) async {
    Database? dbClient = await db;
    var res = await dbClient?.delete(userTable, where: '$userId = $id');
    return res;
  }

// ============================== USER END ==============================
  //                ==========================================
//                  ==========================================
//                  ==========================================
// ============================== ADDRESS INSERT DATA ==============================

  Future<int?> addressinsert(AddressModel user) async {
    Database? dbClient = await db;
    var res = await dbClient?.insert(addressTable, user.toMap());
    return res;
  }

  Future<List<AddressModel>> getAddressItem(int id,
      {String? searchedText}) async {
    Database? dbClient = await db;
    final List<Map<String, dynamic>>? maps = await dbClient?.query(
        '$addressTable',
        where: "$addressUserId = ? AND $addressOne Like ?",
        whereArgs: [id, "$searchedText%"]);
    List<AddressModel>? alldata = maps?.isNotEmpty ?? false
        ? maps?.map((e) => AddressModel.fromMap(e)).toList()
        : [];

    return alldata ?? [];
  }

  // ==============================================================================

  Future<int?> addressUpdate(AddressModel user, int id) async {
    Database? dbClient = await db;
    var res =
        dbClient?.update(addressTable, user.toMap(), where: '$addressId = $id');
    return res;
  }

  Future<int?> addressDelete(int id) async {
    Database? dbClient = await db;
    var res = dbClient?.delete(addressTable, where: '$addressId = $id');
    return res;
  }
}
