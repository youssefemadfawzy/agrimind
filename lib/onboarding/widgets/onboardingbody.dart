import 'package:agrimind/features/auth/peresentation/views/welcome_screen.dart';
import 'package:agrimind/onboarding/state_management/onboarding_cubit.dart' show OnboardingCubit;
import 'package:agrimind/onboarding/widgets/onboarding1.dart';
import 'package:agrimind/onboarding/widgets/onboarding2.dart';
import 'package:agrimind/onboarding/widgets/onboarding3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocListener, WatchContext;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingBodyView extends StatefulWidget {
  const OnboardingBodyView({super.key});

  @override
  State<OnboardingBodyView> createState() => _OnboardingBodyViewState();
}

class _OnboardingBodyViewState extends State<OnboardingBodyView> {
  final PageController _controllerpage = PageController();

  @override
  void dispose() {
    _controllerpage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocListener <OnboardingCubit, int> (
      listener: (context, state)
      {
        _controllerpage.animateToPage(
            state,
            duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut );
        if (state == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const WelcomeScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              /// PageView
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controllerpage,
                onPageChanged: (index) {
                  context.read<OnboardingCubit>().changePage(index);
                },
                children: const [
                  Onboarding1(),
                  Onboarding2(),
                  Onboarding3(),
                ],
              ),
      
              /// Indicator
              Positioned(
                bottom: height * 0.25,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    effect: const WormEffect(
                      dotColor: Color(0xffcccccc),
                      activeDotColor: Color(0xff2977ff),
                    ),
                    controller: _controllerpage,
                    count: 3,
                  ),
                ),
              ),
      
              /// Continue Button
              Positioned(
                bottom: height * 0.15,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      final cubit = context.read<OnboardingCubit>();

                      if (cubit.isLastPage()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WelcomeScreen(),
                          ),
                        );
                      } else {
                        cubit.nextPage();
                      }
                    },
                    child: Container(
                      width: width * 0.85,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff337eff),
      
      
                          ),
                        ],
                      ),
                      child: const Center(
                        child:  Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      
              /// Skip Button
              Positioned(
                bottom: height * 0.09,
                right: 0,
                left: 0,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      context.read<OnboardingCubit>().skip();
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: context.watch<OnboardingCubit>().state == 0
                            ? Colors.blue
                            : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}