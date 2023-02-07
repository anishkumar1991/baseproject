import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/widgets/header_widget_shakti_kendra.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/route/route_path.dart';
import '../../../../../Values/app_colors.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../Values/space_width_widget.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../common/common_button.dart';
import '../../../../../generated/l10n.dart';
import 'cubit/shakti_kendra_cubit.dart';

class ShaktiKendraScreen extends StatefulWidget {
  const ShaktiKendraScreen({Key? key}) : super(key: key);

  @override
  State<ShaktiKendraScreen> createState() => _ShaktiKendraScreenState();
}

class _ShaktiKendraScreenState extends State<ShaktiKendraScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ShaktiKendraCubit>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceHeightWidget(10),
              headerWidgetShaktiKendra(context),
              spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
              BlocBuilder<ShaktiKendraCubit, ShaktiKendraState>(
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
                              text: S.of(context).vidhanSabha,
                            );
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

              /// filter
              filter(),

              spaceHeightWidget(15),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 7,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildBottomContainer(
                            mandalName: "- अटल विहारी वाजपई",
                            booths: "123, 124, 128, 234, 112, 123, 273,193",
                            onDelete: () {
                              dataEntryDeleteDialog(
                                  mandalName: "अटल विहारी वाजपई");
                            },
                            onEdit: () {
                              Navigator.pushNamed(
                                  context, RoutePath.editShaktiKendraScreen);
                            });
                      }),
                ),
              ),
              spaceHeightWidget(15),
              CommonButton(
                  borderRadius: 10,
                  title: S.of(context).makeShaktikendr,
                  style:
                      GoogleFonts.poppins(color: AppColor.white, fontSize: 14),
                  padding: const EdgeInsets.symmetric(vertical: 10)),
              spaceHeightWidget(15),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownLocation() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).vidhanSabha,
            style: GoogleFonts.poppins(
                color: AppColor.black700,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          BlocConsumer<ShaktiKendraCubit, ShaktiKendraState>(
            listener: ((context, state) {}),
            builder: (context, state) {
              final cubit = BlocProvider.of<ShaktiKendraCubit>(context);
              return DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isDense: true,
                      hint: Text('भोपाल',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                              fontSize: 16)),
                      value: cubit.zilaSelected,
                      icon: const Icon(
                        Icons.expand_more,
                        color: AppColor.textBlackColor,
                        size: 24,
                      ),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColor.textBlackColor),
                      isExpanded: true,
                      items: cubit.partyzilaList
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              )))
                          .toList(),
                      onChanged: ((value) async {
                        cubit.onChnageZila(value);
                      })));
            },
          ),
        ],
      ),
    );
  }

  buildBottomContainer(
      {String? mandalName,
      String? booths,
      VoidCallback? onEdit,
      VoidCallback? onDelete}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.dividerColor),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            ListTile(
              horizontalTitleGap: 8,
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.16),
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
                child: Image.asset(AppIcons.shaktikendraImage),
              ),
              title: Text(
                S.of(context).shaktikendr,
                style: GoogleFonts.poppins(color: AppColor.black, fontSize: 14),
              ),
              subtitle: Text(
                "${S.of(context).mandal} $mandalName",
                style: GoogleFonts.poppins(
                    color: AppColor.naturalBlackColor, fontSize: 12),
              ),
              trailing: InkWell(
                onTap: onEdit,
                child: Container(
                  height: 38,
                  width: 38,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.16),
                      color: AppColor.dividerColor.withOpacity(0.5)),
                  child: const Icon(Icons.mode_edit_outlined,
                      color: AppColor.black),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.dividerColor.withOpacity(0.5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Booths",
                            style: GoogleFonts.poppins(
                                color:
                                    AppColor.naturalBlackColor.withOpacity(0.6),
                                fontSize: 12),
                          ),
                          Container(
                            color: AppColor.naturalBlackColor.withOpacity(0.5),
                            width: 40,
                            height: 1,
                          )
                        ],
                      ),
                      spaceWidthWidget(10),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5,
                        ),
                        child: Text(
                          booths ?? '',
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.poppins(
                              color: AppColor.black, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onDelete,
                  child: Container(
                    height: 38,
                    width: 38,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.16),
                        color: AppColor.dividerColor.withOpacity(0.5)),
                    child:
                        const Icon(Icons.delete_outline, color: AppColor.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  filter() {
    return BlocBuilder<ShaktiKendraCubit, ShaktiKendraState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<ShaktiKendraCubit>(context);
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.pravasCradColor.withOpacity(0.3)),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.filter_list,
                    color: AppColor.naturalBlackColor,
                    size: 22,
                  ),
                  spaceWidthWidget(10),
                  Text(
                    S.of(context).filter,
                    style: GoogleFonts.poppins(
                        color: AppColor.naturalBlackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        cubit.isExpanded = !cubit.isExpanded;
                        cubit.emitState();
                      },
                      child: Icon(
                        !cubit.isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up_sharp,
                        color: AppColor.naturalBlackColor,
                      ))
                ],
              ),
              spaceHeightWidget(cubit.isExpanded ? 10 : 0),
              cubit.isExpanded
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.filterList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                cubit.isSelectedIndex = index;
                                cubit.changeFilter();
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width * 0.25,
                                // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: cubit.isSelectedIndex == index
                                        ? AppColor.blue.withOpacity(0.8)
                                        : AppColor.white,
                                    border: Border.all(
                                        color: cubit.isSelectedIndex == index
                                            ? Colors.transparent
                                            : AppColor.dividerColor)),
                                child: Center(
                                  child: Text(
                                    cubit.filterList[index],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: cubit.isSelectedIndex == index
                                            ? AppColor.white
                                            : AppColor.naturalBlackColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }

  dataEntryDeleteDialog({String? mandalName}) async {
    showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${S.of(context).deletrShaktiKendrTitle}?",
                        textAlign: TextAlign.left,
                        style: textStyleWithPoppin(
                            fontSize: 16,
                            color: AppColor.black.withOpacity(0.9),
                            fontWeight: FontWeight.w400)),
                    spaceHeightWidget(10),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "$mandalName\n${S.of(context).deleteShaktiKendr}",
                          style: textStyleWithPoppin(
                              fontSize: 14, color: AppColor.greyColor),
                        )),
                    spaceHeightWidget(
                        MediaQuery.of(context).size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CommonButton(
                              onTap: (() {
                                Navigator.pop(context);
                              }),
                              bordercolor: AppColor.primaryColor,
                              backGroundcolor: AppColor.white,
                              title: S.of(context).cancel,
                              borderRadius: 10,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColor.primaryColor)),
                        ),
                        spaceWidthWidget(15),
                        Expanded(
                          child: CommonButton(
                              onTap: (() {}),
                              borderRadius: 10,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              bordercolor: AppColor.red,
                              backGroundcolor: AppColor.red,
                              title: S.of(context).delete,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColor.white)),
                        ),
                      ],
                    )
                  ],
                ),
              ));
        }));
  }

  bottom(
      {required BuildContext context,
      required ShaktiKendraCubit cubit,
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
                      itemCount: cubit.partyzilaList.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                cubit.zilaSelected = cubit.partyzilaList[index];
                                cubit.emitState();
                                Navigator.pop(context);
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  cubit.partyzilaList[index] ?? '',
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
