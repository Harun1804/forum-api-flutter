import 'package:flutter/material.dart';
import 'package:forum_app/views/widget/post_data.dart';
import 'package:forum_app/views/widget/post_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/post_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Forum App",
          style: GoogleFonts.poppins(
              fontSize: size * 0.040,
              textStyle: const TextStyle(
                  color: Colors.white
              )
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostField(
                hintText: "What's on your mind?",
                controller: _textEditController,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text('POST',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    textStyle: const TextStyle(
                      color: Colors.white
                    )
                  ),
                )
              ),
              const SizedBox(height: 20),
              const Text("POSTS"),
              const SizedBox(height: 10),
              Obx(() {
                  return _postController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _postController.posts.value.length,
                          itemBuilder: (context, index) {
                            return const PostData(
                              post: _postController.posts.value,
                            );
                          }
                      );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
