import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:news_app/src/api_news_custom/Author/widget/card_post.dart';
import 'package:news_app/src/auth/domain/User_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../auth/function/save_curent_user.dart';
import '../../auth/utility/Datanews.dart';
import '../../auth/utility/db_user.dart';
import '../../auth/utility/dio_client.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyPostsState();
}



class _MyPostsState extends State<MyPosts> {
  DBUser _dbUser = DBUser();
  String url='';
  String displayname='';
  final DioClient _client = DioClient();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }
  Future<void> getImage() async {
   UserProfile userProfile= await    _client.getProfileAuthor() as UserProfile;
    setState(() {
      url=userProfile.profilePicture;
      displayname=userProfile.displayName;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('منشوراتي'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {

              Get.offAndToNamed('/AddPost');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 15,left: 2,bottom: 15),
                  width: 230.sp,
                  height: 50,
                  decoration: BoxDecoration(border: Border.all(color: Colors.blue,width: 1.5),
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '...بماذا تفكر',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,

                    ),
                  ),
                ),
                CircleAvatar(
maxRadius: 30,
                  //    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  backgroundImage:CachedNetworkImageProvider( getUrlImage(url)) ,
                ),
              ],
            ),

          ),
          FutureBuilder<List?>(
            future: _dbUser.getNews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
              //  print(snapshot.data);
                final articles = snapshot.data! as List<Article>;
                List<Article> articles1=articles.where((element) => element.authorDisplayName==displayname).toList();

                return CardPost(

                  articles: articles1  as List<Article>,
                );
              }

              /// handles others as you did on question
              else {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 200,),
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
          //
          // FutureBuilder<List?>(
          //   future: _dbUser.getNews(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       print(snapshot.data);
          //       final articles = snapshot.data! as List<Article>;
          //
          //       return Expanded(
          //         child: ListView.builder(
          //           scrollDirection: Axis.vertical,
          //           physics: AlwaysScrollableScrollPhysics(),
          //           shrinkWrap: true,
          //           itemCount: articles.length,
          //           itemBuilder: (context, index) {
          //             final article = articles[index];
          //
          //             return CardPost(
          //               id: article.id.toString(),
          //               image: article.profilePicture,
          //               urlimage: article.images[0],
          //               date: article.publishDate,
          //               description: article.content,
          //               name: article.authorDisplayName,
          //               countComment: article.comments.length.toString(),
          //               countLike: article.likes.length.toString(),
          //               title: article.title,
          //               Comments: article.comments,
          //               Likes: article.likes,
          //             );
          //           },
          //         ),
          //       );
          //     }
          //
          //     /// handles others as you did on question
          //     else {
          //       return Center(
          //         child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: <Widget>[
          //               SizedBox(height: 200,),
          //               SizedBox(
          //                 child: CircularProgressIndicator(),
          //                 width: 60,
          //                 height: 60,
          //               )
          //             ]),
          //       );
          //     }
          //   },
          // )

        ],
      ),
    );
  }


}
