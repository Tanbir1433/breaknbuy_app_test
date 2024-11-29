
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Utils/validators.dart';
import '../../../const_config/color_config.dart';
import '../../../services/auth/auth_provider.dart';
import '../../buttons/simple_button.dart';
import '../../global_widgets/custom_snack_bar.dart';
import '../../input_fields/password_input_field.dart';
import '../../input_fields/simple_input_field.dart';

class NewPasswordInputFields extends StatefulWidget {
  const NewPasswordInputFields({super.key});

  @override
  State<NewPasswordInputFields> createState() => _NewPasswordInputFieldsState();
}

class _NewPasswordInputFieldsState extends State<NewPasswordInputFields> {
  final codeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    codeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return SizedBox(
      height: 450,
      width: 280,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SimpleInputField(
              backgroundColor: MyColor.bnbFlashWhite,
              controller: codeController,
              hintText: "Enter token",
              validatorClass: ValidatorClass().validateNotEmpty,
              needValidation: true,
              errorMessage: "",
              fieldTitle: "Enter the token from your email",
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordInputField(
                backgroundColor: MyColor.white,
                password: newPasswordController,
                fieldTitle: "Enter New Password",
                hintText: "Enter a new password"),
            const SizedBox(
              height: 20,
            ),
            PasswordInputField(
                backgroundColor: MyColor.white,
                password: confirmPasswordController,
                fieldTitle: "Confirm Password",
                hintText: "Re-enter new password"),
            const SizedBox(
              height: 20,
            ),
            SimpleButton(
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  auth
                      .resetPassword(
                          token: codeController.text,
                          password: newPasswordController.text,
                          confirmPassword: confirmPasswordController.text)
                      .then((value) {
                    if (value) {
                      codeController.clear();
                      newPasswordController.clear();
                      confirmPasswordController.clear();

                      CustomSnackBar.showSnackBar(
                          context: context,
                          message: "Password Reset Successfully",
                          color: MyColor.mtMainGreen);
                    } else {
                      CustomSnackBar.showSnackBar(
                          context: context,
                          message: "Something Wrong",
                          color: MyColor.red);
                    }
                  });
                }
              },
              text: "Confirm Password",
              height: 50,
              width: size.width,
            ),
          ],
        ),
      ),
    );
  }
}
