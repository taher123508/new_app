
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';


import '../../auth/components/common/custom_form_button.dart';
import '../../auth/components/common/custom_input_field.dart';

import '../../auth/utility/Datanews.dart';
import '../../auth/utility/db_user.dart';
import '../../auth/utility/dio_client.dart';

class EditPost extends StatefulWidget {

  final Article articlesList;
   EditPost({Key? key, required this.articlesList}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  List values= [
    {"id": 1, "categoryName": "رياضة"},
    {"id": 2, "categoryName": "سياسي"},
    {"id": 3, "categoryName": "عسكري"},

  ] ;

  // القيمة المحددة افتراضيًا
  int selectedValue = 1;

  final _signupFormKey = GlobalKey<FormState>();


  final DBUser  dbUser  = DBUser();
  final DioClient _client = DioClient();
  File? profileImage;
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
  @override
  void initState() {
    super.initState();
    getCategory();
  }


  Future<void> getCategory() async {
    var data=await  dbUser.getCategory();
    setState(() {
      print(data);
      values=data! ;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    contentController.text =widget.articlesList.content;
    titleController.text = widget.articlesList.title;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('تعديل خبر'),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xffEEF1F3),
        body: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: _signupFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [





                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white60,
                            border: Border.all(color: Colors.blueAccent,),
                            image: profileImage != null
                                ? DecorationImage(image: FileImage(profileImage!), fit: BoxFit.cover)
                                :null
                        ),
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
                                    border: Border.all(color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Icon(
                                    Icons.file_download_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),


                      Container(
                        width: size.width * 0.9,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        child: DropdownButtonHideUnderline(

                          child: DropdownButton<String>(

                            isExpanded: true,
                            value: selectedValue.toString(), // القيمة المحددة
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue =int.parse( newValue!);

                                print(selectedValue);

                                // تحديث القيمة المحددة
                              });
                            },
                            items: values.map((value) {
                              return DropdownMenuItem<String>(
                                alignment: Alignment.centerRight,
                                value: value['id'].toString(),
                                child: Text(value['categoryName']),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),

                      CustomInputField(
                          controller: titleController,
                          labelText: 'عنوان الخبر',
                          hintText: 'ادخل عنوان الخبر',
                          isDense: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'عنوان الخبر مطلوب! ';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                          controller: contentController,
                          labelText: 'الخبر ',
                          hintText: 'ادخل  الخبر ',
                          isDense: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'الخبر  مطلوب!';
                            }
                            return null;
                          }),

                      const SizedBox(
                        height: 16,
                      ),

                      profileImage != null
                          ? CustomFormButton(
                        innerText: 'تعديل',
                        onPressed: _handleSignupUser,
                      )
                          : CustomFormButton(
                        innerText: 'تعديل',
                        onPressed: null,
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
      var tilte = titleController.text;
      var content = contentController.text;

print(widget.articlesList.id.toString());
print(tilte);
print(content);

      var res = await _client.editPost(
          title: tilte,
          content: content,
          categoryid: selectedValue.toString(),
        idArticle: widget.articlesList.id.toString(),
        image: profileImage!
          );
      if (res == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('جاري التعديل ')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم التعديل بنجاح')),
        );

        // await SaveImage(user.ProfilePicture);
        Get.offAndToNamed('/MyPosts');
      }
    }
  }
}
