


import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';

class LoginSignupButtonBar extends StatefulWidget {
  const LoginSignupButtonBar({
    super.key,
  });

  @override
  State<LoginSignupButtonBar> createState() => _LoginSignupButtonBarState();
}

class _LoginSignupButtonBarState extends State<LoginSignupButtonBar> {
  final ValueNotifier<bool> isHoveringLogin = ValueNotifier(false);
  final ValueNotifier<bool> isHoveringSignUp = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FocusableActionDetector(
          onShowHoverHighlight: (hovering) {
            isHoveringLogin.value = hovering;
          },
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/LoginScreen');
            },
            child: ValueListenableBuilder<bool>(
              valueListenable: isHoveringLogin,
              builder: (context, isHovering, child) {
                return Material(
                  elevation: isHovering ? 5 : 0,
                  borderRadius: BorderRadius.circular(5),
                  color: MyColor.white,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Text(
                        "Login",
                        style: TextDesign().mtBodyText.copyWith(
                            backgroundColor: MyColor.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 30,
          child: VerticalDivider(
            color: Colors.black,
          ),
        ),
        FocusableActionDetector(
          onShowHoverHighlight: (hovering) {
            isHoveringSignUp.value = hovering;
          },

          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/SignUpScreen');
            },
            child: ValueListenableBuilder<bool>(
              valueListenable: isHoveringSignUp,
              builder: (context, isHovering, child) {
                return Material(
                  elevation: isHovering ? 5 : 0,
                  borderRadius: BorderRadius.circular(5),
                  color: MyColor.white,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Text(
                        "SignUp",
                        style: TextDesign().mtBodyText.copyWith(
                            backgroundColor: MyColor.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}