
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Utils/validators.dart';
import '../../../const_config/color_config.dart';

import '../../../services/auth/auth_provider.dart';
import '../../../services/user/user_provider.dart';
import '../../buttons/simple_button.dart';
import '../../global_widgets/custom_snack_bar.dart';
import '../../input_fields/simple_input_field.dart';

class ChangeUserDetailPopUp extends StatefulWidget {
  const ChangeUserDetailPopUp({super.key});

  @override
  State<ChangeUserDetailPopUp> createState() => _ChangeUserDetailPopUpState();
}

class _ChangeUserDetailPopUpState extends State<ChangeUserDetailPopUp> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final gmailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    gmailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: MyColor.bnbRed, width: 1),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: MyColor.white,
        clipBehavior: Clip.hardEdge,
        elevation: 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              //height: size.height / 2.15,
              width: size.width / 2.3,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: MyColor.bnbRed,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SimpleInputField(
                        controller: nameController,
                        fieldTitle: "Name",
                        hintText: "Enter Name",
                        validatorClass: ValidatorClass().validateContact,
                        needValidation: true,
                        errorMessage: "Please enter your Name",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SimpleInputField(
                        controller: gmailController,
                        fieldTitle: "Email",
                        hintText: "somethin@gmail.com",
                        validatorClass: ValidatorClass().validateEmail,
                        needValidation: true,
                        errorMessage: "Please enter valid Email",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SimpleInputField(
                        controller: phoneController,
                        fieldTitle: "Phone",
                        hintText: "01909371713",
                        validatorClass: ValidatorClass().validateNumber,
                        needValidation: true,
                        errorMessage: "Please enter valid phone number",
                      ),
                    ),
                    SimpleButton(
                      text: "Confirm Address",
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          user
                              .updateUserProfile(
                            token: auth.token,
                            id: auth.user.id,
                            name: nameController.text,
                            email: gmailController.text,
                            phoneNumber: phoneController.text,
                          )
                              .then((value) {
                            if (value) {
                              Navigator.pop(context);

                              auth.resentUpdateUserProfile(
                                  name: nameController.text,
                                  number: phoneController.text,
                                  email: gmailController.text);

                              nameController.clear();
                              gmailController.clear();
                              phoneController.clear();

                              CustomSnackBar.showSnackBar(
                                  context: context,
                                  message: 'Change Address Successfully',
                                  color: MyColor.mtMainGreen);
                            } else {
                              CustomSnackBar.showSnackBar(
                                  context: context,
                                  message: 'Error, Try Again',
                                  color: MyColor.red);
                            }
                          });
                        } else {
                          print('error');
                        }
                      },

                      ///write Update validation code here
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
