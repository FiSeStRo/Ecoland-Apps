import 'package:ecoland_application/providers/user_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => __UserSettingsScreenStateState();
}

class __UserSettingsScreenStateState extends State<UserSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  String _newPassword = '';

  @override
  void initState() {
    super.initState();
    // Load user settings after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider =
          Provider.of<UserSettingsProvider>(context, listen: false);
      final success = await provider.LoadUserSettings();
      if (success) {
        setState(() {
          _username = provider.userName;
          _email = provider.eMail;
        });
      }
    });
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final provider =
          Provider.of<UserSettingsProvider>(context, listen: false);
      final success = await provider.UpdateUserSettings(
          username: _username,
          oldPassword: _password,
          newPassword: _newPassword,
          eMail: _email);
      if (success) {
        setState(() {
          _username = provider.userName;
          _email = provider.eMail;
        });
      }
    }
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _username,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value != null) {
                    if (_password.isNotEmpty && _password != _newPassword) {
                      return "Passwords do not match";
                    }
                  }

                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'NewPassword'),
                obscureText: true,
                validator: (value) {
                  if (value != null) {
                    if (_password.isNotEmpty && _password != _newPassword) {
                      return "Passwords do not match";
                    }
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _saveChanges,
                    child: Text('Save Changes'),
                  ),
                  ElevatedButton(
                    onPressed: _cancel,
                    child: Text('Cancel'),
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
