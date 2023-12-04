import 'package:flutter/material.dart';
import 'package:news_app/src/auth/utility/Datanews.dart';

import '../../../auth/utility/db_user.dart';

class CommentMypost extends StatefulWidget {
  final List<Comment> comments;



  CommentMypost({
    required this.comments,



  });

  @override
  State<CommentMypost> createState() => _CommentMypostState();
}

class _CommentMypostState extends State<CommentMypost> {
  TextEditingController commentlController = TextEditingController();

  DBUser _dbUser = DBUser();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.comments.map((comment) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(comment.userProfilePicture),
              ),
              title: Text(comment.userDisplayName),
              subtitle: Text(comment.commentText),trailing: IconButton(icon: Icon(Icons.delete),onPressed: () async {
              bool? x=        await   _dbUser.deleteComment(idArticle: comment.articleId.toString(),idComment: comment.id.toString());
              if(x==true){
                setState(() {
                  widget.comments.removeWhere((element) => element.id==comment.id);
                });}





            }),
            );
          }).toList(),
        ),
      ),

    );

  }
}