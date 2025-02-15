import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:spend_spent_spent/models/user.dart';
import 'package:spend_spent_spent/utils/stringUtils.dart';

class AddUserDialog extends StatefulWidget {
  Function saveUser;

  AddUserDialog({required this.saveUser});

  @override
  AddUserDialogState createState() => AddUserDialogState();
}

class AddUserDialogState extends State<AddUserDialog> {
  TextEditingController emailController = TextEditingController(),
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      passwordController = TextEditingController();

  void addUser(BuildContext context) {
    User user = User(
      email: emailController.text,
      firstName: firstNameController.text,
      isAdmin: false,
      lastName: lastNameController.text,
      password: passwordController.text,
    );
    widget.saveUser(user);
    Navigator.pop(context);
  }

  bool valid() {
    return emailController.text.length > 0 && isValidEmail(emailController.text) && firstNameController.text.length > 0 && lastNameController.text.length > 0 && passwordController.text.length > 0;
  }

  void randomPassword() {
    var r = Random.secure();
    passwordController.text = randomAlpha(16, provider: CoreRandomProvider.from(r));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email'),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: PlatformTextField(
              hintText: 'j.doe@example.org',
              controller: emailController,
            ),
          ),
          Text('First name'),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: PlatformTextField(
              hintText: 'John',
              controller: firstNameController,
            ),
          ),
          Text('Last name'),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: PlatformTextField(
              hintText: 'Doe',
              controller: lastNameController,
            ),
          ),
          Text('Password'),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: PlatformTextField(
              controller: passwordController,
            ),
          ),
          PlatformTextButton(
            child: Text('Generate password'),
            onPressed: randomPassword,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PlatformDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: PlatformText(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[850]),
                ),
              ),
              PlatformDialogAction(
                onPressed: valid() ? () => addUser(context) : null,
                child: PlatformText('Save'),
              )
            ],
          )
        ],
      ),
    );
  }
}
