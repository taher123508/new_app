import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/auth/function/save_curent_user.dart';
import 'package:news_app/src/auth/utility/db_user.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Author/ShowProfileAuthor.dart';

class ShowCardAuthor extends StatefulWidget {
  final List data;

  ShowCardAuthor({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ShowCardAuthorState createState() => _ShowCardAuthorState();
}

class _ShowCardAuthorState extends State<ShowCardAuthor> {
  DBUser _dbUser = DBUser();
  String role = 'user';
  Future<void> checkUserRole() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userRole = await preferences.getString('roles'); // استبدل 'user_role' بالمفتاح الصحيح لدور المستخدم



    // استبدل 'user_role' بالمفتاح الصحيح لدور المستخدم
    setState(() {
      role = userRole!;


      // استبدل 'كاتب' بالقيمة التي تمثل دور الكاتب
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserRole();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              final report = widget.data[index];
              var bio = report['bio'].toString();
              var id = report['id'].toString();
              var profilePicture = report['profilePicture'].toString();
              var displayName = report['displayName'].toString();
              var email = report['email'].toString();
              return Container(
                child: Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            role=='User'?Text(''):   IconButton(
                              onPressed: () async {
                              bool? x=        await     _dbUser.deleteAuthor(idAuthor: id);
                                print(id);
                                print(widget.data[index]['id']);
                            if(x!)
                              setState(() {

                                widget.data.removeWhere((element) =>element['id']==int.parse(id));
                              });
                              },
                              icon: Icon(Icons.delete,color: Colors.red),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: (){

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowProfileAuthor(displayname: displayName)
                                          ),
                                        );

                                      },
                                      child: Text(
                                        displayName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      email,
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    getUrlImage(profilePicture),
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
                              ReadMoreText(
                                bio,
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
