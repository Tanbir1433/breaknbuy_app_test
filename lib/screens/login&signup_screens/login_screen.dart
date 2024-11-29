
import 'package:flutter/material.dart';
import '../../const_config/color_config.dart';
import '../../widgets/appbar/bnb_app_bar.dart';
import '../../widgets/global_widgets/footer.dart';
import '../../widgets/module_widgets/login&signup_screen_widgets/login_screen_input_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColor.white,
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    LoginScreenInputFields(),
                    SizedBox(
                      height: 20,
                    ),
                    Footer()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
