import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/base.dart';
import 'package:todo_c13_sun/providers/user_provider.dart';
import 'package:todo_c13_sun/screens/auth/register.dart';
import 'package:todo_c13_sun/screens/home/home.dart';
import 'package:todo_c13_sun/screens/login/login_connector.dart';
import 'package:todo_c13_sun/screens/login/login_viewmodel.dart';

import '../auth/forget_password.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginViewModel>
    implements LoginConnector {
  TextEditingController emaillController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                TextField(
                  controller: emaillController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Email".tr(),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: passwordController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Password".tr(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: const Icon(Icons.visibility),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgetPassword.routeName);
                      },
                      child: Text(
                        "Forget Password ?".tr(),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              decoration: TextDecoration.underline,
                            )!,
                      )),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () {
                      viewModel.login(
                        emaillController.text,
                        passwordController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: const Color(0xFF5669FF)),
                    child: Text(
                      "login".tr() ,
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
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don’t Have Account ?".tr(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                        ),
                        TextSpan(
                            text: "Create Account".tr(),
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
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 20,
                        indent: 20,
                        thickness: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      "OR".tr(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Expanded(
                      child: Divider(
                        endIndent: 20,
                        indent: 20,
                        thickness: 2,
                        color: Theme.of(context).primaryColor,
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

  @override
  goToHome() {
    Navigator.pop(context);
    // provider.initUser();
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreen.routeName,
      (route) => false,
    );
  }

  @override
  LoginViewModel iniMyViewModel() {
    return LoginViewModel();
  }
}
