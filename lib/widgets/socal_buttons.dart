import 'package:all_firebase_auth/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../auth methods/authentications.dart';

class SocalButtns extends StatefulWidget {
  const SocalButtns({
    Key? key,
  }) : super(key: key);

  @override
  State<SocalButtns> createState() => _SocalButtnsState();
}

class _SocalButtnsState extends State<SocalButtns> {
  final AuthMethod _authMethods = AuthMethod();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: Image.asset("assets/telephone.png")),
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
            icon: Image.asset("assets/search.png")),
      ],
    );
  }
}
