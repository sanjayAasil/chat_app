import 'package:chat_app/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataManager {
  static final DataManager _instance = DataManager._();

  DataManager._();

  factory DataManager() => _instance;

}
