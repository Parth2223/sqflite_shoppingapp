import 'package:sqlfliteshop/database/user_helper.dart';
import 'package:sqlfliteshop/models/product_model.dart';
import 'package:sqlfliteshop/models/user_model.dart';

class ListData {
  UserHelper dbHelper = UserHelper();
  UserModel? profileListData;
  List<ProductModel> productList = [];
}
