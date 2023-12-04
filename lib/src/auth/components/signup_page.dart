import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/Home_page.dart';
import '../domain/user.dart';

import '../domain/user_date.dart';
import '../function/save_curent_user.dart';
import '../utility/dio_client.dart';
import 'common/custom_form_button.dart';
import 'common/custom_input_field.dart';
import 'common/page_header.dart';
import 'common/page_heading.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? profileImage;

  final _signupFormKey = GlobalKey<FormState>();

  Future _pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => profileImage = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image error: $e');
    }
  }

  final DioClient _client = DioClient();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: _signupFormKey,
              child: Column(
                children: [
                  const PageHeader(),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        const PageHeading(
                          title: 'إنشاء حساب مستخدم',
                        ),
                        SizedBox(
                          width: 130,
                          height: 130,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: profileImage != null
                                ? FileImage(profileImage!)
                                :AssetImage('',) as ImageProvider,
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: _pickProfileImage,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade400,
                                        border: Border.all(
                                            color: Colors.white, width: 3),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_sharp,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomInputField(
                            controller: fnameController,
                            labelText: 'الأسم الأول',
                            hintText: ' ادخل الأسم الأول',
                            isDense: true,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'الأسم الأول مطلوب';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomInputField(
                            controller: lnameController,
                            labelText: 'الأسم الأخير',
                            hintText: ' ادخل الأسم الأخير',
                            isDense: true,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'الأسم الأخير مطلوب';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomInputField(
                            controller: displayNameController,
                            labelText: 'اسم المستخدم',
                            hintText: 'ادخل اسم المستخدم',
                            isDense: true,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'اسم المستخدم مطلوب';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomInputField(
                            controller: emailController,
                            labelText: 'البريد الإلكتروني',
                            hintText: 'ادخل البريد الإلكتروني',
                            isDense: true,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'البريد الإلكتروني مطلوب ';
                              }
                              if (!EmailValidator.validate(textValue)) {
                                return 'البريد الإلكتروني غير صالح';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomInputField(
                          controller: passwordController,
                          labelText: 'كلمة المرور',
                          hintText: 'ادخل كلمة المرور',
                          isDense: true,
                          obscureText: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'كلمة المرور مطلوبة';
                            }
                            return null;
                          },
                          suffixIcon: true,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        profileImage!=null?
                        CustomFormButton(
                          innerText: 'إنشاء الحساب',

                          onPressed: _handleSignupUser,
                        ):
                        CustomFormButton(
                          innerText: 'إنشاء الحساب',

                          onPressed: null,
                        ),

                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'لدي حساب بالفعل ؟ ',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff939393),
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()))
                                },
                                child: const Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _handleSignupUser() async {
    // signup user
    if (_signupFormKey.currentState!.validate()) {

      User user = User(
          LastName: lnameController.text,
         FirstName:  fnameController.text,
          DisplayName: displayNameController.text,
          Password:  passwordController.text,
          Email:  emailController.text,
          ProfilePicture:profileImage as File
         );


      UserDateAuth? res = await _client.createUser(user: user);
      if (res == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('جاري  انشاءالحساب ')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم انشاء الحساب')),

        );
 await     saveCurrentUser(res);
 await       saveLoginUser(true);
  await      _client.SetUrlImage();

 // await SaveImage(user.ProfilePicture);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home_page()));

      }
    }

  }

}
