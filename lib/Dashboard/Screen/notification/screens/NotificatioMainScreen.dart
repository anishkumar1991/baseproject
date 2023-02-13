import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'CircularScreen.dart';
import 'NotificationScreen.dart';
import 'ReportScreen.dart';
import 'package:intl/intl.dart';

class NotificationMainScreen extends StatefulWidget {
  const NotificationMainScreen({Key? key}) : super(key: key);

  @override
  State<NotificationMainScreen> createState() => _NotificationMainScreenState();
}

class _NotificationMainScreenState extends State<NotificationMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/images/notificationBackIcon.png",
              height: 16.74,
              width: 20,
            )),
        title: Text("Notification",
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColor.notificationTextColor)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, right: 20),
            child: InkWell(
              onTap: () async {
                DateTime? datePicked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime.now());

                print(
                    "today date ${DateFormat("d MMMM").format(DateTime.now())}");
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFFD5EDFA),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Image.asset(
                        "assets/images/notificationDateIcon.png",
                        width: 12,
                        height: 13.33,
                      ),
                      const SizedBox(width: 9),
                      Text(
                        "Filter by Date",
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF333333)),
                      ),
                      const SizedBox(width: 14),
                    ],
                  )),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: TabBar(
                      unselectedLabelColor: const Color(0xFF666666),
                      indicator: BoxDecoration(
                        color: const Color(0xFF447EFF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      controller: tabController,
                      tabs: [
                        Tab(
                          child: Text(
                            "Circular",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Report",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Notification",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  CircularScreen(),
                  ReportScreen(),
                  NotificationScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
