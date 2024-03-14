import 'dart:convert';

import 'package:forum_app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController
{
  final isLoading = false.obs;

  Future register({
    required String name,
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      };

      var response = await http.post(
          Uri.parse("$url/auth/register"),
          headers: {
            'Accept': 'application/json'
          },
          body: data
      );

      if (response.statusCode == 201){
        isLoading.value = false;
        print(jsonDecode(response.body));
      }else if(response.statusCode == 422) {
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