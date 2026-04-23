import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/constants/text_style.dart';
import 'package:restep/common/widgets/typography.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/widgets/button_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  void nextPage() {
    if (currentPage < 2) {
      _controller.animateToPage(
        currentPage + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.green10,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          leading: Container(),
        ),
        body: Stack(
          children: [
            Image.asset(ImageAsset.blur),
            Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() => currentPage = index);
                    },
                    children: [
                      buildPage("Transparency", "Verified material data. No assumptions."),
                      buildPage(
                        "Circular Impact",
                        "Your actions return materials to the system.",
                      ),
                      buildPage("Earn from Recycling", "Old shoes become points — and new value."),
                    ],
                  ),
                ),
      
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // Skip button
                      if (currentPage != 2)
                        Expanded(
                          child: SizedBox(
                            height: 42,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                overlayColor: WidgetStatePropertyAll(
                                  ConstColors.green,
                                ),
                                side: WidgetStatePropertyAll(
                                  BorderSide(color: ConstColors.green),
                                ), 
                                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)))
                              ),
                              onPressed: () {
                                _controller.jumpToPage(2);
                              },
                              child: BodyText.dflt(
                                "Skip",
                                color: ConstColors.green,
                              ),
                            ),
                          ),
                        ),
      
                      if (currentPage != 2) SizedBox(width: 10),
      
                      // Next / Get Started
                      Expanded(
                        child: ButtonWidget.basicText(
                          currentPage == 2 ? "Lets Started" : "Next",
                          backgroundColor: ConstColors.green,
                          textColor: ConstColors.white,
                          action: nextPage,
                        ),
                      ),
                    ],
                  ),
                ),
      
                SizedBox(height: 30),
              ],
            ),
      
                // Indicator dots
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: EdgeInsets.all(4),
                        width: currentPage == index ? 10 : 6,
                        height: currentPage == index ? 10 : 6,
                        decoration: BoxDecoration(
                          color: currentPage == index ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget buildPage(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset(ImageAsset.welcomeFirst, width: double.infinity ,),
          ),
          SizedBox(height: 50),
          Text(
            title,
            style: TextStyleConstants.textStyleHeadingH1XxLargeBold.copyWith(fontSize: 30),
          ),
          SizedBox(height: 10),
          Text(subtitle, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
