import 'dart:convert';
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
        for (var item in jsonDecode(response.body)['result']) {
          posts.value.add(Result.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(jsonDecode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}