import 'package:ecoland_application/components/notification.dart';
import 'package:ecoland_application/navigation/routes.dart';
import 'package:ecoland_application/providers/user_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

onPressed(String username, String password) async {}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userSettings = Provider.of<UserSettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignIn"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password  '),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    if (_usernameController.text == "" ||
                        _passwordController.text == "") {
                      showCustomNotification(context,
                          message: "Username or password can't be empty",
                          type: NotificationType.error);
                      return;
                    }
                    try {
                      bool signedIn = await userSettings.signIn(
                          _usernameController.text, _passwordController.text);
                      if (signedIn) {
                        navigator.popAndPushNamed(Routes.overview);
                      }
                    } catch (e) {
                      print("could not login");
                      showCustomNotification(context,
                          message: "could not login!",
                          type: NotificationType.error);
                    }
                  },
                  child: const Text("Sign In")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    final navigator = Navigator.of(context);
                    navigator.pushNamed(Routes.signUp);
                  },
                  child: const Text("Sign Up here")),
            ],
          )),
    );
  }
}
