import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/auth/utility/Datanews.dart';

import '../../auth/function/save_curent_user.dart';

class LikeDialog extends StatelessWidget {
  final List<Like> likes;


  LikeDialog({
    required this.likes,

  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: likes.map((like) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                CachedNetworkImageProvider(
                 getUrlImage(like.userProfilePicture),


                ),

              ),
              title: Text(like.userDisplayName),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}