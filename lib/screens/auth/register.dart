import 'package:animated_toggle_switch/animated_toggle_switch.dart' show AnimatedToggleSwitch, ToggleStyle;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:todo_c13_sun/firebase/firebase_manager.dart';
import 'package:todo_c13_sun/screens/login/login_screen.dart';

import '../../providers/my_provider.dart' show MyProvider;


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
    var myProvider = Provider.of<MyProvider>(context);
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
                      return "Name is Required".tr();
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration:  InputDecoration(
                    hintText: "Name".tr(),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is Required".tr();
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                        .hasMatch(value);

                    if (emailValid == false) {
                      return "Email Not valid".tr();
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration:  InputDecoration(
                    hintText: "Email".tr(),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is Required".tr();
                    }
                    if (value.length < 6) {
                      return "Password should be at least 6 Char".tr();
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration:  InputDecoration(
                    hintText: "Password".tr(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: const Icon(Icons.visibility),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: rePasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "RePassword Is Required".tr();
                    }
                    if (value.length < 6) {
                      return "Password should Be at Least 6 Char".tr();
                    }
                    if (value != passwordController.text) {
                      return "Password Doesn't Match".tr();
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration:  InputDecoration(
                    hintText: "Re Password".tr(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: const Icon(Icons.visibility_off_outlined),
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
                                title:  Text("Something Went Wrong".tr()),
                                content: Text(message),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child:  Text("OK".tr()),
                                  )
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
                      "Create Account".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                ),
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
                          text: "Already Have Account ? ".tr(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                        ),
                        TextSpan(
                            text: "Login".tr(),
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
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedToggleSwitch<String>.rolling(
                      current: myProvider.currentLanguage,
                      values: const ["en", "ar"],
                      onChanged: (value) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          myProvider.changeLanguage(context, value);
                        });
                      },
                      iconList: [
                        Image.asset("assets/images/En.png"),
                        Image.asset("assets/images/AR.png"),
                      ],
                      height: 40,
                      indicatorSize: const Size(40, 40),
                      style: ToggleStyle(
                        backgroundColor: Colors.transparent,
                        indicatorColor: Theme.of(context).primaryColor,
                        borderColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
