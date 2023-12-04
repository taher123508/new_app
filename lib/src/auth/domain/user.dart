

import 'dart:io';

class User {
  String FirstName;
  String LastName;
  String DisplayName;
  String Password;
  String Email;
  File ProfilePicture;


  User({
      required this.FirstName,
      required this.LastName,
      required this.DisplayName,
      required this.Password,
      required this.Email,
      required this.ProfilePicture,
  }); // User({required this.lname, required this.fname, required this.username,
  //   required this.password, required this.email,
  //   required this.urlimage, required this.type, this.token}); // now create converter

 factory User.fromJson(Map<String,dynamic> responseData){
   return User(

     LastName: responseData['LastName'],
     FirstName: responseData['FirstName'],
     Email: responseData['Email'],
      Password : responseData['Password'],
     DisplayName:  responseData['DisplayName'],
     ProfilePicture: responseData['ProfilePicture'],



   );
 }

  Map<String, dynamic> toJson() => {
        'LastName':LastName ,
        'FirstName': FirstName,
        'Email': Email,
        'DisplayName': DisplayName,
        'Password': Password,
        'ProfilePicture': ProfilePicture,

      };
}