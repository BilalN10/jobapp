import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsandConditionPage extends StatelessWidget {
  const TermsandConditionPage({Key? key}) : super(key: key);
  void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Term and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                'Terms & Conditions',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Baideshik Rojgar.Baideshik Rojgar is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.The Baideshik Rojgar app stores and processes personal data that you have provided to us, to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Baideshik Rojgar app won’t work properly or at all.The app does use third-party services that declare their Terms and Conditions.Link to Terms and Conditions of third-party service providers used by the app",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    linkTile('Google Play Services',
                        'https://www.google.com/policies/privacy/'),
                    const SizedBox(
                      height: 4,
                    ),
                    linkTile('AdMob',
                        'https://support.google.com/admob/answer/6128543?hl=en'),
                    const SizedBox(
                      height: 4,
                    ),
                    linkTile('Google Analytics for Firebase',
                        'https://firebase.google.com/policies/analytics'),
                    const SizedBox(
                      height: 4,
                    ),
                    linkTile('Firebase Crashlytics',
                        'https://firebase.google.com/support/privacy/')
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "You should be aware that there are certain things that Baideshik Rojgar will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Baideshik Rojgar cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              Text(
                "If you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              Text(
                "Along the same lines, Baideshik Rojgar cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Baideshik Rojgar cannot accept responsibility.",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "With respect to Baideshik Rojgar’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Baideshik Rojgar accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              Text(
                "At some point, we may wish to update the app. The app is currently available on Android – the requirements for the system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Baideshik Rojgar does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Changes to This Terms and Conditions',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page.These terms and conditions are effective as of 2023-05-05",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Contact Us',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at bai.ro.nepal@gmail.com.",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Row linkTile(String text, String url) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            launchURL(url);
          },
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
                textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            )),
          ),
        )
      ],
    );
  }
}
