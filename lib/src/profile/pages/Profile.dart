import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/Home_page.dart';
import 'package:news_app/src/auth/domain/User_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/components/common/custom_form_button.dart';
import '../../auth/components/common/custom_input_field.dart';
import '../../auth/components/common/page_header.dart';
import '../../auth/components/common/page_heading.dart';
import '../../auth/components/login_page.dart';
import '../../auth/domain/user.dart';
import '../../auth/domain/user_date.dart';
import '../../auth/function/save_curent_user.dart';
import '../../auth/utility/dio_client.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController emailController = TextEditingController();

  TextEditingController displayNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  File? profileImage;


  final _signupFormKey = GlobalKey<FormState>();

  Future _pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
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
        appBar: AppBar(title: Text('الملف الشخصي'), centerTitle: true,),
        backgroundColor: const Color(0xffEEF1F3),
        body: FutureBuilder<UserProfile?>(
          future: _client.getProfile(),
          builder:
              (BuildContext context,  snapshot) {
            if (snapshot.hasData) {


             emailController.text =  snapshot.data!.email.toString();

             displayNameController.text =  snapshot.data!.displayName.toString();

              return      SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,

                  child: Form(

                    key: _signupFormKey,
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        Column(
                          children: [
                            SizedBox(
                              width: 130,
                              height: 130,
                              child:CircleAvatar(

                                backgroundColor: Colors.grey,
                                backgroundImage:profileImage != null
                                    ? FileImage(profileImage!)
                                    :null,
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
                                            Icons.download_rounded,
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
                                controller: displayNameController,
                                labelText: 'اسم المستخدم',
                                hintText:  snapshot.data!.firstName.toString(),
                                isDense: true,
                                validator: (textValue) {
                                  if (textValue == null || textValue.isEmpty) {
                                    return 'اسم المستخدم مطلوب!';
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 16,
                            ),

                            // const SizedBox(
                            //   height: 16,
                            // ),
                            CustomInputField(
                              controller: passwordController,
                              labelText: 'كلمة المرور',
                              hintText: 'ادخل كلمة المرور',
                              isDense: true,
                              obscureText: true,
                              validator: (textValue) {
                                if (textValue == null || textValue.isEmpty) {
                                  return 'كلمة المرور مطلوبة!';
                                }
                                return null;
                              },
                              suffixIcon: true,
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            profileImage != null
                                ? CustomFormButton(
                              innerText: 'حفظ',
                              onPressed: _handleSignupUser,
                            )
                                : CustomFormButton(
                              innerText: 'حفظ',
                              onPressed: null,
                            ),


                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Center(
                child: Center(
                    child: Lottie.network(
                        'https://assets4.lottiefiles.com/packages/lf20_qmfs6c3i.json')));
          },
        ),




      ),
    );
  }

  _handleSignupUser() async {
    // signup user



        var  email= emailController.text;

    var  DisplayName=displayNameController.text;
    var  password= passwordController.text;





      var res = await _client.updateUser( userName: DisplayName, password: password,image:profileImage!, email: email );
      if (res == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('جاري الحفظ ')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم الحفظ بنجاح')),

        );
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('displayName', DisplayName);



        // await SaveImage(user.ProfilePicture);
        Navigator.of(context).pop();


      }
    }

  }


