
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../Utils/validators.dart';
import '../../../const_config/color_config.dart';

import '../../../const_config/text_config.dart';
import '../../../services/auth/auth_provider.dart';
import '../../../services/user/user_provider.dart';
import '../../buttons/simple_button.dart';
import '../../global_widgets/custom_snack_bar.dart';
import '../../input_fields/multi_line_input_field.dart';

class UserRatingPopup extends StatefulWidget {
  final int productId;
  const UserRatingPopup({
    super.key,
    required this.productId,
  });

  @override
  State<UserRatingPopup> createState() => _ChangeUserRatingPopup();
}

class _ChangeUserRatingPopup extends State<UserRatingPopup> {
  final _formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();
  final ratingController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    ratingController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    ratingController.text = '5';
    super.initState();
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
              width: size.width / 2.3,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          horizontal: 15, vertical: 5),
                      child: Text(
                        'Rating',
                        style: TextDesign().bodyTextSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        tapOnlyMode: true,
                        ignoreGestures: false,
                        itemSize: 22,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: MyColor.bnbLightRed,
                        ),
                        onRatingUpdate: (rating) {
                          ratingController.text = rating.toString();
                        },
                        unratedColor: MyColor.bnbGrey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: MultiLineInputField(
                          backgroundColor: MyColor.white,
                          controller: commentController,
                          hintText: "Type your Comment",
                          fieldTitle: "Comment",
                          validatorClass: ValidatorClass().validateNotEmpty,
                          numberOfLines: 4),
                    ),
                    Center(
                      child: SimpleButton(
                        text: "Submit",
                        onClick: () {
                          if (_formKey.currentState!.validate()) {
                            user
                                .storeRating(
                                    token: auth.token,
                                    userId: auth.user.id,
                                    productId: widget.productId,
                                    ratingValue:
                                        int.parse(ratingController.text),
                                    review: commentController.text)
                                .then((value) {
                              if (value) {
                                Navigator.pop(context);
                                CustomSnackBar.showSnackBar(
                                    context: context,
                                    message: 'Successfully Added',
                                    color: MyColor.mtMainGreen);
                              } else {
                                CustomSnackBar.showSnackBar(
                                    context: context,
                                    message: 'Error',
                                    color: MyColor.red);
                              }
                            });
                          }
                        },
                      ),
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
