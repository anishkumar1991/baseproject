import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/widgets/header_widget_edit_shakti_kendra.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/widgets/selected_booth.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/icons.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../generated/l10n.dart';
import 'cubit/edit_shakti_kendr_cubit.dart';

class EditShaktiKendraScreen extends StatefulWidget {
  const EditShaktiKendraScreen({Key? key}) : super(key: key);

  @override
  State<EditShaktiKendraScreen> createState() => _EditShaktiKendraScreenState();
}

class _EditShaktiKendraScreenState extends State<EditShaktiKendraScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditShaktiKendrCubit>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              spaceHeightWidget(10),
              headerWidgetEditShaktiKendra(context),
              spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
                        builder: (context, state) {
                          return ListTile(
                            horizontalTitleGap: 8,
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  builder: (builder) {
                                    return bottom(
                                      context: context,
                                      cubit: cubit,
                                      list: cubit.partyzilaList,
                                      selectedVar: cubit.zilaSelected,
                                      text: S.of(context).vidhanSabha,
                                    );
                                  }).then((value) {
                                cubit.zilaSelected = value;
                              });
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              height: 47,
                              width: 47,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                    colors: [
                                      AppColor.purple50,
                                      AppColor.orange200,
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: Image.asset(AppIcons.vidhanSabha),
                            ),
                            title: Text(
                              S.of(context).vidhanSabha,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            subtitle: Text(
                              cubit.zilaSelected,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            trailing: const SizedBox(
                              height: double.infinity,
                              child: Icon(
                                Icons.expand_more,
                                color: AppColor.textBlackColor,
                                size: 24,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: AppColor.black,
                        thickness: 1,
                      ),
                      spaceHeightWidget(10),
                      ListTile(
                          horizontalTitleGap: 8,
                          tileColor: AppColor.pravasCradColor.withOpacity(0.3),
                          dense: true,
                          contentPadding: EdgeInsets.only(left: 5),
                          leading: Container(
                            height: 47,
                            width: 47,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                  colors: [
                                    AppColor.purple50,
                                    AppColor.orange200,
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Image.asset(AppIcons.vidhanSabha),
                          ),
                          title: Text(
                            S.of(context).enterShaktiKendrName,
                            style: GoogleFonts.poppins(
                                color: AppColor.black700,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          subtitle: SizedBox(
                            height: 20,
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  hintText: S.of(context).shaktikendr,
                                  isDense: true
                              ),
                            ),
                          )
                      ),
                      spaceHeightWidget(10),
                      BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
                        builder: (context, state) {
                          return ListTile(
                            horizontalTitleGap: 8,
                            onTap: () async {
                              await showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  builder: (builder) {
                                    return bottom(
                                      context: context,
                                      cubit: cubit,
                                      selectedVar: cubit.mandalSelected,
                                      list: cubit.partyzilaList,
                                      text: S.of(context).mandal,
                                    );
                                  }).then((value){
                                cubit.mandalSelected = value;
                              });
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              height: 47,
                              width: 47,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                    colors: [
                                      AppColor.purple50,
                                      AppColor.orange200,
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: Image.asset(AppIcons.mandal),
                            ),
                            title: Text(
                              S.of(context).mandal,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            subtitle: Text(
                              cubit.mandalSelected,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            trailing: const SizedBox(
                              height: double.infinity,
                              child: Icon(
                                Icons.expand_more,
                                color: AppColor.textBlackColor,
                                size: 24,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: AppColor.black,
                        thickness: 1,
                      ),
                      spaceHeightWidget(10),
                      BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
                        builder: (context, state) {
                          return ListTile(
                            horizontalTitleGap: 8,
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  builder: (builder) {
                                    return bottom(
                                      context: context,
                                      cubit: cubit,
                                      selectedVar: cubit.boothSelected,
                                      list: cubit.partyzilaList,
                                      text: S.of(context).buth,
                                    );
                                  }).then((value){
                                cubit.boothSelected = value;
                              });
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              height: 47,
                              width: 47,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                    colors: [
                                      AppColor.purple50,
                                      AppColor.orange200,
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: Image.asset(AppIcons.booth),
                            ),
                            title: Text(
                              S.of(context).buth,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            subtitle: Text(
                              cubit.boothSelected,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            trailing: SizedBox(
                              height: double.infinity,
                              child: const Icon(
                                Icons.expand_more,
                                color: AppColor.textBlackColor,
                                size: 24,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: AppColor.black,
                        thickness: 1,
                      ),
                      spaceHeightWidget(10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          S.of(context).selectedBooth,
                          style: GoogleFonts.poppins(
                              color: AppColor.naturalBlackColor, fontSize: 16,fontWeight: FontWeight.w500),
                        ),
                      ),
                      spaceHeightWidget(10),
                      SelectedBooth(title: 'Govt. Senior Secondary Girls High',subTitle: "High School",leadingText: '102',onClose: (){}),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  bottom(
      {required BuildContext context,
        required EditShaktiKendrCubit cubit,
        required String selectedVar,
        required List list,
        required String text}) {
    return Container(
      color: Colors.transparent,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceHeightWidget(10),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColor.borderColor),
                  ),
                ),
                spaceHeightWidget(30),
                Text(
                  text ?? '',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: AppColor.borderColor, fontSize: 16),
                ),
                spaceHeightWidget(30),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                selectedVar = list[index];
                                cubit.emitState();
                                Navigator.pop(context, selectedVar);
                              },

                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  list[index] ?? '',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      color: AppColor.black, fontSize: 16),
                                ),
                              ),
                            ),
                            spaceHeightWidget(15),
                            const Divider(
                              color: AppColor.borderColor,
                            ),
                            spaceHeightWidget(15),
                          ],
                        );
                      }),
                )
              ],
            ),
          )),
    );
  }
}
