import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PrvacyPolicy extends StatelessWidget {
  const PrvacyPolicy({Key? key}) : super(key: key);

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
        title: Text('Privacy policy'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                'Privacy policy ',
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
                'Baideshik Rojgar built the Baideshik Rojgar app as an Ad Supported app. This SERVICE is provided by Baideshik Rojgar at no cost and is intended for use as is.This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Baideshik Rojgar unless otherwise defined in this Privacy Policy.',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Information Collection and Use',
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
                'For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Name , Email , IP address , Phone No, . The information that I request will be retained on your device and is not collected by me in any way.The app does use third-party services that may collect information used to identify you.Link to the privacy policy of third-party service providers used by the app',
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
                'Log Data ',
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
                'want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Cookies',
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
                "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Service Providers ',
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
                "I may employ third-party companies and individuals due to the following reasons:",
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
                    serviceTile('To facilitate our Service;', context),
                    serviceTile(
                        'To provide the Service on our behalf;', context),
                    serviceTile(
                        'To perform Service-related services; or', context),
                    serviceTile(
                        'To assist us in analyzing how our Service is used.',
                        context),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Security ',
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
                "I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Links to Other Sites ',
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
                "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Children’s Privacy',
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
                "These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Changes to This Privacy Policy',
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
                "I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.This policy is effective as of 2023-05-05",
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
                "If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at bai.ro.nepal@gmail.com.",
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

  Row serviceTile(String text, BuildContext context) {
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
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: Text(
            text,
            maxLines: 2,
            style: GoogleFonts.plusJakartaSans(
                textStyle: const TextStyle(
              fontSize: 16,
            )),
          ),
        )
      ],
    );
  }
}
