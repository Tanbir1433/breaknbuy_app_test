
import 'package:flutter/material.dart';

import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/module_widgets/login&signup_screen_widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 0,
            child: BnbAppBar(
              isHome: false,
            ),
          ),
          Flexible(
            flex: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: SignupForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
