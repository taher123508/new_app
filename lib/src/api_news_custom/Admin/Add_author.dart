import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/Home_page.dart';
import 'package:news_app/src/auth/components/common/page_header.dart';

import '../../auth/components/common/custom_form_button.dart';
import '../../auth/components/common/custom_input_field.dart';
import '../../auth/components/common/page_heading.dart';
import '../../auth/components/login_page.dart';
import '../../auth/domain/user.dart';
import '../../auth/domain/user_date.dart';
import '../../auth/function/save_curent_user.dart';
import '../../auth/utility/dio_client.dart';
class AddAuthor extends StatefulWidget {
  const AddAuthor({Key? key}) : super(key: key);

  @override
  State<AddAuthor> createState() => _AddAuthorState();
}

class _AddAuthorState extends State<AddAuthor> {

  TextEditingController bioController = TextEditingController();
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
        appBar: AppBar(title: Text('إنشاء حساب  كاتب'),centerTitle: true),
        backgroundColor: const Color(0xffEEF1F3),
        body: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: _signupFormKey,
              child: Column(
                children: [

                  Column(
                    children: [

                      SizedBox(
                        width: 130,
                        height: 160,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
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
                          controller: bioController,
                          labelText: 'النبذة التعريفية ',
                          hintText: ' ادخل النبذة التعريفية',
                          isDense: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'النبذة التعريفية مطلوبة';
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
                        height: 30,
                      ),
                    ],
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


        var  bio= bioController.text;
    var   DisplayName= displayNameController.text;
    var   Password=  passwordController.text;
    var    Email=  emailController.text;
    var    ProfilePicture=profileImage as File;



     bool? res = await _client.createAuthor(bio: bio, userName: DisplayName, email: Email, password: Password, image: ProfilePicture);
      if (res == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('جاري الحساب ')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم انشاء الحساب')),

        );


        // await SaveImage(user.ProfilePicture);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home_page()));

      }
    }

  }

}
