import 'package:ecoland_application/providers/user_settings_provider.dart';
import 'package:flutter/material.dart';

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
              ),
              TextField(
                controller: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    if (_usernameController.text == "" ||
                        _passwordController.text == "") {
                      //ToDo: Show error username or password can't be empty
                      return;
                    }
                    bool signedIn = await UserSettingsProvider().signIn(
                        _usernameController.text, _passwordController.text);
                    if (signedIn) {
                      navigator.popAndPushNamed("/overview");
                    } else {
                      print("could not login");
                    }
                  },
                  child: const Text("Sign In")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    final navigator = Navigator.of(context);
                    navigator.pushNamed("/sign-up");
                  },
                  child: const Text("Sign Up here")),
            ],
          )),
    );
  }
}
