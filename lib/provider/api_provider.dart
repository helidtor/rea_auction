import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/constant/baseUrl.dart';
import 'package:swp_project_web/constant/myToken.dart';
import 'package:swp_project_web/models/response/auction_model.dart';
import 'package:swp_project_web/models/response/form_auction.dart';
import 'package:swp_project_web/models/response/form_done_model.dart';
import 'package:swp_project_web/models/response/form_model.dart';
import 'package:swp_project_web/models/response/property_model.dart';
import 'package:swp_project_web/models/response/top_3_model.dart';
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
      final body = {'username': username, 'password': password};
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      // print("TEST login: ${response.body}");
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

//Up nhiều ảnh
  static Future<List<String>?> uploadMultiImage(
      List<Uint8List> images, List<String> imageNames) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    final url = Uri.parse('$baseUrl/v1/auction/storage/upload/multiple-files');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    final request = http.MultipartRequest('POST', url)..headers.addAll(headers);

    for (int i = 0; i < images.length; i++) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'files',
          images[i],
          filename: imageNames[i], // Tên tệp tinh chỉnh
          contentType: MediaType('image', 'jpeg'), // Định dạng hình ảnh
        ),
      );
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Upload thành công: ${jsonResponse['result']}');
        // Trả về danh sách các đường dẫn của các tệp ảnh đã tải lên
        return List<String>.from(jsonResponse['result']);
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
          // print("Thông tin model từ get profile: $userProfileModel");
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

  // <<<< Get all auction >>>>
  static Future<List<AuctionModel>?> getAllAuctions() async {
    List<AuctionModel>? auction;
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
          auction = postsJson
              .map<AuctionModel>((postJson) => AuctionModel.fromMap(postJson))
              .toList();
          // print("Thông tin get all form: $posts");
        }
      }
    } catch (e) {
      print("Loi get all auction: $e");
    }

    return auction;
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
          // print("Thông tin get all form: $posts");
        }
      }
    } catch (e) {
      print("Loi get all form: $e");
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
          return properties;
        } else {
          print("Không get được list tài sản");
        }
      }
    } catch (e) {
      print("Loi get all tài sản: $e");
    }

    return properties;
  }

// <<<< Payment cọc>>>>
  static Future<bool?> paymentDeposit(int idAuction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url =
          "$baseUrl/v1/auction/payment/member/pay-deposit-auction?auctionId=$idAuction";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response =
          await http.post(Uri.parse(url.toString()), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          return true;
        } else {
          print("Thanh toán lỗi");
          return false;
        }
      }
    } catch (e) {
      print("Error payment: $e");
    }
    return false;
  }

// <<<< Check join auction>>>>
  static Future<bool?> checkJoinAuction(int idAuction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    bool isJoin = false;
    try {
      var url =
          "$baseUrl/v1/auction/userauction/check-join-auction?auctionId=$idAuction";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          isJoin = bodyConvert['result'];
          return isJoin;
        } else {
          print("Lỗi check tham gia đấu gia");
        }
      }
    } catch (e) {
      print("Error check joining: $e");
    }
    return isJoin;
  }

// <<<< Get property by id>>>>
  static Future<PropertyModel?> getPropertyById(int id) async {
    PropertyModel? property;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/v1/auction/property/$id";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          var postsJson = bodyConvert['result'];
          property = PropertyModel.fromMap(postsJson);
          print("Thông tin get property by id: $property");
          return property;
        } else {
          print("Không get được tài sản");
        }
      }
    } catch (e) {
      print("Loi get tài sản bằng id: $e");
    }

    return property;
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

  // <<<< Get auction by id >>>>
  static Future<AuctionModel?> getAuctionById({required int id}) async {
    AuctionModel? auctionModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/auction/auction/$id";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print("TEST get auction by id: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          auctionModel = AuctionModel.fromMap(bodyConvert['result']);
          // print("Thông tin model từ get profile: $userProfileModel");
          return auctionModel;
          // return userProfileModel =
          //     UserProfileModel.fromMap(bodyConvert['result']);
        }
      }
    } catch (e) {
      print("Loi get profile: $e");
    }
    return auctionModel;
  }

// <<<< Get user by id>>>>
  static Future<UserProfileModel?> getUserById(int id) async {
    UserProfileModel? userProfileModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/v1/auction/user/$id";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          var postsJson = bodyConvert['result'];
          userProfileModel = UserProfileModel.fromMap(postsJson);
          print("Thông tin get user by id: $userProfileModel");
          return userProfileModel;
        } else {
          print("Không get được user");
        }
      }
    } catch (e) {
      print("Loi get user bằng id: $e");
    }

    return userProfileModel;
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
          // print("Thông tin get all users: $users");
        }
      }
    } catch (e) {
      print("Loi get all user: $e");
    }

    return users;
  }

  // <<<< Get top 3 user >>>>
  static Future<List<Top3Model>?> getTop3({required int idAuction}) async {
    List<Top3Model>? listTop3;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    print('id auction xét winner: $idAuction');
    try {
      var url = "$baseUrl/v1/auction/userauction/get-top3?auctionId=$idAuction";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST get top 3: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          var postsJson = bodyConvert['result'];
          listTop3 = postsJson
              .map<Top3Model>((postJson) => Top3Model.fromMap(postJson))
              .toList();
          print("Thông tin get top 3: $listTop3");
        }
      } else {
        return listTop3;
      }
    } catch (e) {
      print("Loi get all user: $e");
    }

    return listTop3;
  }

  //Đăng ký đấu giá
  static Future<bool> joinAuction(int idAuction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url =
          "$baseUrl/v1/auction/userauction/member/join-auction?auctionId=$idAuction";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response =
          await http.post(Uri.parse(url.toString()), headers: header);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print("Lỗi đăng ký: $e");
      return false;
    }
    return false;
  }

  //Đặt tiền đấu giá
  static Future<bool> bidAuction(int idAuction, double bidAmount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    print('$idAuction và $bidAmount');
    try {
      var url =
          "$baseUrl/v1/auction/userauction/bidding-amount?auctionId=$idAuction";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = {"biddingAmount": bidAmount};
      var bodyConvert = json.encode(body);
      var response = await http.patch(Uri.parse(url.toString()),
          headers: header, body: bodyConvert);
      var resultBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(resultBody);
        return true;
      } else {
        print(resultBody);
        return false;
      }
    } catch (e) {
      print("Lỗi đặt tiền đấu giá: $e");
      return false;
    }
    return false;
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

  //Tạo đơn lấy cọc
  static Future<bool> createFormDone(FormDoneModel formCreate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/auction/TransferForm/member/new";
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

//Tạo đấu giá
  static Future<bool> createAuction(FormAuction auctionModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    try {
      var url = "$baseUrl/v1/auction/auction/staff/new";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var body = json.encode(auctionModel.toMap());
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: body);
      print(response.body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          print("Tạo auction thành công");
          return true;
        } else {
          print("Lỗi tạo auction: ${response.body}");
          return false;
        }
      }
    } catch (e) {
      print("Lỗi tạo: $e");
      return false;
    }
    return false;
  }

  //Phê duyệt đơn
  static Future<bool?> approveForm({required int idForm}) async {
    var url = '$baseUrl/v1/auction/post/approve?postId=$idForm';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});

    try {
      var response =
          await http.patch(Uri.parse(url.toString()), headers: header);
      print("TEST approve: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          print('Phê duyệt thành công: ${bodyConvert['result']}');
          return true;
          // return userLoginModel = UserLoginModel.fromMap(bodyConvert['result']);
        } else {
          print('Phê duyệt lỗi: ${bodyConvert['result']}');
          return false;
        }
      }
    } catch (e) {
      print("Loi phê duyệt: $e");
    }
    return false;
  }

  //Phê duyệt đơn
  static Future<bool?> declineForm(
      {required int idForm, required String reason}) async {
    var url = '$baseUrl/v1/auction/post/reject?postId=$idForm';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    Map<String, String> header = await getHeader();
    header.addAll({'Authorization': 'Bearer $token'});

    var body = {"reason": reason};

    try {
      var response = await http.patch(Uri.parse(url.toString()),
          headers: header, body: json.encode(body));
      print("TEST decline: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['isError'] == false) {
          print('Từ chối thành công: ${bodyConvert['result']}');
          return true;
          // return userLoginModel = UserLoginModel.fromMap(bodyConvert['result']);
        } else {
          print('Từ chối lỗi: ${bodyConvert['result']}');
          return false;
        }
      }
    } catch (e) {
      print("Loi từ chối: $e");
    }
    return false;
  }

  //payment
  static Future<String?> payment(
      {required int userId, required double amount}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);
    String? urlPayment;
    try {
      var url = "$baseUrl/v1/auction/VNPay?UserId=$userId&Amount=$amount";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      // print(response.body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          var postsJson = bodyConvert['result'];
          urlPayment = postsJson;
          print('Link payment: {$urlPayment}');
          return urlPayment;
        } else {
          return null;
        }
      }
    } catch (e) {
      print("Lỗi payment: $e");
      return null;
    }
    return null;
  }

  // <<<< Get all property is done>>>>
  static Future<List<PropertyModel>?> getAllPropertyAvailable() async {
    List<PropertyModel>? properties;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(myToken);

    try {
      var url = "$baseUrl/v1/auction/property/available";
      Map<String, String> header = await getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST get all getAllPropertyAvailable: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        if (bodyConvert['isError'] == false) {
          var postsJson = bodyConvert['result'];
          properties = postsJson
              .map<PropertyModel>((postJson) => PropertyModel.fromMap(postJson))
              .toList();
          print("Thông tin get all property available: $properties");
          return properties;
        } else {
          print("Không get được list tài sản available");
        }
      }
    } catch (e) {
      print("Loi get all tài sản available: $e");
    }

    return properties;
  }
}
