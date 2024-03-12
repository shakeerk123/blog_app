import 'package:blog_app/core/animations/fade_in_slide.dart';
import 'package:blog_app/core/consts/asset_path.dart';
import 'package:blog_app/core/consts/colors.dart';
import 'package:blog_app/core/consts/text.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/backgroun_image_container.dart';
import 'package:blog_app/features/auth/presentation/widgets/divider_row.dart';
import 'package:blog_app/features/auth/presentation/widgets/emailvaliadte.dart';
import 'package:blog_app/features/auth/presentation/widgets/primaries.dart';
import 'package:blog_app/features/auth/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_rich_text.dart';
import '../widgets/primary_button.dart';

// ignore: must_be_immutable
class SignInScreen extends StatefulWidget {
  static route()=>  MaterialPageRoute(builder: (ctx)=>const SignUpScreen());
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key
  bool isEmailCorrect = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImageContainer(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 150, right: 263, bottom: 15, left: 32),
                    child: FadeInSlide(
                      duration: 0.4,
                      child: Text('Log in', style: AppText.kStyle1Bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: 358,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.kSamiDarkColor.withOpacity(0.4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.kSamiDarkColor.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            FadeInSlide(
                              duration: .5,
                              child: AuthField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                isFieldValidated: isEmailCorrect,
                                onChanged: (value) {
                                  setState(() {});
                                  isEmailCorrect = validateEmail(value);
                                },
                                hintText: 'Your Email',
                                validator: (value) {
                                  if (!validateEmail(value!)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            FadeInSlide(
                              duration: .6,
                              child: AuthField(
                                hintText: 'Your Password',
                                controller: passController,
                                keyboardType: TextInputType.visiblePassword,
                                isForgetButton: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            FadeInSlide(
                              duration: .7,
                              child: PrimaryButton(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {}
                                },
                                borderRadius: 8,
                                fontSize: 14,
                                height: 48,
                                width: 326,
                                text: 'Continue',
                                textColor: AppColor.kWhiteColor,
                                bgColor: AppColor.kPrimary,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            FadeInSlide(
                              duration: .8,
                              child: PrimaryTextButton(
                                title: 'Forgot password?',
                                fontSize: 14,
                                onPressed: () {
                                  // Forgot password logic
                                },
                                textColor: AppColor.kPrimary,
                              ),
                            ),
                            const SizedBox(height: 32),
                            const FadeInSlide(
                                duration: .9, child: DividerRow()),
                            const SizedBox(height: 32),
                            FadeInSlide(
                              duration: 1.0,
                              child: SecondaryButton(
                                onTap: () {
                                  // Login with Facebook logic
                                },
                                borderRadius: 8,
                                fontSize: 14,
                                height: 48,
                                width: 326,
                                text: 'Login with Facebook',
                                textColor: AppColor.kBlackColor,
                                bgColor: AppColor.kLightAccentColor,
                                icons: AppImagePath.kLogoFacebook,
                              ),
                            ),
                            const SizedBox(height: 16),
                            FadeInSlide(
                              duration: 1.1,
                              child: SecondaryButton(
                                onTap: () {
                                  // Login with Google logic
                                },
                                borderRadius: 8,
                                fontSize: 14,
                                height: 48,
                                width: 326,
                                text: 'Login with Google',
                                textColor: AppColor.kBlackColor,
                                bgColor: AppColor.kLightAccentColor,
                                icons: AppImagePath.kGoogleLogo,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            FadeInSlide(
                              duration: 1.2,
                              child: CustomRichText(
                                subtitle: ' Sign up ',
                                title: 'Don’t have an account?',
                                subtitleTextStyle: TextStyle(
                                  color: AppColor.kPrimary,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                                onTab: () {
                                  Navigator.push(context,SignInScreen.route());
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            )));
  }
}
