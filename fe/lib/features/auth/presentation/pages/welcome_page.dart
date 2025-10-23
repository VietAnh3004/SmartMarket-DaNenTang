import 'package:fe/core/theme/app_palette.dart';
import 'package:fe/features/auth/presentation/pages/login_page.dart';
import 'package:fe/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WelcomePage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (_) => const WelcomePage());
  const WelcomePage({super.key});

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
                      'https://plus.unsplash.com/premium_photo-1686878946810-ea2517431d46?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8Zm9vZCUyMG1hcmtldHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&q=60&w=600',
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Welcome",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "JQK Market 2025 created by Trần Đức An",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppPalette.greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              GFButton(
                                onPressed: () {},
                                text: "Continue with Google",
                                icon: const Image(
                                  image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAODSrOYhUv2R2FW1iCqccTM1TQyHoesAnbA&s',
                                  ),
                                  width: 20,
                                  height: 20,
                                ),
                                color: Colors.white,
                                textColor: Colors.black87,
                                fullWidthButton: true,
                                shape: GFButtonShape.pills,
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                                size: GFSize.LARGE,
                              ),
                              const SizedBox(height: 10),
                              GFButton(
                                onPressed: () {
                                  Navigator.push(context, SignupPage.route());
                                },
                                text: "Create an account",
                                color: AppPalette.darkColor,
                                fullWidthButton: true,
                                shape: GFButtonShape.pills,
                                size: GFSize.LARGE,
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account? ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        LoginPage.route(),
                                      );
                                    },
                                    child: Text(
                                      "Login",
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
