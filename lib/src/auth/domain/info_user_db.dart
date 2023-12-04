import 'package:news_app/src/auth/domain/user.dart';
import 'package:news_app/src/auth/domain/user_date.dart';

class AuthResponse {
  UserDateAuth userDateAuth;
  User user;

  AuthResponse({
  required this.userDateAuth,required this.user
  });

  factory AuthResponse.fromJson(Map<String, dynamic> parsedJson){
    return AuthResponse(
        userDateAuth:UserDateAuth.fromJson(parsedJson['userDateAuth']),
        user: User.fromJson(parsedJson['user'])
    );
  }


  Map<String, dynamic> toJson() => {
    'userDateAuth': userDateAuth,
    'user':user,
  };
}