// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weloggerweb/products/colors.dart';
import 'package:weloggerweb/products/responsive.dart';
import 'package:weloggerweb/services/services.dart';

class BuildOnboard extends StatelessWidget {
  final ImageProvider<Object> image;
  final String header;
  final String text;
  final nextPage;
  final bool? isViewed;
  final int index;
  const BuildOnboard(
      {Key? key,
      required this.image,
      required this.header,
      required this.text,
      required this.nextPage,
      required this.index,
      this.isViewed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(gradient: ProjectColors.gradient()),
                child: Container(
                  width: SizeConfig.screenWidth!,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: image,
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstIn),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            Container(
              height: 200,
              color: ProjectColors.themeColorMOD3,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: FittedBox(
                        child: Text(
                      header,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.none,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ))),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(text,
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center)),
                AnimatedSmoothIndicator(
                  activeIndex: index,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      spacing: 4,
                      activeDotColor: Colors.orange,
                      dotColor: Colors.white.withOpacity(0.2),
                      dotWidth: 8,
                      dotHeight: 8),
                ),
                GestureDetector(
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: SizeConfig.screenWidth!,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.orange,
                        ),
                        child: Center(
                            child: Text(
                          'Continue',
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontSize: 18,
                          ),
                        ))),
                    onTap: () async {
                      if(isViewed!){
                        await _storeOnBoardInfo();
                      }
                      Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => nextPage),(route) => false);}),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

_storeOnBoardInfo() async {
  CookieManager.addToCookie('isviewed', true);
}
