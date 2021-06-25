import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(UserModel? user, BuildContext context) {
    if (user != null) {
      _user = user;
      saveUser(user);
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  void saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      setUser(UserModel.fromJson(json), context);
      return;
    } else {
      setUser(null, context);
    }
  }
}
