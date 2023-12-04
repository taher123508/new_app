import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/auth/function/save_curent_user.dart';
import 'package:news_app/src/auth/utility/Datanews.dart';
import 'package:news_app/src/auth/utility/db_user.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_news_custom/Author/ShowProfileAuthor.dart';
import '../../../api_news_custom/widget/showComments.dart';
import '../../../api_news_custom/widget/showLikes.dart';

class PersonCard extends StatefulWidget {

  final List<Article> articles;

  PersonCard({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  _PersonCardState createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {

  DBUser _dbUser = DBUser();
  String role = 'user';
  String? iduser;
  String? dispalyuser;
  String? imageurluser;
  @override
  void initState() {
    super.initState();

    checkUserRole();
  }




  Future<void> checkUserRole() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userRole = await preferences.getString('roles'); // استبدل 'user_role' بالمفتاح الصحيح لدور المستخدم
    String? iduser1 = await preferences.getString('id');
    String? imageurluser1 = await preferences.getString('image');
    String? displayuser1 = await preferences.getString('displayName');
    
    
    // استبدل 'user_role' بالمفتاح الصحيح لدور المستخدم
    setState(() {
      role = userRole!;
      iduser=iduser1;
      dispalyuser=displayuser1;
      imageurluser=imageurluser1;
      
      // استبدل 'كاتب' بالقيمة التي تمثل دور الكاتب
    });
  }


  @override
  Widget build(BuildContext context) {


      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:widget.articles.length,
          itemBuilder: (context, index) {
            final article =widget. articles[index];
            DateTime dateTime = DateTime.parse(article.publishDate);
            String formattedTime = DateFormat.jm().format(dateTime);
            bool isLike=false;

              isLike    =  article.likes.any((like) => like.userId == int.parse(iduser!));


          return    Container(
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                InkWell(

                                  onTap: (){

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ShowProfileAuthor(displayname: article.authorDisplayName,)
                                      ),
                                    );

                                  },
                                  child: Text(
                                    article.authorDisplayName,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  formattedTime,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(

                                getUrlImage(article.profilePicture),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Text(
                            article.title,textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          ReadMoreText(
                            article.content,
                            trimLines: 2,
                            preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                            style: TextStyle(color: Colors.black),
                            colorClickableText: Colors.blue,
                            trimMode: TrimMode.Line,
                            textAlign: TextAlign.center,
                            trimCollapsedText: 'عرض أكثر',
                            trimExpandedText: ' عرض أقل',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CachedNetworkImage(
                            imageUrl: getUrlImage(article.images[0]),
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),

                        ],
                      ),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.blue.shade100, // لون الحاشية
                                width: 1.0, // سمك الحاشية
                              ),),
                            child: Row(
                              children: [

                                TextButton(
                                    child: Text(article.comments.length.toString() + ' تعليق '),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => CommentDialog(
                                          role: role,
                                          comments: article.comments,
                                          idArticle: article.id.toString(),
                                          idUser: iduser!,
                                        ),
                                      );
                                    }),
                                IconButton(
                                    onPressed: ()  {

                                      showDialog(
                                          context: context,
                                          builder: (context) => CommentDialog(role: role,
                                            comments: article.comments,
                                            idArticle: article.id.toString(),
                                            idUser: iduser!,
                                          ));
                                    },
                                    icon: Icon(Icons.comment_rounded)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.blue.shade100, // لون الحاشية
                                width: 1.0, // سمك الحاشية
                              ),),
                            child: Row(
                              children: [

                                role=='Admin'?   Text(''):TextButton(
                                    child: Text(article.likes.length.toString() + ' أحببته'),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => LikeDialog(
                                          likes: article.likes,
                                        ),
                                      );
                                    }),
                                role=='Admin'?IconButton(onPressed: () async {

                                  print(article.id);

bool?x=await _dbUser.deleteArticle(idArtcle:article.id.toString() );
if(x!){
  setState(() {
    widget.articles.removeWhere((element) =>
    element.id==article.id

    );
  });

}



                                }, icon: Icon(Icons.delete))   :IconButton(
                                    onPressed: role=='User'?  () async {

                                      setState(() {

                                         isLike = !isLike;
                                      });
                                      if (isLike) {
                                        print(' like');
                                        await _dbUser.setLike(article.id.toString());
                                        setState(() {

                                          article.likes.add(Like( articleId: article.id,
                                              
                                              userId:int.parse(iduser!) , userDisplayName: dispalyuser!,
                                              userProfilePicture: imageurluser!));
                                         // countLike =
                                         //      (int.parse(countLike) + 1)
                                         //          .toString();
                                        });


                                      } else {
                                        print('not like');
                                        await _dbUser.deleteLike(article.id.toString(), article.likes);
                                        setState(() {
                                      article.likes.removeWhere((element) => element.userId==int.parse(iduser!));
                                          
                                          
                                        });

                                      }
                                    }:(){},
                                    icon: Icon(Icons.favorite),
                                    color: isLike ? Colors.red : Colors.black),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
          }));






  }
}