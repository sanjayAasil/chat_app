
import 'package:chat_app/Models/user_model.dart';


class DataManager {
  static final DataManager _instance = DataManager._();

  DataManager._();

  factory DataManager() => _instance;

  UserModel? user;
}
