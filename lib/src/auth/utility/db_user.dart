import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/src/api_news_custom/Admin/ReportAuthors.dart';
import 'package:news_app/src/auth/utility/%D9%90AppUri.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_news_custom/Admin/model/ReportAuthor_moode.dart';
import 'Datanews.dart';
import 'loggin.dart';

class DBUser {
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

  Future<List?> getNews() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    Response response;

    try {
      //   options.headers["Authorization"] = "Bearer " + token.toString();
      response = await _dio.get(
        AppUri.NewsAll,
        options:
            Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 200) {
        //  print('Url image: ${response.data}');

        final jsonData = response.data;
        final articlesData = jsonData['articles'] as List;
        return articlesData
            .map((articleJson) => Article.fromJson(articleJson))
            .toList();
      }
    } catch (e) {
      Error();
    }
  }
  // Future<List?> getMyPost() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? token = await preferences.getString('token');
  //   String? id = await preferences.getString('id');
  //   Response response;
  //
  //   try {
  //     //   options.headers["Authorization"] = "Bearer " + token.toString();
  //     response = await _dio.get(
  //     'api/Author/'+id!+'?pageNumber=1&pageSize=100',
  //       options:
  //           Options(headers: {'Authorization': "Bearer " + token.toString()}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //         print('Url image: ${response.data['articles']}');
  //
  //       // final jsonData = response.data;
  //       // final articlesData = jsonData['articles'] as List;
  //       // return articlesData
  //       //     .map((articleJson) => Article.fromJson(articleJson))
  //       //     .toList();
  //     }
  //   } catch (e) {
  //     Error();
  //   }
  // }
  Future<List?> getReportAuthor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    Response response;

    try {
      //   options.headers["Authorization"] = "Bearer " + token.toString();
      response = await _dio.get(
        AppUri.reportAuthor,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 200) {

        //print(response.data);
        final jsonData = response.data;
        final AuthorsLogViewData = jsonData['authorsLogView'] ;
        // List<AuthorsLogView> report=AuthorsLogViewData
        //     .map((reportJson) => AuthorsLogView.fromJson(reportJson))
        //     .toList();
        // List<AuthorsLogView> logList = response.data['authorsLogView'].map((json) => AuthorsLogView.fromJson(json)).toList();

        print(AuthorsLogViewData);
        return AuthorsLogViewData as List;

      }
    } catch (e) {
      Error();
    }
  }
  Future<List?> getAuthors() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    Response response;

    try {
      //   options.headers["Authorization"] = "Bearer " + token.toString();
      response = await _dio.get(
        AppUri.Authors,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 200) {

        //print(response.data);
        final jsonData = response.data;

        print(jsonData);
        return jsonData as List;

      }
    } catch (e) {
      Error();
    }
  }
  Future<List?> getUsers() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    Response response;

    try {
      //   options.headers["Authorization"] = "Bearer " + token.toString();
      response = await _dio.get(
        AppUri.Users,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 200) {

        //print(response.data);
        final jsonData = response.data['users'];

        print(jsonData);
        return jsonData as List;

      }
    } catch (e) {
      Error();
    }
  }

  Future<List?> getCategory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    Response response;

    try {
      //   options.headers["Authorization"] = "Bearer " + token.toString();
      response = await _dio.get(
        AppUri.AddCategory,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 200) {

        print(response.data);


        return response.data as List;

      }
    } catch (e) {
      Error();
    }
  }
  Future<List?> getReportUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    Response response;

    try {
      //   options.headers["Authorization"] = "Bearer " + token.toString();
      response = await _dio.get(
        AppUri.reportUser,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 200) {

        //print(response.data);
        final jsonData = response.data;
        final AuthorsLogViewData = jsonData['usersLogView'] ;
        // List<AuthorsLogView> report=AuthorsLogViewData
        //     .map((reportJson) => AuthorsLogView.fromJson(reportJson))
        //     .toList();
        // List<AuthorsLogView> logList = response.data['authorsLogView'].map((json) => AuthorsLogView.fromJson(json)).toList();

        print(AuthorsLogViewData);
        return AuthorsLogViewData as List;

      }
    } catch (e) {
      Error();
    }
  }
  Future<bool?> setLike(String? id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    String? userid = await preferences.getString('id');
    Response response;

    try {
      response = await _dio.post(AppUri.SetLike + id! + '/Like',
          options:
              Options(headers: {'Authorization': "Bearer " + token.toString()}),
          data: {'userId': int.parse(userid!)});

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      Error();
    }
  }

  // Future<List<Like>?> getLikes(String? id) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? token = preferences.getString('token');
  //
  //   //String? userid = preferences.getString('id');
  //   bool x =false;
  //   Response response;
  //   try {
  //     response = await _dio.get(
  //       AppUri.SetLike +id!+'/Like?pageNumber=1&pageSize=100',
  //       options:
  //           Options(headers: {'Authorization': "Bearer " + token.toString()}),
  //     );
  //     if (response.statusCode == 200) {
  //       List<Like> likes = response.data! as List<Like>;
  //        return likes;
  //     }
  //   } catch (e) {
  //     Error();
  //   }
  //
  //
  // }

  Future<bool?> deleteLike(String? id, List<Like> likes) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    String? userid = await preferences.getString('id');
    int? likeId;
    Response response;
    for (int i = 0; i < likes.length; i++) {
      if (likes[i].userId == int.parse(userid!)) {
        likeId = likes[i].id;
        print(likes[i]);
        break;
      }
    }
//Like like= likes.where((element) => element.userId==int.parse(userid!))as Like;

    try {
      response = await _dio.delete(
        AppUri.SetLike + id! +'/Like/'+ likeId.toString(),
        options:
            Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      Error();
    }
  }


  Future<bool?> deleteComment({String? idComment,String? idArticle}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');

    Response response;


    try {
      response = await _dio.delete(
         'api/Article/'+idArticle!+'/Comment/'+idComment.toString(),
        options:
            Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      Error();
    }
  }


  Future<bool> isLiked(List<Like> likes) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');

    bool isLike = likes.any((like) => like.userId == int.parse(id!));
    print(isLike);

    return isLike;
  }

  Future<bool?> setComment(String? id,String? content) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    String? userid = await preferences.getString('id');
    Response response;

    try {
      response = await _dio.post(AppUri.SetComment + id! + '/Comment',
          options:
          Options(headers: {'Authorization': "Bearer " + token.toString()}),
          data: {
        'userId': userid,
            'commentText':content

      });

      if (response.statusCode == 201) {
        print(response.data);
        return response.data;
      }
    } catch (e) {
      Error();
    }
  }

  Future<bool?> addCategoey(String? name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');
    Response response;

    try {
      response = await _dio.post(AppUri.AddCategory,
          options:
          Options(headers: {'Authorization': "Bearer " + token.toString()}),
          data: {
            'categoryName': name,


          });

      if (response.statusCode == 201) {
        print(response.data);
        return true;
      }
    } catch (e) {
      Error();
    }
  }

  Future<bool?> deleteAuthor({String? idAuthor}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');

    Response response;


    try {
      response = await _dio.delete(
        'api/Author/'+idAuthor!,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      Error();
    }
  }

  Future<bool?> deleteUser({String? idUser}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');

    Response response;


    try {
      response = await _dio.delete(
        'api/User/'+idUser!,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      Error();
    }
  }

  Future<bool?> deleteCategory({String? idCategory}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');

    Response response;


    try {
      response = await _dio.delete(
        AppUri.AddCategory+'/$idCategory',
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      Error();
    }
  }
  Future<bool?> deleteArticle({String? idArtcle}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = await preferences.getString('token');

    Response response;


    try {
      response = await _dio.delete(
        'api/Article/'+idArtcle!,
        options:
        Options(headers: {'Authorization': "Bearer " + token.toString()}),
      );

      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      Error();
    }
  }

}
