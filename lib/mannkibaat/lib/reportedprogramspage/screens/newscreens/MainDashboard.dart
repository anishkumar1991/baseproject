import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Storage/mannkibaat.dart';

import '../../../../../Storage/user_storage_service.dart';
import '../../../generateauthtoken/cubit/SendCubit.dart';
import '../../../utils/appbar/AppBar.dart';
import 'expired.dart';
import 'ongoing.dart';

class DashboardMainScreen extends StatefulWidget {
  const DashboardMainScreen({super.key});

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Future<void> send() async {
    final cubit = context.read<GenerateMannKiBaatAuthCubit>();
    var number = StorageService.getUserData();
    await cubit.sendOtp(mobileNumber: number!.user!.phone.toString());
    await cubit.submitOTP();
  }

  @override
  void initState() {
    send();
    tabController = TabController(length: 2, vsync: this);
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
      appBar: AppBarWidget.getAppBar(_key, context),
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
                            "OnGoing",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Expired",
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
                  OnGoing(),
                  Expired(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
