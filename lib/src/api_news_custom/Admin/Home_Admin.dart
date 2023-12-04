import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../auth/function/save_curent_user.dart';
import '../../livel_channels/presentation/screens/home_live.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            String? displayName = snapshot.data!.getString('displayName');
            String? url= snapshot.data!.getString('image' );
            String? email= snapshot.data!.getString('email');

            return    ListView(
              padding: const EdgeInsets.all(0),
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(

                    color: Colors.blue,

                  ), //BoxDecoration
                  child: UserAccountsDrawerHeader(

                    decoration: BoxDecoration(color: Colors.blue),
                    accountName: Text(
                      'Admin',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    margin: EdgeInsets.only(top: 0),

                    accountEmail: Text(email!),
                    currentAccountPictureSize: Size.square(60),
                    currentAccountPicture: CircleAvatar(

                      //    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                      backgroundImage: NetworkImage(url!) as ImageProvider,
                    ), //circleAvatar
                  ), //UserAccountDrawerHeader
                ), //DrawerHeader
                ListTile(
                  leading: const Icon(Icons.live_tv_outlined,color: Colors.red,),
                  title: const Text(' بث حي '),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeLive()));

                  },
                ),
                ListTile(
                  leading: const Icon(Icons.newspaper_rounded),
                  title: const Text(' أخبار عالمية '),
                  onTap: () {
                    Get.offAndToNamed('/homeNews');
                  },
                ),

                // ListTile(
                //   leading: const Icon(Icons.person),
                //   title: const Text(' الملف الشخصي '),
                //   onTap: () {
                //     Get.offAndToNamed('/ProfilePage');
                //   },
                // ),

                Divider(),
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text(' تقارير عن المستخدمين '),
                  onTap: () {
                    Get.offAndToNamed('/ReportUsers');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.report_gmailerrorred),
                  title: const Text(' تقارير عن الكتاب '),
                  onTap: () {
                    Get.offAndToNamed('/ReportAuthors');
                  },
                ),
                Divider(),
                ListTile(
                  leading: const Icon(Icons.add_circle),
                  title: const Text(' إضافة كاتب '),
                  onTap: () {
                    Get.offAndToNamed('/AddAuthor');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_comment),
                  title: const Text('  الاصناف '),
                  onTap: () {
                    Get.offAndToNamed('/AddCategory');
                  },
                ),
                Divider(),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('  كتاب '),
                  onTap: () {
                    Get.offAndToNamed('/ShowAuthors');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete_forever),
                  title: const Text('  مستخدمين '),
                  onTap: () {
                    Get.offAndToNamed('/ShowUsers');
                  },
                ),
                Divider(),

                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('تسجيل خروج'),
                  onTap: () {
                    LogOutUser();
                    Get.offAndToNamed('/splashScreen');
                  },
                ),
              ],
            );
          }

          return Center(
              child: Center(
                  child: Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_qmfs6c3i.json')));
        },
      ),




    );
  }
}
