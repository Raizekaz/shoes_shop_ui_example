import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_shop_ui/components/get_started_button_widget.dart';
import 'package:shoes_shop_ui/resources/resources.dart';
import 'package:shoes_shop_ui/routes/app_navigation.dart';
import 'package:shoes_shop_ui/themes/app_colors.dart';
import 'package:shoes_shop_ui/themes/app_text_styles.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    super.key,
  });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  List<Map<String, dynamic>> contentData = [
    {
      'title': 'Enjoy The New Arrival Product',
      'text':
          'Get your dream item easily and safely with Shoesly, and get other interesting offers',
      'image': AppImages.onboardingOne,
    },
    {
      'title': 'Guaranteed Safe Delivery',
      'text':
          'Get your dream item easily and safely with Shoesly, and get other interesting offers',
      'image': AppImages.onboardingTwo,
    },
    {
      'title': 'Good Arrived On Time',
      'text':
          'Get your dream item easily and safely with Shoesly, and get other interesting offers',
      'image': AppImages.onboardingThree,
    },
  ];

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            flex: 5,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (value) => setState(() {
                currentPage = value;
              }),
              itemCount: contentData.length,
              itemBuilder: (context, index) {
                return _ContentDataWidget(
                  contentData: contentData,
                  image: contentData[index]['image'],
                  title: contentData[index]['title'],
                  text: contentData[index]['text'],
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: List.generate(
                          contentData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GetStartedButtonWidget(
                    title: Text(
                      'GET STARTED',
                      style: AppTextStyles.fs16fw600white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    onTap: () =>
                        context.goNamed(NavigationRouteNames.signInScreen),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetStartedButtonWidget(
                          icon: AppIcons.google,
                          title: Text(
                            'GOOGLE',
                            style: AppTextStyles.fs16fw600,
                          ),
                          width: MediaQuery.of(context).size.width * 0.375,
                          color: AppColors.white,
                          padding: 14,
                          border: Border.all(color: AppColors.grey300),
                          onTap: () {},
                        ),
                        GetStartedButtonWidget(
                          icon: AppIcons.facebook,
                          title: Text(
                            'FACEBOOK',
                            style: AppTextStyles.fs16fw600,
                          ),
                          width: MediaQuery.of(context).size.width * 0.375,
                          color: AppColors.white,
                          padding: 14,
                          border: Border.all(color: AppColors.grey300),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(right: 5),
      height: 2,
      width: 60,
      decoration: BoxDecoration(
        color: currentPage >= index ? AppColors.black : AppColors.grey300,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _ContentDataWidget extends StatelessWidget {
  const _ContentDataWidget({
    required this.contentData,
    required this.image,
    required this.title,
    required this.text,
  });

  final List<Map<String, dynamic>> contentData;
  final String title;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyles.fs36fw600,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                text,
                style: AppTextStyles.fs16grey,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
