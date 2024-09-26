import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lingoassignment/constants/k_colors.dart';
import 'package:lingoassignment/constants/k_spacing.dart';
import 'package:lingoassignment/constants/k_text_style.dart';
import 'package:lingoassignment/providers/auth_provider.dart';
import 'package:lingoassignment/screens/pages/home_screen.dart';
import 'package:lingoassignment/screens/pages/register_screen.dart';
import 'package:lingoassignment/screens/widgets/news_button.dart';
import 'package:lingoassignment/screens/widgets/news_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('MyNews',
            style: appBarStyle.copyWith(color: AppColors.primaryColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              NewsTextField(
                controller: emailController,
                hint: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              NewsTextField(
                controller: passwordController,
                hint: "Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              const Spacer(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.spacingMacro),
                    child: NewsButton(
                      type: NewsButtonType.primary,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context
                              .read<AuthProvider>()
                              .signIn(
                                  emailController.text, passwordController.text)
                              .then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          }).catchError((e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Login Failed: $e')),
                            );
                          });
                        }
                      },
                      title: context.watch<AuthProvider>().isLoading
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Spacing.spacingSmall),
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.whiteColor),
                              ),
                            )
                          : Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: bodyTextStyle.copyWith(
                                  color: AppColors.whiteColor),
                            ),
                    ),
                  ),
                  NewsButton(
                    type: NewsButtonType.tertiary,
                    onPressed: null,
                    title: RichText(
                      text: TextSpan(
                        text: 'New here? ',
                        style: buttonTextStyle.copyWith(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Signup',
                            style: buttonSecondryTextStyle.copyWith(
                                color: AppColors.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
