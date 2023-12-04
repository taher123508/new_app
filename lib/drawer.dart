import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/src/auth/domain/User_profile.dart';
import 'package:news_app/src/auth/function/save_curent_user.dart';
import 'package:news_app/src/auth/utility/dio_client.dart';
import 'package:news_app/src/livel_channels/presentation/screens/home_live.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:sizer/sizer.dart';

class Drawer_home extends StatelessWidget {
   Drawer_home({Key? key}) : super(key: key);
   final DioClient _client = DioClient();
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: FutureBuilder<UserProfile?>(
        future: _client.getProfile(),
        builder:
            (BuildContext context,  snapshot) {
          if (snapshot.hasData) {
            String? displayName = snapshot.data!.displayName;
          String? url= getUrlImage(snapshot.data!.profilePicture);
            String? email= snapshot.data!.email;

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
                      displayName!,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    margin: EdgeInsets.only(top: 0),

                    accountEmail: Text(email!),
                    currentAccountPictureSize: Size.square(60),
                    currentAccountPicture: CircleAvatar(

                      //    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                      backgroundImage: CachedNetworkImageProvider(url!) ,
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
                  leading: const Icon(Icons.sunny_snowing),
                  title: const Text(' الطقس '),
                  onTap: () {
                    Get.offAndToNamed('/homeWeather');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.newspaper_rounded),
                  title: const Text(' أخبار عالمية '),
                  onTap: () {
                    Get.offAndToNamed('/homeNews');
                  },
                ), ListTile(
                  leading: const Icon(Icons.search_outlined),
                  title: const Text('البحث عن كاتب '),
                  onTap: () {
                    Get.offAndToNamed('/ShowAuthors');
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(' الملف الشخصي '),
                  onTap: () {
                    Get.offAndToNamed('/ProfilePage');
                  },
                ),
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




    ); //Drawer
  }
}
