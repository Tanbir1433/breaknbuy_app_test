import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../screens/user_profile_screen/user_profile_screen.dart';
import '../../services/auth/auth_provider.dart';
import '../buttons/border_button.dart';
import '../global_widgets/custom_snack_bar.dart';

class AccountsOrdersWidget extends StatefulWidget {
  const AccountsOrdersWidget({super.key});

  @override
  State<AccountsOrdersWidget> createState() => _AccountsOrdersWidgetState();
}

class _AccountsOrdersWidgetState extends State<AccountsOrdersWidget> {
  final ValueNotifier<bool> _isHovered = ValueNotifier<bool>(false);
  final OverlayPortalController _portalController = OverlayPortalController();

  @override
  void dispose() {
    _isHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return size.width > 500 ? OverlayPortal(
      controller: _portalController,
      overlayChildBuilder: (BuildContext context) => _isHovered.value
          ? Positioned(
        right: 0,
        top: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              width: 100,
              child: BorderButton(
                onClick: () {
                  auth.logout().then((value) {
                    if (value) {
                      auth.userLogInStatus == false;
                      auth.user.id = -1;
                      CustomSnackBar.showSnackBar(
                          context: context,
                          message: 'Successfully LogOut',
                          color: MyColor.mtMainGreen);

                      Navigator.of(context)
                          .pushNamed('/LoginScreen');
                    } else {
                      CustomSnackBar.showSnackBar(
                          context: context,
                          message: 'Something went wrong',
                          color: MyColor.red);
                    }
                  });
                },
                text: 'Log Out',
                icon: Icons.logout_rounded,
              ),
            ),
          ),
        ),
      )
          : const SizedBox.shrink(),
      child: InkWell(
        onHover: (hovering) {
          _isHovered.value = hovering;
          if (hovering) {
            _portalController.show();
          } else {
            /// delay to click logout
            // Future.delayed(const Duration(seconds: 2), () {
            //   _portalController.hide();
            // });

            Future.delayed(const Duration(seconds: 2), () {
              if (!_isHovered.value) {
                _portalController.hide();
              }
            });



          }
        },
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UserProfileScreen()));
        },
        child: Material(
          color: _isHovered.value ? Colors.grey : Colors.transparent,
          child: SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.person,
                  size: 30,
                ),
                Text(
                  'Accounts \n & Orders',
                  style: TextDesign().bnbButtonText,
                ),
              ],
            ),
          ),
        ),
      ),
    )
    /// for mobile screen
        : InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserProfileScreen()));
      },
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.person,
                size: 25,
              ),
              Text(
                'Orders',
                style: TextDesign().bnbButtonText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
