import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
      }else{
        isLoading.value = false;
        print(jsonDecode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }


}