import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../auth/domain/User_profile.dart';
import '../../auth/function/save_curent_user.dart';
import '../../auth/utility/dio_client.dart';
import '../../livel_channels/presentation/screens/home_live.dart';

class HomeAuthor extends StatefulWidget {
  const HomeAuthor({Key? key}) : super(key: key);

  @override
  State<HomeAuthor> createState() => _HomeAuthorState();
}

class _HomeAuthorState extends State<HomeAuthor> {
  final DioClient _client = DioClient();
  String? url;
  String? displayName;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Drawer(


      child: FutureBuilder<UserProfile?>(
        future: _client.getProfileAuthor(),
        builder:
            (BuildContext context,  snapshot) {
          if (snapshot.hasData) {
                  url= snapshot.data!.profilePicture.toString();

                  displayName =  snapshot.data!.displayName.toString();
                  email =  snapshot.data!.email.toString();


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
                      'Author',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    margin: EdgeInsets.only(top: 0),

                    accountEmail: Text(email!),
                    currentAccountPictureSize: Size.square(60),
                    currentAccountPicture: CircleAvatar(

                      //    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                      backgroundImage: NetworkImage( getUrlImage(url!)) as ImageProvider,
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
                ),

                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(' الملف الشخصي '),
                  onTap: () {
                    Get.offAndToNamed('/ProfileAuthor');
                  },
                ),
                Divider(),
                ListTile(
                  leading: const Icon(Icons.newspaper_outlined),
                  title: const Text(' منشوراتي '),
                  onTap: () {
                    Get.offAndToNamed('/MyPosts');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_card_sharp),
                  title: const Text(' اضافة خبر '),
                  onTap: () {
                    Get.offAndToNamed('/AddPost');
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
