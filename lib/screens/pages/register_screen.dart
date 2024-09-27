import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lingoassignment/constants/k_colors.dart';
import 'package:lingoassignment/constants/k_spacing.dart';
import 'package:lingoassignment/constants/k_text_style.dart';
import 'package:lingoassignment/screens/pages/home_screen.dart';
import 'package:lingoassignment/screens/pages/login_screen.dart';
import 'package:lingoassignment/screens/widgets/news_button.dart';
import 'package:lingoassignment/screens/widgets/news_text_field.dart';
import 'package:provider/provider.dart';
import 'package:lingoassignment/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
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
        elevation: 0,
        backgroundColor: AppColors.accentColor,
        automaticallyImplyLeading: false,
        title: Text('MyNews',
            style: appBarStyle.copyWith(color: AppColors.primaryColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.spacingBase),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              NewsTextField(
                hint: "Name",
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid name";
                  }
                  return null;
                },
              ),
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
              const Spacer(flex: 3),
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
                              .signUp(emailController.text,
                                  passwordController.text, nameController.text)
                              .then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          }).catchError((e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Registration Failed: $e')),
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
                              "Register",
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
                        text: 'Already have an account? ',
                        style: buttonTextStyle.copyWith(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Login',
                            style: buttonSecondryTextStyle.copyWith(
                                color: AppColors.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
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
