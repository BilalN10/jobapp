import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/constants.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('About us'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                'This app aims to provide Nepali citizens with information on the latest foreign job vacancies. All vacancies are from official sources and are updated daily. We are pleased to display job openings in our app. Our goal is to provide users with access to valuable job opportunities. ',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Source of Information:',
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
                ' We would like to assure our users that all job openings are obtained from official sources. Our listings include comprehensive information about the job, recruiter, and agency. ',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Application Process:',
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
                'If you are interested in applying for a job you see on the app, please contact the recruiter or agent directly. We would like to clarify that the app is not involved in the application process.',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Endorsement :',
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
                'We want to make it clear that the app does not endorse any specific company, recruiter, or agent mentioned in our listings. We encourage our users to make informed decisions when selecting a company, recruiter, or agent. ',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Conclusion  :',
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
                'To summarize, we offer job openings in our app that come from official sources and provide comprehensive information. We do not endorse any specific company, recruiter, or agent and encourage our users to make their own informed decisions. We hope you take advantage of the job opportunities presented in our app.',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'If you have any suggestions, please feel free to contact us at:',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'baideshikrojgar.np@gmail.com',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      )),
                    ),
                    Text(
                      '9822798699',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                        // decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      )),
                    ),
                    Text(
                      'Kalopul, Kathmandu',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                        // decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      )),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
