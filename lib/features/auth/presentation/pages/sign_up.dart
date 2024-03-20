import 'package:blog_app/core/animations/fade_in_slide.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/consts/colors.dart';
import 'package:blog_app/core/consts/text.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/backgroun_image_container.dart';
import 'package:blog_app/features/auth/presentation/widgets/custom_rich_text.dart';
import 'package:blog_app/features/auth/presentation/widgets/emailvaliadte.dart';
import 'package:blog_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:blog_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (ctx) => const SignInScreen());
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key
  bool isEmailCorrect = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImageContainer(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }else if (state is AuthSuccess) {
                  Navigator.pushAndRemoveUntil(
                      context, HomePage.route(), (route) => false);
                }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingAnimation();
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 150, right: 240, bottom: 15, left: 32),
                  child: FadeInSlide(
                    duration: .4,
                    child: Text('Sign up', style: AppText.kStyle1Bold),
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
                          blurRadius: 10, // Adjust the blur radius
                        ),
                      ],
                    ),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          FadeInSlide(
                            duration: .5,
                            child: CustomRichText(
                                title:
                                    'Looks like you don’t have an account.                                        ',
                                subtitle: 'Let’s create a new account for you.',
                                subtitleTextStyle: TextStyle(
                                  color: AppColor.kLightAccentColor,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                                onTab: () {}),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          FadeInSlide(
                            duration: .6,
                            child: AuthField(
                              hintText: 'Name',
                              controller: nameController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
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
                            duration: .8,
                            child: AuthField(
                              hintText: 'Your Password',
                              controller: passController,
                              keyboardType: TextInputType.visiblePassword,
                              isForgetButton: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password should be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FadeInSlide(
                            duration: .9,
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: TextStyle(
                                  color: AppColor.kLightAccentColor,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  const TextSpan(
                                    text:
                                        ' By selecting Create Account below,  ',
                                  ),
                                  const TextSpan(
                                    text: ' I agree to        ',
                                  ),
                                  TextSpan(
                                    text: '     Terms of Service',
                                    style: TextStyle(
                                      color: AppColor.kPrimary,
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' & ',
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy  ',
                                    style: TextStyle(
                                      color: AppColor.kPrimary,
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FadeInSlide(
                            duration: 1,
                            child: PrimaryButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                      AuthSignUpPreesedEvent(
                                          emailController.text.trim(),
                                          passController.text.trim(),
                                          nameController.text.trim()));
                                }
                              },
                              borderRadius: 8,
                              fontSize: 14,
                              height: 48,
                              width: 326,
                              text: 'Create Account',
                              textColor: AppColor.kWhiteColor,
                              bgColor: AppColor.kPrimary,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          FadeInSlide(
                            duration: 1.1,
                            child: CustomRichText(
                              subtitle: ' Log in',
                              title: 'Already have an account?',
                              subtitleTextStyle: TextStyle(
                                color: AppColor.kPrimary,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                              onTab: () {
                                Navigator.push(context, SignUpScreen.route());
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
          );
        },
      ),
    ));
  }
}
