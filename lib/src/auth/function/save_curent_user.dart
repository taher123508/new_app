import 'dart:io';

import 'package:news_app/src/auth/domain/user_date.dart';
import 'package:shared_preferences/shared_preferences.dart';


 saveCurrentUser(UserDateAuth userDateAuth) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  await preferences.setString('token', userDateAuth.token! );
  await preferences.setString('id', userDateAuth.id! );
  await preferences.setString('roles', userDateAuth.roles!);
  await preferences.setString('displayName', userDateAuth.displayName!);
  await preferences.setString('email', userDateAuth.email!);
}
Future<UserDateAuth?> getCurrentUser() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
 String? token= await preferences.getString('token');
  String? id= await preferences.getString('id');
  String? roles= await preferences.getString('roles');
  String? displayName = await preferences.getString('displayName');
  String? email= await preferences.getString('email');
UserDateAuth userDateAuth=UserDateAuth(token: token!, roles: roles!, id: id!,displayName: displayName,email: email);
return userDateAuth;
}
Future<String> getCurrentUserId() async {
 SharedPreferences preferences = await SharedPreferences.getInstance();
 String id= await preferences.getString('id')??' ';

 return id;
}
saveLoginUser( bool islogin) async {
 SharedPreferences preferences = await SharedPreferences.getInstance();
 bool login= await preferences.setBool('islogin', islogin );
 return  login==null||login==false?false:true;
}
   getLoginUser( ) async {
 SharedPreferences preferences = await SharedPreferences.getInstance();
 bool? login= await preferences.getBool('islogin');
 return  login;
}
LogOutUser( ) async {
 SharedPreferences preferences = await SharedPreferences.getInstance();
 bool login= await preferences.setBool('islogin', false );
 return  login;
}
SaveImage(String image ) async {
 SharedPreferences preferences = await SharedPreferences.getInstance();

 List<String> partname=image.split("\\");


 String imageName= 'http://newsappnew.somee.com/uploads/'+partname.last;
     bool ima= await preferences.setString('image', imageName  );
 return  ima;
}
GetImage( ) async {
 SharedPreferences preferences = await SharedPreferences.getInstance();
 String? ima= await preferences.getString('image' );

 return  ima;
}

getUrlImage(String image){
 List<String> partname=image.split("\\");


 String imageName= 'http://newsappnew.somee.com/uploads/'+partname.last;
 return imageName;
}
getnameimage(String image){
 List<String> partname=image.split("\\");


 String imageName= partname.last;
 return imageName;
}

