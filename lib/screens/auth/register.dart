import 'package:flutter/material.dart';
import 'package:todo_c13_sun/firebase/firebase_manager.dart';
import 'package:todo_c13_sun/screens/login/login_screen.dart';

import '../home/home.dart';
import '../lets_go_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "registerScreen";
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/images/login_image.png',
                  height: 150,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is Required";
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "email is Required";
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                        .hasMatch(value);

                    if (emailValid == false) {
                      return "Email Not valid";
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is Required";
                    }
                    if (value.length < 6) {
                      return "Password should be at least 6 Char";
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: rePasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "RePassword is Required";
                    }
                    if (value.length < 6) {
                      return "Password should be at least 6 Char";
                    }
                    if (value != passwordController.text) {
                      return "Password doesn't match";
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: "rePassword",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility_off_outlined),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseManager.createAccount(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          () {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                backgroundColor: Colors.transparent,
                                title:
                                    Center(child: CircularProgressIndicator()),
                              ),
                            );
                          },
                          () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginScreen.routeName,
                              (route) => false,
                            );
                          },
                          (message) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Something went wrong"),
                                content: Text(message),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"))
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: const Color(0xFF5669FF)),
                    child: Text(
                      "Create Account",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    )),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Already Have Account? ",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                        ),
                        TextSpan(
                            text: "Login",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  decoration: TextDecoration.underline,
                                )!),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
