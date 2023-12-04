import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/src/auth/domain/User_profile.dart';
import 'package:news_app/src/auth/utility/Datanews.dart';
import '../../auth/function/save_curent_user.dart';
import '../../auth/utility/db_user.dart';
import '../../auth/utility/dio_client.dart';

class CommentDialog extends StatefulWidget {
  final List<Comment> comments;
  final String role;
  final String idArticle;
  final String idUser;

  CommentDialog({
    required this.comments,
    required this.role,
    required this.idArticle,
    required this.idUser,
  });

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  TextEditingController commentlController = TextEditingController();

  DBUser dbuser = DBUser();




  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.comments.map((comment) {
            return ListTile(
              leading: widget.role == 'Admin'
                  ? IconButton(icon: Icon(Icons.delete), onPressed: () async {

                bool? x=        await   dbuser.deleteComment(idArticle: widget.idArticle,idComment: comment.id.toString());
                if(x==true){
                  setState(() {
                    widget.comments.removeWhere((element) => element.id==comment.id);
                  });}
              })
                  : comment.userId == int.parse(widget.idUser)
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            print(comment.id);


          await   dbuser.deleteComment(idArticle: widget.idArticle,idComment: comment.id.toString());

setState(() {
  widget.comments.removeWhere((element) => element.id==comment.id);
});
                          },
                        )
                      : Text(''),
              title: Text(comment.userDisplayName),
              subtitle: Text(comment.commentText),
              trailing: CircleAvatar(
                backgroundImage:
                    NetworkImage(getUrlImage(comment.userProfilePicture)),
              ),
            );
          }).toList(),
        ),
      ),
      actions: widget.role == 'User'
          ? [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentlController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: '...اكتب تعليقك هنا',
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    TextButton(
                      onPressed: () async {
                   await dbuser.setComment(
                            widget.idArticle, commentlController.text);


                       DioClient _client = DioClient();
                      UserProfile  userprofile   = await _client.getProfile() as UserProfile ;

                          setState(() {


                            widget.comments.add(Comment(
                                articleId:int.parse(widget.idArticle) ,
                                userId: int.parse(widget.idUser) ,
                                commentText: commentlController.text,
                                userDisplayName: userprofile.displayName,
                                userProfilePicture:userprofile.profilePicture.toString()));
                            commentlController.text='';

                          });


                      },
                      child: Text('أرسل'),
                    ),
                  ],
                ),
              ),
            ]
          : [],
    );
  }
}
