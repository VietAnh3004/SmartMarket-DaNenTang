import 'package:fe/features/auth/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:fe/core/theme/app_palette.dart';
import 'package:getwidget/getwidget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late PageController _pageController;
  late List<Widget> slideList;
  late int initialPage;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GFIntroScreen(
        color: AppPalette.backgroundColor,
        slides: slides(),
        pageController: _pageController,
        currentIndex: initialPage,
        pageCount: slideList.length,
        introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
          pageController: _pageController,
          pageCount: slideList.length,
          currentIndex: initialPage,
          onForwardButtonTap: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
            );
          },
          onBackButtonTap: () {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
            );
          },
          navigationBarColor: AppPalette.transparentColor,
          showDivider: false,
          onDoneTap: () => Navigator.push(context, WelcomePage.route()),
          onSkipTap: () => Navigator.push(context, WelcomePage.route()),
          inactiveColor: AppPalette.primaryColor,
          activeColor: AppPalette.darkColor,
        ),
      ),
    );
  }

  List<Widget> slides() {
    slideList = [
      Container(
        child: GFImageOverlay(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          color: AppPalette.primaryColor,
          image: NetworkImage(
            'https://plus.unsplash.com/premium_photo-1671379086168-a5d018d583cf?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZnJ1aXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&q=60&w=600',
          ),
          boxFit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.darken,
          ),
          borderRadius: BorderRadius.circular(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 20),
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    color: AppPalette.whiteColor,
                    decoration: TextDecoration.none,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZnJ1aXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&q=60&w=600',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1618897996318-5a901fa6ca71?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjN8fGZydWl0fGVufDB8fDB8fHww&auto=format&fit=crop&q=60&w=600',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1517282009859-f000ec3b26fe?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGZydWl0fGVufDB8fDB8fHww&auto=format&fit=crop&q=60&w=600',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
      ),
    ];
    return slideList;
  }
}
