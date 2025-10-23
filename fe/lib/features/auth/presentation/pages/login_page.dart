import 'package:fe/core/theme/app_palette.dart';
import 'package:fe/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      'https://plus.unsplash.com/premium_photo-1671379086168-a5d018d583cf?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZnJ1aXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&q=60&w=600',
                      fit: BoxFit.fitHeight,
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GFAppBar(
                        backgroundColor: AppPalette.transparentColor,
                        elevation: 0,
                        title: const Text(
                          "Welcome",
                          style: TextStyle(
                            color: AppPalette.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        centerTitle: true,
                        leading: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppPalette.whiteColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      GFCard(
                        margin: const EdgeInsets.all(0),
                        color: AppPalette.whiteColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        elevation: 1,
                        boxFit: BoxFit.cover,
                        content: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Welcome back!",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const Text(
                                "Sign in to your account",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppPalette.greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(
                                    color: AppPalette.greyColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: _obscureText ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: AppPalette.greyColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GFToggle(
                                        onChanged: (value) {},
                                        value: true,
                                        enabledThumbColor: AppPalette.darkColor,
                                        enabledTrackColor: AppPalette.gradient3,
                                      ),
                                      const Text(
                                        "Remember me",
                                        style: TextStyle(
                                          color: AppPalette.greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: AppPalette.gradient1,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppPalette.darkColor,
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: AppPalette.whiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        SignupPage.route(),
                                      );
                                    },
                                    child: Text(
                                      " Sign Up",
                                      style: TextStyle(
                                        color: AppPalette.darkColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}
