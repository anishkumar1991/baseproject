import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Storage/mannkibaat.dart';
import 'package:sangathan/generated/l10n.dart';
import 'package:sangathan/mannkibaat/lib/values/AppColors.dart';

import '../../../../../Storage/user_storage_service.dart';
import '../../../generateauthtoken/cubit/SendCubit.dart';
import '../../../generateauthtoken/cubit/SendState.dart';
import 'expired.dart';
import 'ongoing.dart';

class DashboardMainScreen extends StatefulWidget {
  // const DashboardMainScreen({super.key});

  const DashboardMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  // final GlobalKey<ScaffoldState> _key = GlobalKey();

  Future<void> send() async {
    final cubit = context.read<GenerateMannKiBaatAuthCubit>();
    var number = StorageService.getUserData();
    print(MKBStorageService.getUserAuthToken());
    if (MKBStorageService.getUserAuthToken() == null) {
      await cubit.sendOtp(mobileNumber: number!.user!.phone.toString());
      await cubit.submitOTP();
    }
  }

  Future<void> adduser() async {
    final cubit = context.read<GenerateMannKiBaatAuthCubit>();
    var number = StorageService.getUserData();
    await cubit.addUser(number!.user!.name.toString());
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
      appBar: AppBar(
          backgroundColor: AppColor().appBarColor,
          title: Text("भारतीय जनता पार्टी",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 10.91,
                  color: AppColor().textColor)),
          centerTitle: true,
          leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0),
      body:
          BlocBuilder<GenerateMannKiBaatAuthCubit, GenerateMannKiBaatAuthState>(
        builder: (context, state) {
          if (state is UserLoginSuccessfullyState) {
            return Padding(
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
                                  S.of(context).ongoing,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  S.of(context).expired,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
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
            );
          } else if (state is NewUserState) {
            adduser();
          }

          return MKBStorageService.getUserAuthToken() != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black12, width: 1.5),
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
                                      S.of(context).ongoing,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Tab(

                                    child: Text(
                                      S.of(context).expired,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
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
                )
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("कृपया प्रतीक्षा करें"),
                  ],
                ));
        },
      ),
    );
  }
}
