import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<LandingPage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> builderPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.black54,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Column(
            children: [
              // skip button
              Padding(
                padding: const EdgeInsets.only(left: 270, top: 20),
                child: TextButton(
                  onPressed: () {},
                  child: const Positioned(
                    top: 20,
                    right: 20,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ),
              ),
              // Screen Page
              Container(
                height: 600,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    ScreenView(0, 'Connect people\naround the world',
                        'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'),
                    ScreenView(1, 'Connect people\naround the world',
                        'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'),
                    ScreenView(2, 'Connect people\naround the world',
                        'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'),
                  ],
                ),
              ),
              //Indicator

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 150),
                child: Row(
                  children: builderPageIndicator(),
                ),
              ),

              _currentPage != 2
                  ? InkWell(
                      onTap: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 300.0, top: 100),
                        child: Row(
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Text(''),
            ],
          ),
        ),
        bottomSheet: _currentPage == 2
            ? Container(
              
                height: 80,
                width: double.infinity,
                child: const Center(
                  child: Text(
                    'Get started',
                    style: TextStyle(
                        color: Color.fromARGB(255, 91, 16, 231),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : const Text(''),
      ),
    );
  }
}

Widget ScreenView(int num, String title, String desc) {
  return Column(
    children: [
      const SizedBox(
        height: 30,
      ),
      ImageOption(num),
      const SizedBox(
        height: 30,
      ),
      const Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 180.0),
              child: Text(
                'Connect people\naround the world',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.only(left: 36.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget ImageOption(int num) {
  if (num == 0)
    return Image(
      image: AssetImage('assets/img/onboarding0.png'),
      height: 300,
      width: 300,
    );
  else if (num == 1)
    return Image(
      image: AssetImage('assets/img/onboarding1.png'),
      height: 300,
      width: 300,
    );
  else
    return Image(
      image: AssetImage('assets/img/onboarding2.png'),
      height: 300,
      width: 300,
    );
}
