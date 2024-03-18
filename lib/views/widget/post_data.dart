import 'package:flutter/material.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:google_fonts/google_fonts.dart';

class PostData extends StatelessWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final Result post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.user!.name!,
            style: GoogleFonts.poppins(
                fontSize: 12,
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold
                )
            ),
          ),
          Text(post.user!.email!,
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
          Text(post.content!,
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
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up)
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.comment)
              ),
            ],
          )
        ],
      ),
    );
  }
}