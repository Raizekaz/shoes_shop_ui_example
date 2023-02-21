import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_shop_ui/components/get_started_button_widget.dart';
import 'package:shoes_shop_ui/resources/resources.dart';
import 'package:shoes_shop_ui/routes/app_navigation.dart';
import 'package:shoes_shop_ui/themes/app_text_styles.dart';

class OnboardingDopScreen extends StatelessWidget {
  const OnboardingDopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Image.asset(
                  AppImages.onboardingDop,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome To The Club Of Shoesly!',
                        style: AppTextStyles.fs36fw600,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Text(
                        'Your account has been sucsell',
                        style: AppTextStyles.fs16fw500grey,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  GetStartedButtonWidget(
                    title: Text(
                      'GET STARTED',
                      style: AppTextStyles.fs16fw700white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    onTap: () =>
                        context.goNamed(NavigationRouteNames.mainScreen),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
