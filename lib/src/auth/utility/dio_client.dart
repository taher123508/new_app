
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/src/auth/utility/%D9%90AppUri.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/User_profile.dart';
import '../domain/user.dart';
import '../domain/user_date.dart';
import '../function/save_curent_user.dart';
import 'loggin.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: AppUri.BaseUri,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }),
  )..interceptors.add(Logging());

  Future<User?> getUser({required String id}) async {
    User? user;

    try {
      Response userData = await _dio.get('/users/$id');

      print('User Info: ${userData.data}');

      user = User.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return user;
  }

  Future<UserDateAuth?> createUser({required User user}) async {
    UserDateAuth? curentUser;
    final formData = FormData.fromMap({
      'FirstName': user.FirstName,
      'LastName': user.LastName,
      'Email': user.Email,
      'Password': user.Password,
      'DisplayName': user.DisplayName,
      'ProfilePicture': await MultipartFile.fromFile(user.ProfilePicture.path,
          filename: 'image.jpg')
    });

    Response response;
    try {
      response = await _dio.post(
        AppUri.RegisterUser,
        data: formData,
      );

      print('User created: ${response.data}');
      if (response.statusCode == 200) {
        var id = response.data['id'].toString();
        var message = response.data['message'].toString();
        var email = response.data['email'].toString();
        var token = response.data['token'].toString();
        var roles = response.data['roles'].toString();
        var displayName = response.data['displayName'].toString();
        var expiresOn = response.data['expiresOn'].toString();
        var isAuthenticated = response.data['isAuthenticated'].toString();
        var refreshToken = response.data['refreshToken'].toString();
        var refreshTokenExpiration =
            response.data['refreshTokenExpiration'].toString();
        curentUser = new UserDateAuth(
            token: token,
            refreshTokenExpiration: refreshTokenExpiration,
            email: email,
            displayName: displayName,
            expiresOn: expiresOn,
            id: id,
            isAuthenticated: isAuthenticated,
            message: message,
            refreshToken: refreshToken,
            roles: roles);
      }
    } catch (e) {
      Error();
    }

    return curentUser;
  }
  Future<bool?> createAuthor({
    required String bio,
    required String userName,
    required String email,
    required String password,
    required File image,


}) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    final formData = FormData.fromMap({

      'Email': email,
      'Password': password,
      'DisplayName': userName,
      'Bio': bio,
      'ProfilePicture': await MultipartFile.fromFile(image.path,
          filename: 'image.jpg')
    });

    Response response;
    try {
      response = await _dio.post(
        AppUri.RegisterAuthor,
        data: formData,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      print('User created: ${response.data}');
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      Error();
    }


  }
  Future<UserDateAuth?> loginUser(
      {required String email, required String password}) async {
    UserDateAuth? curentUser;
    Response response;

    try {
      response = await _dio.post(
        AppUri.Userlogin,
        data: {
          "email": email,
          "password": password,
        },
      );

      print('User created: ${response.data}');
      if (response.statusCode == 200) {
        var id = response.data['id'].toString();
        var message = response.data['message'].toString();
        var email = response.data['email'].toString();
        var token = response.data['token'].toString();
        var roles = response.data['roles'].toString();
        var displayName = response.data['displayName'].toString();
        var expiresOn = response.data['expiresOn'].toString();
        var isAuthenticated = response.data['isAuthenticated'].toString();
        var refreshToken = response.data['refreshToken'].toString();
        var refreshTokenExpiration =
            response.data['refreshTokenExpiration'].toString();
        curentUser = new UserDateAuth(
            token: token,
            refreshTokenExpiration: refreshTokenExpiration,
            email: email,
            displayName: displayName,
            expiresOn: expiresOn,
            id: id,
            isAuthenticated: isAuthenticated,
            message: message,
            refreshToken: refreshToken,
            roles: roles);
        // curentUser=UserDateAuth.fromJson(response.data);

      }

      return curentUser;
    } catch (e) {
      Error();
    }
  }

  Future<UserDateAuth?> loginAuthor(
      {required String email, required String password}) async {
    UserDateAuth? curentUser;
    Response response;

    try {
      response = await _dio.post(
        AppUri.LoginAuthor,
        data: {
          "email": email,
          "password": password,
        },
      );

      print('User created: ${response.data}');
      if (response.statusCode == 200) {
        var id = response.data['id'].toString();
        var message = response.data['message'].toString();
        var email = response.data['email'].toString();
        var token = response.data['token'].toString();
        var roles = response.data['roles'].toString();
        var displayName = response.data['displayName'].toString();
        var expiresOn = response.data['expiresOn'].toString();
        var isAuthenticated = response.data['isAuthenticated'].toString();
        var refreshToken = response.data['refreshToken'].toString();
        var refreshTokenExpiration =
            response.data['refreshTokenExpiration'].toString();
        curentUser = new UserDateAuth(
            token: token,
            refreshTokenExpiration: refreshTokenExpiration,
            email: email,
            displayName: displayName,
            expiresOn: expiresOn,
            id: id,
            isAuthenticated: isAuthenticated,
            message: message,
            refreshToken: refreshToken,
            roles: roles);
        // curentUser=UserDateAuth.fromJson(response.data);

      }

      return curentUser;
    } catch (e) {
      Error();
    }
  }

  Future<UserDateAuth?> loginAdmin(
      {required String email, required String password}) async {
    UserDateAuth? curentUser;
    Response response;

    try {
      response = await _dio.post(
        AppUri.LoginAdmin + '?Email=$email&Password=$password',
        data: {
          "email": email,
          "password": password,
        },
      );

      print('User created: ${response.data}');
      if (response.statusCode == 200) {
        var id = response.data['id'].toString();
        var message = response.data['message'].toString();
        var email = response.data['email'].toString();
        var token = response.data['token'].toString();
        var roles = response.data['roles'].toString();
        var displayName = response.data['displayName'].toString();
        var expiresOn = response.data['expiresOn'].toString();
        var isAuthenticated = response.data['isAuthenticated'].toString();
        var refreshToken = response.data['refreshToken'].toString();
        var refreshTokenExpiration =
            response.data['refreshTokenExpiration'].toString();
        curentUser = new UserDateAuth(
            token: token,
            refreshTokenExpiration: refreshTokenExpiration,
            email: email,
            displayName: displayName,
            expiresOn: expiresOn,
            id: id,
            isAuthenticated: isAuthenticated,
            message: message,
            refreshToken: refreshToken,
            roles: roles);
        // curentUser=UserDateAuth.fromJson(response.data);

      }

      return curentUser;
    } catch (e) {
      Error();
    }
  }

  Future<bool?> updateUser({
    required String email,
    required String userName,
    required String password,
    required File image,


  }) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    String? id = await preferences.getString('id');

    final formData = FormData.fromMap({

      'Email':email,
      'Password':password,
      'DisplayName':userName,
      'ProfilePicture': await MultipartFile.fromFile(image.path,
          filename: 'image.jpg')
    });

    try {
      Response response = await _dio.put(
   AppUri.profileuser+id.toString(),
        data:formData ,
          options:
          Options(headers: {'Authorization': "Bearer " + token.toString()}),



      );
      if(response.statusCode==204){
        return true;

      }


    } catch (e) {
      print('Error updating user: $e');
    }

  }
  Future<bool?> updateAuthor({
    required String bio,
    required String userName,
    required String password,
    required String email,
    required File image,


  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    String? id = await preferences.getString('id');

    final formData = FormData.fromMap({
      "Password": password,
      "DisplayName": userName,
      "Bio": bio,
      "Email": email,
      'ProfilePicture': await MultipartFile.fromFile(image.path,
          filename: 'image.jpg')
    });

    try {
      Response response = await _dio.put(
        'api/Author/$id',
        data: formData,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),



      );
      if(response.statusCode==204){
        return true;

      }


    } catch (e) {
      print('Error updating user: $e');
    }

  }

  Future<void> deleteUser({required String id}) async {
    try {
      await _dio.delete('/users/$id');
      print('User deleted!');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<UserProfile?> SetUrlImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    String? id = await preferences.getString('id');
    Response response;
    UserProfile     userProfile =UserProfile();
    String urlImage=' ';
    try {
      //   options.headers["Authorization"] = "Bearer " + token.toString();
      response = await _dio.get(
        'api/User/' + id.toString(),
        options:
            Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );


      if (response.statusCode == 200) {
        urlImage = response.data['profilePicture'].toString();

      }
      print(userProfile);
      await SaveImage( urlImage);
      return userProfile;

    } catch (e) {
      Error();
    }
  }
  Future<UserProfile?> getProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    String? id = await preferences.getString('id');
    Response response;
    UserProfile     userProfile =UserProfile();
    String urlImage=' ';
    try {
      //   options.headers["Authorization"] = "Bearer " + token.toString();
      response = await _dio.get(
        'api/User/' + id.toString(),
        options:
            Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );


      if (response.statusCode == 200) {
        userProfile.email=response.data['email'].toString();
        userProfile.profilePicture=response.data['profilePicture'].toString();
        userProfile.displayName=response.data['displayName'].toString();
        userProfile.firstName=response.data['firstName'].toString();
        userProfile.lastName=response.data['firstName'].toString();

      }
      print(userProfile);
      return userProfile;

    } catch (e) {
      Error();
    }
  }

  Future<UserProfile?> getProfileAuthor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    String? id = await preferences.getString('id');
    Response response;
    UserProfile     userProfile =UserProfile();
    String urlImage=' ';
    try {
      //   options.headers["Authorization"] = "Bearer " + token.toString();
      response = await _dio.get(
        'api/Author/',
        options:
            Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );





    if (response.statusCode == 200) {

        var itemWithId2 = response.data.firstWhere((item) => item["id"] == int.parse(id!));
print(itemWithId2);

        userProfile.profilePicture=itemWithId2['profilePicture'].toString();
        userProfile.displayName=itemWithId2['displayName'].toString();
        userProfile.bio=itemWithId2['bio'].toString();
        userProfile.email=itemWithId2['email'].toString();


      }
      return userProfile;

    } catch (e) {
      Error();
    }
  }

  Future<bool?> createPost({
    required String title,
    required String content,
    required String categoryid,
    required File image,

  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    String? id = await preferences.getString('id');
    final formData = FormData.fromMap({
      'Title':title,
      'Content':content,
      'ViewCount':0,
      'AuthorId':int.parse(id!),
      'CategoryId':int.parse(categoryid),
      'Images': await MultipartFile.fromFile(image.path,
          filename: 'image.jpg')
    });

    Response response;
    try {
      response = await _dio.post(
        'api/Article',
        data: formData,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      print('User created: ${response.data}');
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      Error();
    }

  }
  Future<bool?> editPost({
    required String title,
    required String content,
    required String categoryid,
    required String idArticle,
    required   File image,


  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    final formData = FormData.fromMap({
      "Title": title,
      "Content": content,
      "ViewCount": 0,
      "CategoryId": int.parse(categoryid),
      'Images': await MultipartFile.fromFile(image.path,
          filename: 'image.jpg')
    });


    try {
      Response response = await _dio.put(
        'api/Article/'+idArticle,
        data: formData,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),


      );
      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }

}
