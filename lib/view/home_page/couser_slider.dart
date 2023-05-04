import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: Get.height * 0.20,
          width: Get.width,
          child: CarouselSlider(
            items: [
              for (int i = 0; i < 3; i++)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: const Color(0xff00CC9A),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, color: Colors.black12)
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Let's find a job, your\n dream",
                                  style: GoogleFonts.plusJakartaSans(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: Adaptive.h(4.5),
                                  width: Adaptive.w(35),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    'Read More',
                                    style: GoogleFonts.plusJakartaSans(
                                        textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff00CC9A),
                                    )),
                                  ),
                                )
                              ],
                            ),
                            Image.asset(
                              'assets/icons/boy_image.svg',
                            )
                          ],
                        ),
                      )),
                ),
            ],
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              viewportFraction: 1,
              autoPlay: true,
            ),
          ),
        ),
        Positioned(
          bottom: Get.height * 0.01,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                      color: currentIndex == i
                          ? const Color(0xff959595)
                          : Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
