import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/api_news_custom/Author/Edit_post.dart';
import 'package:news_app/src/auth/function/save_curent_user.dart';
import 'package:news_app/src/auth/utility/Datanews.dart';
import 'package:news_app/src/auth/utility/db_user.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_news_custom/widget/showComments.dart';
import '../../../api_news_custom/widget/showLikes.dart';
import 'Comment_mypost.dart';

class CardPost extends StatefulWidget {
  final List<Article> articles;

  CardPost({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  _CardPostState createState() => _CardPostState();
}

class _CardPostState extends State<CardPost> {
  bool isLike = false;
  DBUser _dbUser = DBUser();
  String role = 'user';
  String? iduser;

  @override
  void initState() {
    super.initState();
    inti();
    checkUserRole();
  }

  Future<void> checkUserRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userRole = await preferences
        .getString('roles'); // استبدل 'user_role' بالمفتاح الصحيح لدور المستخدم
    String? iduser1 = await preferences
        .getString('id'); // استبدل 'user_role' بالمفتاح الصحيح لدور المستخدم
    setState(() {
      role = userRole!;
      iduser = iduser1;
      // استبدل 'كاتب' بالقيمة التي تمثل دور الكاتب
    });
  }

  Future<void> inti() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    isLike =
        widget.articles[0].likes.any((like) => like.userId == int.parse(id!));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.articles.length,
            itemBuilder: (context, index) {
              final article = widget.articles[index];
              DateTime dateTime = DateTime.parse(article.publishDate);
              String formattedTime = DateFormat.jm().format(dateTime);
              String countLike = article.likes.length.toString();
              // id: article.id.toString(),
              //         image: article.profilePicture,
              //         urlimage: article.images[0],
              //         date: article.publishDate,
              //         description: article.content,
              //         name: article.authorDisplayName,
              //         countComment: article.comments.length.toString(),
              //         countLike: article.likes.length.toString(),
              //         title: article.title,
              //         Comments: article.comments,
              //         Likes: article.likes,
              //         article: articles,

              return Container(
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
                                    Text(
                                      article.authorDisplayName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                article.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              ReadMoreText(
                                article.content,
                                trimLines: 2,
                                preDataTextStyle:
                                    TextStyle(fontWeight: FontWeight.w500),
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
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
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
                                    width: 2, // سمك الحاشية
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CommentMypost(
                                                      comments:
                                                          article.comments));
                                        },
                                        icon: Icon(Icons.comment)),
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
                                    width: 2.0, // سمك الحاشية
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          bool? x = await _dbUser.deleteArticle(
                                              idArtcle: article.id.toString());
                                          if (x!) {
                                            setState(() {
                                              widget.articles.removeWhere(
                                                  (element) =>
                                                      element.id == article.id);
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.delete_outline_sharp)),
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
                                    width: 2.0, // سمك الحاشية
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => EditPost(articlesList: article ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit),
                                        color: Colors.black),
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
