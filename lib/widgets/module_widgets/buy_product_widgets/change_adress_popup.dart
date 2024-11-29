import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Utils/validators.dart';
import '../../../../const_config/color_config.dart';
import '../../../const_config/list_config.dart';
import '../../../models/user/login_user.dart';
import '../../../services/auth/auth_provider.dart';
import '../../../services/user/user_provider.dart';
import '../../buttons/simple_button.dart';
import '../../global_widgets/custom_snack_bar.dart';
import '../../input_fields/drop_down_input_field.dart';
import '../../input_fields/simple_input_field.dart';

class ChangeAddressPopup extends StatefulWidget {
  const ChangeAddressPopup({
    super.key,
  });

  @override
  State<ChangeAddressPopup> createState() => _ChangeAddressPopupState();
}

class _ChangeAddressPopupState extends State<ChangeAddressPopup> {
  final _formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final cityNameController = TextEditingController();
  final countryNameController = TextEditingController();
  final districtNameController = TextEditingController();
  final zipcodeNameController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    cityNameController.dispose();
    countryNameController.dispose();
    districtNameController.dispose();
    zipcodeNameController.dispose();
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
                        controller: addressController,
                        fieldTitle: "Address",
                        hintText: "Eg: House 375, Road 10, block G",
                        validatorClass: ValidatorClass().validateAddress,
                        needValidation: true,
                        errorMessage: "Please enter valid address",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: DropDownInputField(
                        controller: districtNameController,
                        fieldTitle: "District",
                        hintText: "Select District",
                        needValidation: true,
                        errorMessage: "Please select a valid district",
                        items: MyList().bangladeshDistricts,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SimpleInputField(
                        controller: cityNameController,
                        fieldTitle: "City",
                        hintText: "Eg: Bashundhara R/A",
                        validatorClass: ValidatorClass().validateName,
                        needValidation: true,
                        errorMessage: "Please enter valid city Name",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SimpleInputField(
                        controller: zipcodeNameController,
                        fieldTitle: "Zip Code",
                        hintText: "Eg: 1190",
                        validatorClass: ValidatorClass().validateNumber,
                        needValidation: true,
                        errorMessage: "Please enter valid Zip No",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SimpleInputField(
                        controller: countryNameController,
                        fieldTitle: "Country",
                        hintText: "Eg: Bangladesh",
                        validatorClass: ValidatorClass().validateName,
                        needValidation: true,
                        errorMessage: "Please enter valid Country Name",
                      ),
                    ),
                    SimpleButton(
                      text: "Confirm Address",
                      onClick: () {
                        if (_formKey.currentState!.validate() &&
                            auth.userLogInStatus) {
                          user
                              .updateAddress(
                                  token: auth.token,
                                  id: auth.user.address.id,
                                  addressLine1: addressController.text,
                                  addressLine2: districtNameController.text,
                                  city: cityNameController.text,
                                  state: districtNameController.text,
                                  country: countryNameController.text,
                                  zipCode: zipcodeNameController.text)
                              .then((value) {
                            if (value) {
                              auth.resentUpdateAddress(Address(
                                  id: auth.user.address.id,
                                  addressLine1: addressController.text,
                                  addressLine2: districtNameController.text,
                                  city: cityNameController.text,
                                  state: districtNameController.text,
                                  country: countryNameController.text,
                                  zipCode: zipcodeNameController.text,
                                  createdAt: '',
                                  updatedAt: ''));

                              Navigator.pop(context);
                              addressController.clear();
                              cityNameController.clear();
                              countryNameController.clear();
                              districtNameController.clear();
                              zipcodeNameController.clear();

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
