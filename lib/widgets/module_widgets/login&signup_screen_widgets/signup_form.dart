
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../Utils/validators.dart';
import '../../../const_config/color_config.dart';
import '../../../services/auth/auth_provider.dart';
import '../../buttons/icon_text_button.dart';
import '../../global_widgets/custom_snack_bar.dart';
import '../../global_widgets/footer.dart';
import '../../input_fields/multi_line_input_field.dart';
import '../../input_fields/password_input_field.dart';
import '../../input_fields/simple_input_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final phoneNoController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    rePasswordController.dispose();
    phoneNoController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context, listen: false);


    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        size.width > 1000 ? Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: size.width / 3,
                child: Column(
                  children: [
                    SimpleInputField(
                      controller: nameController,
                      fieldTitle: "User Name",
                      hintText: "Enter your name",
                      validatorClass: ValidatorClass().validateName,
                      needValidation: true,
                      errorMessage: "Please enter valid name",
                      backgroundColor: MyColor.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                      height: 10,
                    ),
                    PasswordInputField(
                        backgroundColor: MyColor.white,
                        password: passwordController,
                        fieldTitle: "Create Password",
                        hintText: "Enter password"),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordInputField(
                        backgroundColor: MyColor.white,
                        password: rePasswordController,
                        fieldTitle: "Re-enter Password",
                        hintText: "Re-enter Password"),
                    const SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 200,
                child: VerticalDivider(
                  width: 10,
                  color: MyColor.bnbRed,
                ),
              ),
              SizedBox(
                width: size.width / 3,
                child: Column(
                  children: [
                    SimpleInputField(
                      backgroundColor: MyColor.white,
                      controller: phoneNoController,
                      fieldTitle: "Phone Number",
                      hintText: "Enter your phone number",
                      validatorClass: ValidatorClass().validateNumber,
                      needValidation: true,
                      errorMessage: "Please enter valid Phone Number",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MultiLineInputField(
                        backgroundColor: MyColor.white,
                        controller: addressController,
                        hintText: "Enter your full Address",
                        fieldTitle: "Address",
                        validatorClass: ValidatorClass().validateNotEmpty,
                        numberOfLines: 4),
                    const SizedBox(
                      height: 20,
                    ),
                    IconTextButton(
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          ///==
                          auth
                              .signUp(
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: rePasswordController.text,
                              name: nameController.text,
                              number: phoneNoController.text,
                              address: addressController.text)
                              .then((value) {
                            if (value.status) {



                              emailController.clear();
                              passwordController.clear();
                              rePasswordController.clear();
                              nameController.clear();
                              phoneNoController.clear();
                              addressController.clear();
                              CustomSnackBar.showSnackBar(
                                  context: context,
                                  message: value.message,
                                  color: MyColor.mtMainGreen);

                              Navigator.pushNamed(context, '/LoginScreen');



                            } else {
                              CustomSnackBar.showSnackBar(
                                  context: context,
                                  message: value.message,
                                  color: MyColor.red);
                            }
                          });
                        } else {
                        }
                      },
                      text: "Sign up",
                      height: 50,
                      width: size.width,
                      icon: Icons.app_registration_rounded,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    IconTextButton(
                      onClick: () {},
                      text: "Signup with Google",
                      height: 50,
                      width: size.width,
                      backGroundColor: MyColor.bnbGoogleButtonColor,
                      icon: FontAwesomeIcons.googlePlus,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        : SizedBox(
          width: size.width > 500 ? 350 : 280,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SimpleInputField(
                  controller: nameController,
                  fieldTitle: "User Name",
                  hintText: "Enter your name",
                  validatorClass: ValidatorClass().validateName,
                  needValidation: true,
                  errorMessage: "Please enter valid name",
                  backgroundColor: MyColor.white,
                ),
                const SizedBox(
                  height: 10,
                ),
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
                  height: 10,
                ),
                PasswordInputField(
                    backgroundColor: MyColor.white,
                    password: passwordController,
                    fieldTitle: "Create Password",
                    hintText: "Enter password"),
                const SizedBox(
                  height: 10,
                ),
                PasswordInputField(
                    backgroundColor: MyColor.white,
                    password: rePasswordController,
                    fieldTitle: "Re-enter Password",
                    hintText: "Re-enter Password"),
                const SizedBox(
                  height: 10,
                ),
                SimpleInputField(
                  backgroundColor: MyColor.white,
                  controller: phoneNoController,
                  fieldTitle: "Phone Number",
                  hintText: "Enter your phone number",
                  validatorClass: ValidatorClass().validateNumber,
                  needValidation: true,
                  errorMessage: "Please enter valid Phone Number",
                ),
                const SizedBox(
                  height: 10,
                ),
                MultiLineInputField(
                    backgroundColor: MyColor.white,
                    controller: addressController,
                    hintText: "Enter your full Address",
                    fieldTitle: "Address",
                    validatorClass: ValidatorClass().validateNotEmpty,
                    numberOfLines: 4),
                const SizedBox(
                  height: 20,
                ),
                IconTextButton(
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      ///==
                      auth
                          .signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: rePasswordController.text,
                          name: nameController.text,
                          number: phoneNoController.text,
                          address: addressController.text)
                          .then((value) {
                        if (value.status) {



                          emailController.clear();
                          passwordController.clear();
                          rePasswordController.clear();
                          nameController.clear();
                          phoneNoController.clear();
                          addressController.clear();
                          CustomSnackBar.showSnackBar(
                              context: context,
                              message: value.message,
                              color: MyColor.mtMainGreen);

                          Navigator.pushNamed(context, '/LoginScreen');



                        } else {
                          CustomSnackBar.showSnackBar(
                              context: context,
                              message: value.message,
                              color: MyColor.red);
                        }
                      });
                    } else {
                    }
                  },
                  text: "Sign up",
                  height: 50,
                  width: size.width,
                  icon: Icons.app_registration_rounded,
                ),
                const SizedBox(
                  height: 10,
                ),
                IconTextButton(
                  onClick: () {},
                  text: "Signup with Google",
                  height: 50,
                  width: size.width,
                  backGroundColor: MyColor.bnbGoogleButtonColor,
                  icon: FontAwesomeIcons.googlePlus,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        const Footer()
      ],
    );
  }
}
