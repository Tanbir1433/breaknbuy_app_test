
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../Utils/validators.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../../services/auth/auth_provider.dart';
import '../../buttons/icon_text_button.dart';
import '../../global_widgets/custom_snack_bar.dart';
import '../../input_fields/password_input_field.dart';
import '../../input_fields/simple_input_field.dart';

class LoginScreenInputFields extends StatefulWidget {
  const LoginScreenInputFields({super.key});

  @override
  State<LoginScreenInputFields> createState() => _LoginScreenInputFieldsState();
}

class _LoginScreenInputFieldsState extends State<LoginScreenInputFields> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return SizedBox(
      width: 280,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SimpleInputField(
              backgroundColor: MyColor.white,
              controller: emailController,
              hintText: "Enter your Email",
              validatorClass: ValidatorClass().validateEmail,
              needValidation: true,
              errorMessage: "",
              fieldTitle: "Email",
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordInputField(
                backgroundColor: MyColor.white,
                password: passwordController,
                fieldTitle: "Password",
                hintText: "Enter your password"
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/forgetPasswordScreen');
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextDesign()
                          .bnbButtonText
                          .copyWith(color: MyColor.bnbRed, fontSize: 12),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            IconTextButton(
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  ///==
                  auth
                      .loginWithEmailAndPassword(
                          emailController.text, passwordController.text)
                      .then((value) {
                    if (value) {
                      emailController.clear();
                      passwordController.clear();
                      CustomSnackBar.showSnackBar(
                          context: context,
                          message: 'Successfully Login',
                          color: MyColor.mtMainGreen);

                      Navigator.pushNamed(context, '/');
                    } else {
                      CustomSnackBar.showSnackBar(
                          context: context,
                          message: 'please check email or password',
                          color: MyColor.red);
                    }
                  });
                } else {
                  CustomSnackBar.showSnackBar(
                      context: context,
                      message: 'please fill up all',
                      color: MyColor.red);
                }
              },
              text: "Login",
              height: 50,
              width: size.width,
              icon: Icons.login_rounded,
              iconColor: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            IconTextButton(
              onClick: () {},
              text: "Login with Google",
              height: 50,
              width: size.width,
              backGroundColor: MyColor.bnbGoogleButtonColor,
              icon: FontAwesomeIcons.googlePlus,
            ),
          ],
        ),
      ),
    );
  }
}
