import 'package:flutter/material.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:forum_app/views/post_detail_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/post_controller.dart';

class PostData extends StatefulWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final Result post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.post.user!.name!,
            style: GoogleFonts.poppins(
                fontSize: 12,
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold
                )
            ),
          ),
          Text(widget.post.user!.email!,
              style: GoogleFonts.poppins(
                  fontSize: 10,
                  textStyle: const TextStyle(
                      color: Colors.grey
                  )
              )
          ),
          const SizedBox(
            height: 10,
          ),
          Text(widget.post.content!,
              style: GoogleFonts.poppins(
                  fontSize: 10,
                  textStyle: const TextStyle(
                      color: Colors.black
                  )
              )
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await _postController.likePost(postId: widget.post.id!);
                    await _postController.getAllPosts();
                  },
                  icon: Icon(Icons.thumb_up)
              ),
              Text(widget.post.likesCount.toString()),
              IconButton(
                  onPressed: () {
                    Get.to(() => PostDetail(
                      post: widget.post,
                    ));
                  },
                  icon: const Icon(Icons.comment)
              ),
              Text(widget.post.commentsCount.toString())
            ],
          )
        ],
      ),
    );
  }
}