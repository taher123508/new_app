import 'package:flutter/material.dart';
import 'package:news_app/src/api_news_custom/Admin/widget/ShowCategory.dart';

import '../../../Home_page.dart';
import '../../auth/components/common/custom_form_button.dart';
import '../../auth/components/common/custom_input_field.dart';
import '../../auth/utility/db_user.dart';
import '../../auth/utility/dio_client.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  DBUser _dbUser = DBUser();
  TextEditingController categoryController = TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(' الأصناف'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(25)),
            margin: EdgeInsets.all(8),
            child: Form(
              key:_signupFormKey ,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.3,
                      child: CustomFormButton(
                        innerText: 'اضافة ',
                        onPressed: _handleSignupUser,
                      ),
                    ),
                    Container(
                      child: CustomInputField(
                          controller: categoryController,
                          labelText: 'اسم التصنيف',
                          hintText: 'ادخل اسم التصنيف',
                          isDense: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'اسم التصنيف مطلوب';
                            }
                            return null;
                          }),
                      height: size.height * 0.15,
                      width: size.width * 0.6,
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          FutureBuilder<List?>(
            future: _dbUser.getCategory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                List categories = snapshot.data!;

                return ShowCategory(data: categories);
              }

              /// handles others as you did on question
              else {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                        ),
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        )
                      ]),
                );
              }
            },
          )
        ],
      ),
    );
  }

  _handleSignupUser() async {
    // signup user
    if (_signupFormKey.currentState!.validate()) {
      var nameCat = categoryController.text;

      bool? res = await _dbUser.addCategoey(nameCat.toString());
      if (res == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('جاري اضافة الصنف ')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم اضافة الصنف')),
        );

        // await SaveImage(user.ProfilePicture);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home_page()));
      }
    }
  }
}
