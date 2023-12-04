import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:news_app/src/auth/components/common/Card_news_display.dart';

import 'package:news_app/src/auth/utility/Datanews.dart';
import 'package:news_app/src/auth/utility/db_user.dart';
class ShowProfileAuthor extends StatefulWidget {
  final String displayname;
   ShowProfileAuthor({Key? key,required this.displayname}) : super(key: key);

  @override
  State<ShowProfileAuthor> createState() => _ShowProfileAuthorState();
}

class _ShowProfileAuthorState extends State<ShowProfileAuthor> {
  bool idLiked = false;

  DBUser _dbUser = DBUser();
  List? articles1;
  bool islood=false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('صفحة الكاتب'), centerTitle: true,

        leading: IconButton(onPressed: (){
          Get.offAndToNamed('/homePage');


        },icon: Icon(Icons.arrow_back_rounded)),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 4.0,
        onRefresh: () async {


          articles1=await  _dbUser.getNews();
          setState(()  {
            islood=true;
          });
          // Replace this delay with the code to be executed during refresh
          // and return a Future when code finishes execution.
          return Future<void>.delayed(const Duration(seconds: 2));
        },
        child: Column(
          children: [
            FutureBuilder<List?>(
              future: _dbUser.getNews(),
              builder: (context, snapshot) {
                if (snapshot.hasData&&snapshot.connectionState==ConnectionState.done) {
                  print(snapshot.data);
                  var   articles = snapshot.data! as List<Article>;
                  articles  =articles.where((element) => element.authorDisplayName==widget.displayname).toList();
                  return PersonCard(

                    articles: articles ,
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
          ],
        ),
      ),
    );
  }

}


