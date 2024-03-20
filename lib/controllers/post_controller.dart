import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:forum_app/constants/constants.dart';
import '../models/post_model.dart';

class PostController extends GetxController
{
  Rx<List<Result>> posts = Rx<List<Result>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(
        Uri.parse("$url/feeds"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var jsonData = jsonDecode(response.body)['result'] as List;
        posts.value = jsonData.map((e) => Result.fromJson(e)).toList();
      } else {
        isLoading.value = false;
        print(jsonDecode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future getPost({ required postId }) async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(
        Uri.parse("$url/feeds/$postId"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var jsonData = jsonDecode(response.body)['result'] as List;
        posts.value = jsonData.map((e) => Result.fromJson(e)).toList();
      } else {
        isLoading.value = false;
        print(jsonDecode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPost({required String content}) async {
    var data = {
      'content': content
    };

    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse("$url/feeds"),
        headers: {
          'Accept': 'application',
          'Authorization': 'Bearer ${box.read('token')}'
        },
        body: data
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          jsonDecode(response.body)['meta']['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white
        );
      } else if(response.statusCode == 422) {
        isLoading.value = false;
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Map<String, List<String>> result = {};
        Map<String, dynamic> errors = jsonResponse['result'];
        errors.forEach((key, value) {
          result[key] = List<String>.from(value);
        });

        return result;
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future likePost({ required postId }) async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(
        Uri.parse("$url/feeds/$postId/like"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar(
            'Success',
            jsonDecode(response.body)['meta']['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white
        );
      } else {
        isLoading.value = false;
        print(jsonDecode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createComment({ required postId, required String body }) async {
    var data = {
      'body': body
    };

    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse("$url/feeds/$postId/comment"),
          headers: {
            'Accept': 'application',
            'Authorization': 'Bearer ${box.read('token')}'
          },
          body: data
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar(
            'Success',
            jsonDecode(response.body)['meta']['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white
        );
      } else if(response.statusCode == 422) {
        isLoading.value = false;
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Map<String, List<String>> result = {};
        Map<String, dynamic> errors = jsonResponse['result'];
        errors.forEach((key, value) {
          result[key] = List<String>.from(value);
        });

        return result;
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}