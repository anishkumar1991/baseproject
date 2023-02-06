import 'package:flutter/material.dart';

import '../BottomSocialBar.dart';

class Polls extends StatelessWidget {
  const Polls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE6E6E6), width: 1)),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 19),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Peoples Poll',
                style: TextStyle(
                    fontFamily: "Tw Cen MT",
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Who will win the 2024 Elections?',
                style: TextStyle(
                    fontFamily: "Tw Cen MT",
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Color(0xFF666666)),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(

                  shrinkWrap: true,
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: ((context, index) => SizedBox(height: 8)),
                  itemBuilder: ((context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              value: index == 2 ? true : false,

                              onChanged: ((value) {})),
                          const Text('BJP',
                              style: TextStyle(
                                  fontFamily: 'Tw Cen MT',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey))
                        ],
                      ),
                    );
                  })),
              SizedBox(height: 10),
             // BottomSocialBar(),
            ],
          ),
        ),
      ),
    );
  }
}
