import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/auth/function/save_curent_user.dart';
import 'package:news_app/src/auth/utility/db_user.dart';
import 'package:readmore/readmore.dart';


class ShowCategory extends StatefulWidget {
  final List data;



  ShowCategory({
    Key? key,
    required this.data,


  }) : super(key: key);

  @override
  _ShowCategoryState createState() => _ShowCategoryState();
}

class _ShowCategoryState extends State<ShowCategory> {

  DBUser _dbUser = DBUser();

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
              var     id= report['id'].toString();
              var    categoryName= report['categoryName'].toString();


              return   Container(
                child: Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () async {
                                bool? x=        await     _dbUser.deleteCategory(idCategory: id);
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
                                    Text(
                                      categoryName,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  width: 8,
                                ),

                              ],
                            ),

                          ],
                        ),

                      ),

                    ],
                  ),
                ),
              );


            }));



  }
}