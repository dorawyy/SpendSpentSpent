import 'dart:async';
import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:spend_spent_spent/globals.dart' as globals;
import 'package:spend_spent_spent/globals.dart';
import 'package:spend_spent_spent/icons.dart';
import 'package:spend_spent_spent/models/appColors.dart';
import 'package:spend_spent_spent/models/config.dart';
import 'package:spend_spent_spent/utils/colorUtils.dart';

class Login extends StatefulWidget {
  Function onLoginSuccess;

  Login({required this.onLoginSuccess});

  @override
  _LoginState createState() => _LoginState();
}

InputDecoration getFieldDecoration(String label, String hint, AppColors colors) {
  return InputDecoration(
      border: OutlineInputBorder(borderSide: BorderSide(color: colors.dialogBackground)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colors.dialogBackground)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: colors.dialogBackground)),
      hintText: hint,
      hintStyle: TextStyle(color: colors.text.withOpacity(0.3)),
      filled: true,
      fillColor: colors.dialogBackground);
}

class _LoginState extends State<Login> with AfterLayoutMixin<Login> {
  final urlController = TextEditingController(text: "https://sss.ftpix.com");
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Config? config;
  String error = '';
  Timer? debounce;

  Future<void> logIn() async {
    try {
      await globals.service.setUrl(urlController.text);
      var loggedIn = await globals.service.login(usernameController.text, passwordController.text);
      setState(() {
        error = '';
      });
      if (loggedIn) {
        FBroadcast.instance().broadcast(globals.BROADCAST_LOGGED_IN);
        print(loggedIn);
        widget.onLoginSuccess();
      }
    } catch (e) {
      setState(() {
        error = e.toString().replaceFirst("Exception: ", '');
      });
    }
  }

  getConfig() async {
    try {
      print('getting config');
      Config config = await service.getServerConfig(urlController.text);
      setState(() {
        this.config = config;
      });
    } catch (e) {
      setState(() {
        this.config = null;
      });
    }
  }

  double getIconSize(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return min(200, height / 3);
  }

  double getTopPadding(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return min(50, height / 3);
  }

  @override
  Widget build(BuildContext context) {
    AppColors colors = get(context);

    final bottom = MediaQuery.of(context).viewInsets.bottom;
    MediaQueryData mq = MediaQuery.of(context);
    bool tablet = isTablet(mq);

    double width = mq.size.width;
    double height = mq.size.height;

    if (tablet) {
      width = 500;
      height = 600;
    }

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  width: width,
                  height: height,
                  duration: panelTransition,
                  curve: Curves.easeInOutQuart,
                  decoration: BoxDecoration(gradient: defaultGradient(context), borderRadius: BorderRadius.circular(tablet ? 20 : 0)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: bottom),
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(50.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: globals.defaultBorder,
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Padding(padding: const EdgeInsets.all(8.0), child: getIcon('groceries_bag', size: getIconSize(context), color: colors.iconOnMain)),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(alignment: Alignment.centerLeft, child: Text('Server URL', style: TextStyle(color: colors.textOnMain))),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: PlatformTextField(
                                              showCursor: true,
                                              controller: urlController,
                                              autocorrect: false,
                                              material: (_, __) => MaterialTextFieldData(decoration: getFieldDecoration("Email", "user@example.org", colors)),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(alignment: Alignment.centerLeft, child: Text('Email', style: TextStyle(color: colors.textOnMain))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: PlatformTextField(
                                            controller: usernameController,
                                            autocorrect: false,
                                            material: (_, __) => MaterialTextFieldData(decoration: getFieldDecoration("Email", "user@example.org", colors)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(alignment: Alignment.centerLeft, child: Text('Password', style: TextStyle(color: colors.textOnMain))),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: PlatformTextField(
                                              controller: passwordController,
                                              obscureText: true,
                                              material: (_, __) => MaterialTextFieldData(decoration: getFieldDecoration("Password", "", colors)),
                                            )),
                                        Visibility(
                                          visible: error.length > 0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(error),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: PlatformButton(onPressed: logIn, child: Text('Log in')),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ))),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        AnimatedPositioned(
            top: config == null ? -200 : 0,
            left: 0,
            right: 0,
            curve: Curves.easeInOutQuart,
            duration: panelTransition,
            child: Container(
              color: colors.announcement,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(config?.announcement ?? '', style: TextStyle(color: colors.announcementText),),
              ),
            )),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getConfig();
    urlController.addListener(() {
      debounce?.cancel();
      debounce = Timer(Duration(milliseconds: 500), getConfig);
    });
  }
}
