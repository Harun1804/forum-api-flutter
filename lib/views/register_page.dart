import 'package:flutter/material.dart';
import 'package:forum_app/controllers/authentication.dart';
import 'package:forum_app/views/login_page.dart';
import 'package:forum_app/views/widget/input_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  String? _nameError;
  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _passwordConfirmationError;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Register Page",
                  style: GoogleFonts.poppins(fontSize: size * 0.080)),
              const SizedBox(
                height: 30,
              ),
              InputWidget(
                hintText: 'Name',
                obscureText: false,
                controller: _nameController,
                errorText: _nameError,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Username',
                obscureText: false,
                controller: _usernameController,
                errorText: _usernameError,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
                errorText: _emailError,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Password',
                obscureText: true,
                controller: _passwordController,
                errorText: _passwordError,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Password Confirmation',
                obscureText: true,
                controller: _passwordConfirmationController,
                errorText: _passwordConfirmationError,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15)),
                  onPressed: () async {
                    Map<String, List<String>>? errors = await _authenticationController.register(
                        name: _nameController.text.trim(),
                        username: _usernameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        passwordConfirmation:
                            _passwordConfirmationController.text.trim());

                    setState(() {
                      _nameError = errors?['name']?.join(', ');
                      _usernameError = errors?['username']?.join(', ');
                      _emailError = errors?['email']?.join(', ');
                      _passwordError = errors?['password']?.join(', ');
                      _passwordConfirmationError = errors?['password_confirmation']?.join(', ');
                    });
                  },
                  child: Obx(() {
                    return _authenticationController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            'Register',
                            style: GoogleFonts.poppins(
                                fontSize: size * 0.040,
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                          );
                  })),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => const LoginPage());
                  },
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(fontSize: size * 0.040),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
