
import 'package:flutter/material.dart';

import '../../../const_config/color_config.dart';
import '../../buttons/simple_button.dart';
import '../../input_fields/simple_input_field.dart';

class AddPromoPopUp extends StatefulWidget {
  const AddPromoPopUp({super.key});

  @override
  State<AddPromoPopUp> createState() => _AddPromoPopUpState();
}

class _AddPromoPopUpState extends State<AddPromoPopUp> {
  final _formKey = GlobalKey<FormState>();
  final promoController = TextEditingController();

  @override
  void dispose() {
    promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  mainAxisAlignment: MainAxisAlignment.end,
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
                        controller: promoController,
                        fieldTitle: "Promo Code",
                        hintText: "EA251",
                        needValidation: true,
                        errorMessage: "Please enter valid Promo Code",
                      ),
                    ),
                    SimpleButton(
                      text: "Confirm Code",
                      onClick: () {},
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
