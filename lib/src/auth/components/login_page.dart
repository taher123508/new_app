import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/src/auth/components/signup_page.dart';

import '../../../Home_page.dart';
import '../domain/user_date.dart';
import '../function/save_curent_user.dart';
import '../utility/dio_client.dart';
import 'common/custom_form_button.dart';
import 'common/custom_input_field.dart';
import 'common/page_header.dart';
import 'common/page_heading.dart';
import 'forget_password_page.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String userType = 'user';
  final DioClient _client = DioClient();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffEEF1F3),
          body: Column(
            children: [
              const PageHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                  ),
                  child: SingleChildScrollView(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            const PageHeading(title: 'تسجيل الدخول',),
                            CustomInputField(
                              labelText: 'البريد الالكتروني',
                              hintText: 'ادخل البريد الالكتروني',
                              controller: emailController,
                              validator: (textValue) {
                                if(textValue == null || textValue.isEmpty) {
                                  return 'البريد الالكتروني مطلوب';
                                }
                                if(!EmailValidator.validate(textValue)) {
                                  return 'البريد الالكتروني غير صالح ';
                                }
                                return null;
                              }
                            ),
                            const SizedBox(height: 16,),
                            CustomInputField(
                              labelText: 'كلمة المرور',
                              controller: passwordController,
                              hintText: 'ادخل كلمة المرور',
                              obscureText: true,
                              suffixIcon: true,
                              validator: (textValue) {
                                if(textValue == null || textValue.isEmpty||textValue.length<2) {
                                  return 'كلمة المرور مطلوبة';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16,),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Radio(
                                  value: 'admin',
                                  groupValue: userType,
                                  onChanged: (value) {
                                    setState(() {
                                      userType = value!;
                                    });
                                  },
                                ),
                                Text('مدير'),
                                SizedBox(width: 16),
                                Radio(
                                  value: 'user',
                                  groupValue: userType,
                                  onChanged: (value) {
                                    setState(() {
                                      userType = value!;
                                    });
                                  },
                                ),
                                Text('مستخدم'),
                                SizedBox(width: 16),
                                Radio(
                                  value: 'auther',
                                  groupValue: userType,
                                  onChanged: (value) {
                                    setState(() {
                                      userType = value!;
                                    });
                                  },
                                ),
                                Text('كاتب'),
                              ],
                            ),  const SizedBox(height: 16,),
                            // Container(
                            //   width: size.width * 0.80,
                            //   alignment: Alignment.centerRight,
                            //   child: GestureDetector(
                            //     onTap: () => {
                            //       Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordPage()))
                            //     },
                            //     child: const Text(
                            //       'Forget password?',
                            //       style: TextStyle(
                            //         color: Color(0xff7d8ae7),
                            //         fontSize: 13,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(height: 20,),
                            CustomFormButton(innerText: 'دخول', onPressed: _handleLoginUser,),
                            const SizedBox(height: 18,),
                            SizedBox(
                              width: size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('اذا كنت لا تملك حساب ؟', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                                  GestureDetector(
                                    onTap: () => {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  SignupPage()))
                                    },
                                    child: const Text('انشاء حساب', style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Future<void> _handleLoginUser() async {
    // login user
    if (_loginFormKey.currentState!.validate()) {
      print(emailController.text);
      print(passwordController.text);
      print(userType);
      UserDateAuth? res;
      if(userType=='user'){

         res = await _client.loginUser(email: emailController.text, password: passwordController.text);
      }
      else if(userType=='auther')
        {

           res = await _client.loginAuthor(email: emailController.text, password: passwordController.text);

        }
      else if(userType=='admin')
      {

        res = await _client.loginAdmin(email: emailController.text, password: passwordController.text);

      }

      if (res == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('جاري  تسجيل الدخول   ')),
        );
      }
       if (res!=null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم  تسجيل  الدخول')),
        );
    await     saveCurrentUser(res);
        await       saveLoginUser(true);
        await _client.SetUrlImage();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home_page()));
      }

    }

  }
}
