import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/styles/font.dart';
import 'package:insta_clone/viewmodels/login_view_model.dart';
import 'package:insta_clone/views/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../components/button_with_icon.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) {
            return model.isLoading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).appTitle,
                        style: loginTitleTextStyle,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      ButtonWithIcon(
                        iconData: FontAwesomeIcons.rightToBracket,
                        label: S.of(context).signIn,
                        onPressed: () => login(context),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  login(BuildContext context) async {
    final loginViewModel = context.read<LoginViewModel>();
    await loginViewModel.signIn();
    if (!loginViewModel.isSuccessful) {
      Fluttertoast.showToast(msg: S.of(context).signInFailed);
      return;
    }
    _openHomeScreen(context);
  }

  void _openHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );
  }
}
