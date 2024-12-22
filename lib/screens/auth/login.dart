import 'package:flutter/material.dart';
import 'package:todo_c13_sun/screens/auth/register.dart';
import 'package:todo_c13_sun/screens/home/home.dart';

import '../lets_go_screen.dart';
import 'forget_password.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "loginScreen";
  TextEditingController emaillController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              decoration: InputDecoration(
                hintText: "Emaill",
                prefixIcon: Icon(Icons.email),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor, width: 2)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      BorderSide(color: Theme.of(context).focusColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      BorderSide(color: Theme.of(context).focusColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: emaillController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor, width: 2)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      BorderSide(color: Theme.of(context).focusColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      BorderSide(color: Theme.of(context).focusColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child:
                  TextButton(onPressed: () {
                    Navigator.pushNamed(context, ForgetPassword.routeName);
                  }, child: Text("Forget Password?",style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    decoration: TextDecoration.underline,
                  )!,)),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
    );
  }
}
