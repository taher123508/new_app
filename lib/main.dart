import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'app_routes.dart';

 void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp( ProviderScope(

    child: MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
           // textDirection: TextDirection.rtl,

            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'flutterfonts',

              primarySwatch: Colors.blue,
            ),
            initialRoute: AppRoutes.initial,
            getPages: AppRoutes.routes,

          );
        }
    );



  }
}


