import 'package:carousel_slider/carousel_slider.dart';
import 'package:education_app/widgets/welcome_step.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  final CarouselSliderController _sliderControl = CarouselSliderController();
  final List<int> sliders = [1, 2, 3];
  int currentSlider = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _getTitle(int step) {
    switch (step) {
      case 1:
        return "Welcome to Educatory";
      case 2:
        return "Live Session with Teachers";
      case 3:
        return "Engage with Quizzes";
      default:
        return "";
    }
  }

  String _getDescription(int step) {
    switch (step) {
      case 1:
        return "Your go-to platform for live sessions and on-demand courses. We're excited to help you learn and grow!";
      case 2:
        return "Join live with top teachers. Session-based study with real-time feedback and support.";
      case 3:
        return "Test your knowledge with interactive quizzes. Track your progress and reinforce your learning!";
      default:
        return "";
    }
  }

  String _getImagePath(int step) {
    switch (step) {
      case 1:
        return 'assets/images/welcome_0.svg';
      case 2:
        return 'assets/images/welcome_1.svg';
      case 3:
        return 'assets/images/welcome_2.svg';
      default:
        return '';
    }
  }

  void nextSlider(int index) async {
    if (index == sliders.length) {
      _redirectLogin();
      return;
    }

    _sliderControl.animateToPage(index);
    setState(() => currentSlider = index);
  }

  void _redirectLogin() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [HexColor('#E7D5FF'), Colors.white],
                    stops: const [0.0, 0.8],
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: CarouselSlider(
                      items: sliders.map((step) {
                        return WelcomeStep(
                          imagePath: _getImagePath(step),
                          title: _getTitle(step),
                          description: _getDescription(step),
                        );
                      }).toList(),
                      carouselController: _sliderControl,
                      options: CarouselOptions(
                        height: double.infinity,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index, reason) async {
                          setState(() => currentSlider = index);
                        },
                      ),
                    ),
                  ),

                  AnimatedSmoothIndicator(
                    activeIndex: currentSlider,
                    count: sliders.length,
                    onDotClicked: (index) {
                      nextSlider(index);
                    },
                    effect: ExpandingDotsEffect(
                      activeDotColor: HexColor('#9547ED'),
                      dotColor: Colors.grey.shade300,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 🔘 Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: _redirectLogin,
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(width * 0.4, 50),
                          side: BorderSide(color: HexColor('#9547ED')),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          foregroundColor: HexColor('#9547ED'),
                          overlayColor: HexColor('#9547ED').withOpacity(0.1),
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => nextSlider(currentSlider + 1),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * 0.4, 50),
                          backgroundColor: HexColor('#9547ED'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}