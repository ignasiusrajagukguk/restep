import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/widgets/separator_widget.dart';
import 'package:restep/common/widgets/text_form_field.dart';
import 'package:restep/common/widgets/typography.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/dashboard/main_screen.dart';
import 'package:restep/presentation/widgets/button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  bool isEmail = true;
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.green10,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          leading: Container(),
        ),
        body: Stack(
          children: [
            Image.asset(ImageAsset.blur),
            Padding(
              padding: const EdgeInsets.only(top: 100, right: 15, left: 15),
              child: isEmail ? emailWidget() : passwordWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Column emailWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(ImageAsset.logoNew, height: 100,)),
        SeparatorWidget.height30(),
        SeparatorWidget.height20(),
        Heading.h2XLarge('Sign in to your\nAccount'),
        SeparatorWidget.height15(),
        BodyText.small(
          'Enter your email and password to log in',
          color: ConstColors.grayMedium20,
        ),
        SeparatorWidget.height15(),
        TextFormFieldWidget.height42('Email address'),
        SeparatorWidget.height20(),
        ButtonWidget.basicText(
          'Next',
          action: () {
            setState(() {
              isEmail = false;
            });
          },
          backgroundColor: ConstColors.green,
          textColor: ConstColors.white,
        ),
        Row(
          children: [
            Expanded(child: Container(height: 1, color: ConstColors.grayLight)),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 3,
                vertical: 10,
              ),
              child: BodyText.small('or', color: ConstColors.grayMedium20),
            ),
            Expanded(child: Container(height: 1, color: ConstColors.grayLight)),
          ],
        ),

        ButtonWidget.basicWidget(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Image.asset(IconsAsset.google),
              BodyText.dflt('Continue with Google', color: ConstColors.black),
            ],
          ),
          backgroundColor: ConstColors.white,
        ),
        SeparatorWidget.height10(),
        ButtonWidget.basicWidget(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Image.asset(IconsAsset.facebook),
              BodyText.dflt('Continue with Facebook', color: ConstColors.black),
            ],
          ),
        ),
      ],
    );
  }

  Column passwordWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(ImageAsset.logoNew, height: 100,)),
        SeparatorWidget.height30(),
        SeparatorWidget.height20(),
        Heading.h2XLarge('Sign in to your\nAccount'),
        SeparatorWidget.height15(),
        BodyText.small(
          'Enter your email and password to log in',
          color: ConstColors.grayMedium20,
        ),
        SeparatorWidget.height15(),
        TextFormFieldWidget.height42('Password'),
        SeparatorWidget.height20(),
        ButtonWidget.basicText(
          'Login',
          action: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
              (route) => true,
            );
          },
          backgroundColor: ConstColors.green,
          textColor: ConstColors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isRememberMe,
                  onChanged: (value) {
                    setState(() {
                      isRememberMe = !isRememberMe;
                    });
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  activeColor: ConstColors.green,
                ),
                BodyText.small('Remember me', color: ConstColors.grayMedium20),
              ],
            ),
            BodyText.smallBold(
              'Forgot password?',
              color: ConstColors.green,
              decoration: TextDecoration.underline,
            ),
          ],
        ),

        Row(
          children: [
            Expanded(child: Container(height: 1, color: ConstColors.grayLight)),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 3,
                vertical: 10,
              ),
              child: BodyText.small('or', color: ConstColors.grayMedium20),
            ),
            Expanded(child: Container(height: 1, color: ConstColors.grayLight)),
          ],
        ),

        ButtonWidget.basicWidget(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Image.asset(IconsAsset.google),
              BodyText.dflt('Continue with Google', color: ConstColors.black),
            ],
          ),
          backgroundColor: ConstColors.white,
        ),
        SeparatorWidget.height10(),
        ButtonWidget.basicWidget(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Image.asset(IconsAsset.facebook),
              BodyText.dflt('Continue with Facebook', color: ConstColors.black),
            ],
          ),
        ),
      ],
    );
  }
}
