import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import './user_model.dart';

class LoadUserInfo {
  late UserModel usr;

  Future<dynamic> loadUserInfoAsset() async {
    String _loadData = await rootBundle.loadString('./user_info.json');
    final jsonResponse = json.decode(_loadData);
  }
}
