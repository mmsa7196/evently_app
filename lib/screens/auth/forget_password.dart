import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  static const String routeName = "forgetpassword";
  TextEditingController emaillController = TextEditingController();
   ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Forget Password",
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
              height: 24,
            ),
            ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Color(0xFF5669FF)),
                child: Text(
                  "Send Email",
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
