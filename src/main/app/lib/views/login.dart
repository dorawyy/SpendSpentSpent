import 'dart:async';
import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:animations/animations.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spend_spent_spent/globals.dart' as globals;
import 'package:spend_spent_spent/globals.dart';
import 'package:spend_spent_spent/models/appColors.dart';
import 'package:spend_spent_spent/models/config.dart';
import 'package:spend_spent_spent/utils/colorUtils.dart';
import 'package:spend_spent_spent/views/welcome/loginForm.dart';
import 'package:spend_spent_spent/views/welcome/signUp.dart';

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
  SharedAxisTransitionType? _transitionType = SharedAxisTransitionType.horizontal;
  Config? config;
  String loginError = '';
  bool showSignUp = false;
  TextEditingController urlController = TextEditingController(text: 'https://sss.ftpix.com');
  Timer? debounce;
  Widget toDisplay = SizedBox.shrink();

  Future<void> logIn(String username, String password) async {
    setState(() {
      loginError = '';
    });

    try {
      await globals.service.setUrl(urlController.text.trim());
      var loggedIn = await globals.service.login(username, password);
      setState(() {
        loginError = '';
      });
      if (loggedIn) {
        FBroadcast.instance().broadcast(globals.BROADCAST_LOGGED_IN);
        print(loggedIn);
        widget.onLoginSuccess();
      }
    } catch (e) {
      setState(() {
        loginError = e.toString().replaceFirst("Exception: ", '');
      });
    }
  }

  getConfig() async {
    try {
      print('getting config');
      Config config = await service.getServerConfig(urlController.text.trim());
      print('can register ? ${config.allowSignup}');
      setState(() {
        this.config = config;
      });
    } catch (e) {
      setState(() {
        this.config = null;
      });
    }
  }

  signUp(bool signUp) {
    setState(() {
      this.showSignUp = signUp;
    });
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
                      child: AnimatedSwitcher(
                        duration: panelTransition,
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                          return AnimatedBuilder(
                              animation: rotate,
                              child: child,
                              builder: (BuildContext context, Widget? child) {
                                final angle = (ValueKey(showSignUp) != widget.key) ? min(rotate.value, pi / 2) : rotate.value;
                                return Transform(
                                  transform: Matrix4.rotationY(angle),
                                  child: child,
                                  alignment: Alignment.center,
                                );
                              });
                        },
                        child: showSignUp
                            ? SignUp(key: ValueKey(true), onBack: () => signUp(false), server: urlController.text.trim())
                            : LoginForm(
                                error: loginError,
                                key: ValueKey(false),
                                urlController: urlController,
                                config: config,
                                logIn: logIn,
                                showSignUp: () => signUp(true),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        AnimatedPositioned(
            top: config == null || (config?.announcement.trim().length ?? 0) == 0 ? -200 : 0,
            left: 0,
            right: 0,
            curve: Curves.easeInOutQuart,
            duration: panelTransition,
            child: Container(
              color: colors.announcement,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  config?.announcement ?? '',
                  style: TextStyle(color: colors.announcementText),
                ),
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
