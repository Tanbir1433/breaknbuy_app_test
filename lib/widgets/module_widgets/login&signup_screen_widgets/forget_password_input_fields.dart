
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Utils/validators.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../../services/auth/auth_provider.dart';
import '../../buttons/simple_button.dart';
import '../../global_widgets/custom_snack_bar.dart';
import '../../input_fields/simple_input_field.dart';

class ForgetPasswordInputFields extends StatefulWidget {
  const ForgetPasswordInputFields({super.key});

  @override
  State<ForgetPasswordInputFields> createState() =>
      _ForgetPasswordInputFieldsState();
}

class _ForgetPasswordInputFieldsState extends State<ForgetPasswordInputFields> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return SizedBox(
      height: 400,
      width: 280,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
            Text("A Code will be sent to your email",
                style: TextDesign().bnbBodyText),
            const SizedBox(
              height: 20,
            ),
            SimpleButton(
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  auth.forgetPassword(emailController.text).then((value) {
                    if (value) {
                      CustomSnackBar.showSnackBar(
                          context: context,
                          message: "Check your mail please",
                          color: MyColor.mtMainGreen);
                      emailController.clear();

                      Navigator.of(context).pushNamed('/newPasswordScreen');
                    } else {
                      CustomSnackBar.showSnackBar(
                          context: context,
                          message: "something wrong",
                          color: MyColor.red);
                    }
                  });
                }
              },
              text: "Comfirm Email",
              height: 50,
              width: size.width,
            ),
          ],
        ),
      ),
    );
  }
}
