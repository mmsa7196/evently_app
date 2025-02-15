import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/providers/my_provider.dart';
import 'package:todo_c13_sun/screens/auth/login_withe_google.dart';
import 'package:todo_c13_sun/screens/login/login_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}
class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var myProvider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.primaryColor,
        toolbarHeight: 160,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(64),
          ),
        ),
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/route.png",
                    height: 124,
                    width: 124,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser?.displayName
                                  ?.toUpperCase() ??
                              "",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser?.email ?? "",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Language",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.primaryColor),
              ),
              child: DropdownButton<String>(
                value: myProvider.currentLanguage,
                isExpanded: true,
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                underline: const SizedBox(),
                items: [
                  DropdownMenuItem(
                    value: "ar",
                    child: Text("Arabic", style: theme.textTheme.titleMedium),
                  ),
                  DropdownMenuItem(
                    value: "en",
                    child: Text("English", style: theme.textTheme.titleMedium),
                  ),
                ],
                onChanged: (value) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    myProvider.changeLanguage(context, value!);
                  });
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text("Theme", style: theme.textTheme.titleMedium),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.primaryColor),
              ),
              child: DropdownButton(
                value: myProvider.themeMode,
                isExpanded: true,
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text("Light"),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text("Dark"),
                  ),
                ],
                onChanged: (value) {
                  myProvider.changeTheme();
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                LoginWithGoogle.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                  (route) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xffFF5659),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(8)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Icon(
                      Icons.logout,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Expanded(
                    child: Text("LogOut",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
