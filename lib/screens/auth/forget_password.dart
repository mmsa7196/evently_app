import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
class ForgetPassword extends StatelessWidget {
  static const String routeName = "forgetpassword";
  TextEditingController emaillController = TextEditingController();
   ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Forget Password".tr(),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 20
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/forget_password.png"),
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
              height: 24,
            ),
            ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: const Color(0xFF5669FF)),
                child: Text(
                  "Send Email".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
