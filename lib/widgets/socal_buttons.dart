import 'package:all_firebase_auth/widgets/home_screen.dart';
import 'package:flutter/material.dart';

import '../resources/auth_method.dart';

class SocalButtns extends StatefulWidget {
  const SocalButtns({
    Key? key,
  }) : super(key: key);

  @override
  State<SocalButtns> createState() => _SocalButtnsState();
}

class _SocalButtnsState extends State<SocalButtns> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: Image.asset("assets/fb.png")),
        IconButton(onPressed: () {}, icon: Image.asset("assets/linkedin.png")),
        IconButton(
            onPressed: () async {
              bool res = await _authMethods.signInWithGoogle(context);
              if (res) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            },
            icon: Image.asset("assets/twitter.png")),
      ],
    );
  }
}
