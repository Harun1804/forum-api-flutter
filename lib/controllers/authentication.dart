import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forum_app/constants/constants.dart';
import 'package:forum_app/views/home.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController
{
  final isLoading = false.obs;
  final token = ''.obs;

  final box = GetStorage();

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
        Get.snackbar(
          'success',
          jsonDecode(response.body)['meta']['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
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

  Future login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'username': username,
        'password': password
      };

      var response = await http.post(
          Uri.parse("$url/auth/login"),
          headers: {
            'Accept': 'application/json'
          },
          body: data
      );

      if (response.statusCode == 200){
        isLoading.value = false;
        token.value = jsonDecode(response.body)['result']['token'];
        box.write('token', token.value);
        Get.offAll(() => const HomePage());
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