import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../Utils/AppColor.dart';
import 'FormFilled.dart';
import 'FormPage.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           const SizedBox(
                height: 56,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('जानकारी भरे ',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, color: AppColor().textcolor5),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FormPage()));
                      },
                      child: Image.asset('assets/images/mannkibaat/image6.png')),
                ],
              ),
            const  SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'विधानसभा :',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w300),
                      ),
                   const   SizedBox(
                        height: 4,
                      ),
                      Text(
                        'रुद्रपुर',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColor().textcolor9,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'कुल उपस्थित लोग  :',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w300),
                      ),
                    const  SizedBox(
                        height: 4,
                      ),
                      Text(
                        '120',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColor().textcolor9,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
             const SizedBox(
                height: 24,
              ),
              Text(
                'बूथ :',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
             const SizedBox(
                height: 4,
              ),
              Text(
                '120 - गर्ल्स प्राइमरी स्कूल, किच्छा बाईपास रोड,',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColor().textcolor9,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'रुद्रपुर',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColor().textcolor9,
                    fontWeight: FontWeight.w500),
              ),
             const SizedBox(
                height: 24,
              ),
              Text(
                'पता :',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
            const  SizedBox(
                height: 4,
              ),
              Text(
                '43- ग्राम - खेड़ा, रुद्रपुर, उधम सिंह ',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColor().textcolor9,
                    fontWeight: FontWeight.w500),
              ),
             const SizedBox(
                height: 24,
              ),
              Text(
                'विवरण :',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
             const SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 120,
                width: 340,
                child: Text(
                  'प्रधानमंत्री नरेंद्र मोदी \' मन की बात \' कार्यक्रम के माध्यम से देश को संबोधित किया। उन्होंने कहा, G-20 की अध्यक्षता, हमारे लिए एक बड़ा मौका बनकर आई है। हमें इस मौके का पूरा उपयोग करते हुए विश्व कल्याण पर ध्यान केंद्रित करना है।',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColor().textcolor9,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'फोटो :',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(children: [
               const  SizedBox(width: 20,),
                Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/mannkibaat/image8.png'),
                    fit: BoxFit.cover,
                  )),
                ),
               const  SizedBox(
                  width: 20,
                ),
                Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/mannkibaat/image7.png'),
                    fit: BoxFit.cover,
                  )),
                ),
              ]),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(AppColor().buttoncolor),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormFilled()));
                    },
                    child: Text(
                      "सबमिट",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
