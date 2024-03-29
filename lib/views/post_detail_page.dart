import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_controller.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:forum_app/views/home_page.dart';
import 'package:forum_app/views/widget/input_widget.dart';
import 'package:forum_app/views/widget/post_data.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.post});

  final Result post;
  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final TextEditingController _commentController = TextEditingController();
  final PostController _postController = Get.put(PostController());

  String? _bodyError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.user!.name!,
          style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            )
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PostData(post: widget.post),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(() {
                  if (_postController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else {
                    return widget.post.comments!.isEmpty
                        ? Center(
                        child: Text('No comments yet',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            )
                        )
                    )
                        : ListView.builder(
                      itemCount: widget.post.comments!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(widget.post.comments![index].name!,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          subtitle: Text(widget.post.comments![index].pivot!.body,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey
                              )
                          ),
                        );
                      },
                    );
                  }
                  }
                )
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Write a comment...',
                controller: _commentController,
                obscureText: false,
                errorText: _bodyError,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: () async {
                  Map<String, List<String>>? errors = await _postController.createComment(
                    postId: widget.post.id!,
                    body: _commentController.text.trim()
                  );

                  _commentController.clear();
                  _postController.getAllPosts();
                  Get.to(() => const HomePage());
                  setState(() {
                    _bodyError = errors?['body']?.join(', ');
                  });
                },
                child: Text("Comment",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}
