import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/constant/myToken.dart';
import 'package:swp_project_web/models/response/user_login_model.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/screens/home/home_page.dart';

String baseUrl = 'https://reaauction.azurewebsites.net';

class ApiProvider {
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      "content-type": "application/json",
      "accept": "application/json",
    };
    return header;
  }

  static Future<UserLoginModel?> logins(
      {required String username, required String password}) async {
    UserLoginModel? userLoginModel;

    final url = Uri.parse('$baseUrl/v1/auction/auth/login');
    Map<String, String> header = await getHeader();
    try {
      final body = {
        'username': username,
        'password': password,
      };
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print("TEST login: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          userLoginModel = UserLoginModel.fromMap(bodyConvert['result']);
          print(userLoginModel);
          return userLoginModel;
          // return userLoginModel = UserLoginModel.fromMap(bodyConvert['result']);
        }
      }
    } catch (e) {
      print("Loi login: $e");
    }
    return userLoginModel;
  }

  // <<<< Get profile >>>>
  static Future<UserProfileModel?> getProfile() async {
    UserProfileModel? userProfileModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/auction/user/available";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST get profile: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          userProfileModel = UserProfileModel.fromMap(bodyConvert['result']);
          print(userProfileModel);
          return userProfileModel;
          // return userProfileModel =
          //     UserProfileModel.fromMap(bodyConvert['result']);
        }
      }
    } catch (e) {
      print("Loi get profile: $e");
    }
    return userProfileModel;
  }

  static Future<bool> postToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    String? tokenfirebase = prefs.getString("tokenfirebase");
    try {
      var url = "$baseUrl/v1/auction/notification";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = {"token": tokenfirebase ?? ""};
      var bodyConvert = json.encode(body);
      var response = await http.patch(Uri.parse(url.toString()),
          headers: header, body: bodyConvert);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("Loi token: $e");
      return false;
    }
    return false;
  }

  static Future<bool> updateProfile(UserProfileModel userProfileModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/auction/user/available";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = json.encode(userProfileModel.toMap());
      var response = await http.put(Uri.parse(url.toString()),
          headers: header, body: body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          print("Update profile done");
          return true;
        } else {
          print("Loi update profile: ${response.body}");
          return false;
        }
      }
    } catch (e) {
      print("Loi update profile: $e");
      return false;
    }
    return false;
  }

  static Future<bool> changePassword(
      {required String currentPass,
      required String newPass,
      required String confirmPass}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/auction/auth/change-password";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = {
        "currentPassword": currentPass,
        "newPassword": newPass,
        "confirmNewPassword": confirmPass
      };
      var bodyConvert = json.encode(body);
      var response = await http.patch(Uri.parse(url.toString()),
          headers: header, body: bodyConvert);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("Loi: $e");
      return false;
    }
    return false;
  }
}
