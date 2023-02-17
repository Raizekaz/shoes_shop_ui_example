import 'package:flutter/cupertino.dart';
import 'package:shoes_shop_ui/resources/resources.dart';

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
      'title': 'Первая страница',
      'text': 'Описание первой страницы',
      'image': AppImages.onboardingOne,
    },
    {
      'title': 'Вторая страница',
      'text': 'Описание второй страницы',
      'image': AppImages.onboardingTwo,
    },
    {
      'title': 'Третья страница',
      'text': 'Описание третьей страницы',
      'image': AppImages.onboardingThree,
    },
  ];

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoPageScaffold Sample'),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: PageView.builder(
                controller: controller,
                onPageChanged: (value) => setState(() {
                      currentPage = value;
                    }),
                itemCount: contentData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: const [],
                  );
                }),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(flex: 2),
                      Row(
                        children: List.generate(contentData.length,
                            (index) => buildDot(index: index)),
                      ),
                      const Spacer(),
                      // Container(
                      //   child: currentPage == 4
                      //       ? TextButton(
                      //           onPressed: () {
                      //             setState(() {
                      //               toHomePage();
                      //             });
                      //           },
                      //           child: const Text('Done'),
                      //         )
                      //       : TextButton(
                      //           onPressed: () {
                      //             setState(() {
                      //               controller.jumpToPage(4);
                      //             });
                      //           },
                      //           child: const Text('Skip'),
                      //         ),
                      // ),
                    ],
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
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? const Color(0xFFBA68C8)
            : const Color(0xFFBC68F8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
