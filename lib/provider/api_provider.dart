import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/constant/baseUrl.dart';
import 'package:swp_project_web/constant/myToken.dart';
import 'package:swp_project_web/models/response/auction_model.dart';
import 'package:swp_project_web/models/response/form_model.dart';
import 'package:swp_project_web/models/response/property_model.dart';
import 'package:swp_project_web/models/response/user_login_model.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';
import 'package:http_parser/http_parser.dart';

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

  static Future<String?> uploadImage(Uint8List image, String imageName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    final url = Uri.parse('$baseUrl/v1/auction/storage/Upload');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          image,
          filename: imageName, // Tên tệp tinh chỉnh
          contentType: MediaType('image', 'jpeg'), // Định dạng của hình ảnh
        ),
      );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Upload thành công: ${jsonResponse['result']}');
        return jsonResponse['result'];
      } else {
        print('Lỗi upload: ${response.toString()}');
        return null;
      }
    } catch (e) {
      print('Upload lỗi: $e');
      return null;
    }
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
      // print("TEST get profile: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          userProfileModel = UserProfileModel.fromMap(bodyConvert['result']);
          print("Thông tin model từ get profile: $userProfileModel");
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

  // <<<< Get all post >>>>
  static Future<List<FormsModel>?> getAllPosts() async {
    List<FormsModel>? posts;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/v1/auction/post/all";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get all posts: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          var postsJson = bodyConvert['result'];
          posts = postsJson
              .map<FormsModel>((postJson) => FormsModel.fromMap(postJson))
              .toList();
          print("Thông tin get all posts: $posts");
        }
      }
    } catch (e) {
      print("Loi get all posts: $e");
    }

    return posts;
  }

  // <<<< Get all property >>>>
  static Future<List<PropertyModel>?> getAllProperties() async {
    List<PropertyModel>? properties;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/v1/auction/property/all";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get all posts: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          var postsJson = bodyConvert['result'];
          properties = postsJson
              .map<PropertyModel>((postJson) => PropertyModel.fromMap(postJson))
              .toList();
          print("Thông tin get all property: $properties");
        }
      }
    } catch (e) {
      print("Loi get all tài sản: $e");
    }

    return properties;
  }

// <<<< Get all post auction >>>>
  static Future<List<AuctionModel>?> getAllPostAuction() async {
    List<AuctionModel>? auctions;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/v1/auction/auction/all";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get all posts: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          var postsJson = bodyConvert['result'];
          auctions = postsJson
              .map<AuctionModel>((postJson) => AuctionModel.fromMap(postJson))
              .toList();
          print("Thông tin get all auction: $auctions");
        }
      }
    } catch (e) {
      print("Loi get all auction: $e");
    }

    return auctions;
  }

// <<<< Get all user >>>>
  static Future<List<UserProfileModel>?> getAllUsers() async {
    List<UserProfileModel>? users;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/v1/auction/user/all";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get all posts: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          var postsJson = bodyConvert['result'];
          users = postsJson
              .map<UserProfileModel>(
                  (postJson) => UserProfileModel.fromMap(postJson))
              .toList();
          print("Thông tin get all users: $users");
        }
      }
    } catch (e) {
      print("Loi get all user: $e");
    }

    return users;
  }

  //Tạo đơn
  static Future<bool> createForm(FormsModel formCreate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/auction/post/member/new";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = json.encode(formCreate.toMap());
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: body);
      print(response.body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          print("Gửi đơn thành công");
          return true;
        } else {
          print("Lỗi gửi đơn: ${response.body}");
          return false;
        }
      }
    } catch (e) {
      print("Lỗi gửi đơn: $e");
      return false;
    }
    return false;
  }
}
