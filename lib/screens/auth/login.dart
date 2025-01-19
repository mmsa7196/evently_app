import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/firebase/firebase_manager.dart';
import 'package:todo_c13_sun/providers/user_provider.dart';
import 'package:todo_c13_sun/screens/auth/register.dart';
import 'package:todo_c13_sun/screens/home/home.dart';

import 'forget_password.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "loginScreen";
  TextEditingController emaillController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/login_image.png',
                height: 150,
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                controller: emaillController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: "Emaill",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgetPassword.routeName);
                    },
                    child: Text(
                      "Forget Password?",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            decoration: TextDecoration.underline,
                          )!,
                    )),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseManager.login(
                      emaillController.text,
                      passwordController.text,
                      () {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            backgroundColor: Colors.transparent,
                            title: Center(child: CircularProgressIndicator()),
                          ),
                        );
                      },
                      () {
                        Navigator.pop(context);
                        provider.initUser();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeScreen.routeName,
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
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Color(0xFF5669FF)),
                  child: Text(
                    "login",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  )),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Don’t Have Account?",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                      ),
                      TextSpan(
                          text: " Create Account",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    decoration: TextDecoration.underline,
                                  )!),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 40,
                      indent: 10,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    "OR",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Expanded(
                    child: Divider(
                      endIndent: 40,
                      indent: 10,
                      thickness: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
