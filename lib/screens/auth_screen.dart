import 'dart:math';

import 'package:all_firebase_auth/auth%20methods/authentications.dart';
import 'package:all_firebase_auth/screens/home_screen.dart';
import 'package:all_firebase_auth/utils/constants.dart';
import 'package:all_firebase_auth/utils/login_form.dart';
import 'package:all_firebase_auth/utils/sign_up_form.dart';
import 'package:all_firebase_auth/widgets/socal_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/sign_up_form.dart';
import '../utils/util.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  //if we want to show our sign up then we set it true
  bool _ishowSignup = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod()
        .loginUser(
        email: _emailController.text,
        password: _passwordController.text);

    if(res == "success"){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }else{
      showSnackBar(context,res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  @override
  void updateView() {
    setState(() {
      _ishowSignup = !_ishowSignup;
    });
    _ishowSignup
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                //login form
                AnimatedPositioned(
                  duration: defaultDuration,
                  //we have used 88% width
                  width: size.width * 0.88,
                  //88%
                  height: size.height,
                  left: _ishowSignup ? -size.width * 0.76 : 0,
                  child: Container(
                    color: login_bg,
                    child: LoginForm(),
                  ),
                ),
//sign up
                AnimatedPositioned(
                  duration: defaultDuration,
                  height: size.height,
                  width: size.width * .88,
                  left: _ishowSignup ? size.width * 0.12 : size.width * .88,
                  child: Container(
                    color: signup_bg,
                    child: SignUpForm(),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  top: size.height * 0.1,
                  //10%
                  left: 0,
                  right: _ishowSignup ? size.width * 0.06 : size.width * 0.06,
                  child: CircleAvatar(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white12,
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _ishowSignup
                            ? SvgPicture.asset(
                                "assets/animation_logo.svg",
                                color: signup_bg,
                              )
                            : SvgPicture.asset(
                                "assets/animation_logo.svg",
                                color: login_bg,
                              ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                    duration: defaultDuration,
                    width: size.width,
                    bottom: size.width * .1,
                    right: _ishowSignup ? size.width * 0.06 : size.width * 0.06,
                    child: SocalButtns()),
                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom:
                      _ishowSignup ? size.height / 2 - 80 : size.height * 0.3,
                  left: _ishowSignup ? 0 : size.width * 0.44 - 80,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: _ishowSignup ? 20 : 30,
                        fontWeight: FontWeight.bold,
                        color: _ishowSignup ? Colors.white : Colors.white70),
                    child: Transform.rotate(
                      angle: -_animationTextRotate.value * pi / 180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          if (_ishowSignup) {
                            updateView();
                          } else {
                            loginUser();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: defpaultPadding * 0.75),
                          width: 160,
                          child: Text(
                            "Log in".toUpperCase(),
                            style: TextStyle(color:  signup_bg),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //animation for sign Up

                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom:
                      !_ishowSignup ? size.height / 2 - 80 : size.height * 0.3,
                  right: _ishowSignup ? size.width * 0.44 - 80 : 0,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: !_ishowSignup ? 20 : 30,
                        fontWeight: FontWeight.bold,
                        color: _ishowSignup ? Colors.white : Colors.white70),
                    child: Transform.rotate(
                      angle: (90 - _animationTextRotate.value) * pi / 180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          if (_ishowSignup) {
                            signUpUser();
                          } else {
                            updateView();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: defpaultPadding * 0.75),
                          width: 160,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Sign Up".toUpperCase(),
                              style: TextStyle(color:  login_bg,

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
