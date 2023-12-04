import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LoginData {
  String email;
  String password;

  LoginData({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String apiUrl = 'https://localhost:7009/api/UserAuth/UserLogin'; // استبدل بالعنوان الصحيح ورقم المنفذ لتطبيق API.NET

    final loginData = LoginData(
      email: _emailController.text,
      password: _passwordController.text,
    );

    final dio = Dio(  BaseOptions(

        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',

        }
    ));

    try {
      final response = await dio.post(apiUrl, data: json.encode(loginData.toJson()));

      if (response.statusCode == 200) {
         print(response.data);
      } else {
        print('حدث خطأ أثناء تسجيل الدخول: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ غير متوقع: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الدخول')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'كلمة المرور'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}
