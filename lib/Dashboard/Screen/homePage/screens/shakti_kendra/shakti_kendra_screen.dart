import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/widgets/header_widget_shakti_kendra.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/widgets/shimmer_widget.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../Storage/user_storage_service.dart';
import '../../../../../Values/app_colors.dart';
import '../../../../../Values/space_height_widget.dart';
import '../../../../../Values/space_width_widget.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../common/common_button.dart';
import '../../../../../generated/l10n.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/network/model/shakti_kendr_model.dart';
import 'cubit/shakti_kendra_cubit.dart';

class ShaktiKendraScreen extends StatefulWidget {
  const ShaktiKendraScreen({Key? key}) : super(key: key);

  @override
  State<ShaktiKendraScreen> createState() => _ShaktiKendraScreenState();
}

class _ShaktiKendraScreenState extends State<ShaktiKendraScreen> {
  void initState() {
    apiCall();
    super.initState();
  }

  apiCall() {
    context.read<ShaktiKendraCubit>().getDropDownValueOfVidhanSabha(
        id: StorageService.userData!.user!.countryStateId!);
  }

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
                      cubit.zilaSelectedName,
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

              /// filter
              filter(),

              spaceHeightWidget(15),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: BlocConsumer<ShaktiKendraCubit, ShaktiKendraState>(
                    listener: (BuildContext context, Object? state) {
                      if (state is ShaktiKendraErrorState) {
                        EasyLoading.showError(state.error);
                      }
                    },
                    builder: (BuildContext context, state) {
                      if (state is LoadingShaktiKendraState) {
                        return const ShimmerWidget();
                      } else if (state is ShaktiKendraFatchData) {
                        if (state.data.data != null) {
                          cubit.shaktiKendr = state.data;
                        }
                      }
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: cubit.shaktiKendr.data?.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildBottomContainer(
                              // mandalName: "- अटल विहारी वाजपई",
                              // booths: "123, 124, 128, 234, 112, 123, 273,193",
                              data: cubit.shaktiKendr.data![index],
                              // onDelete: () {
                              //   dataEntryDeleteDialog(
                              //       mandalName: "अटल विहारी वाजपई");
                              // },
                              // onEdit: () {
                              //   Navigator.pushNamed(
                              //       context, RoutePath.editShaktiKendraScreen,
                              //       arguments: {'isEdit': true});
                              // }
                            );
                          });
                    },
                  ),
                ),
              ),
              spaceHeightWidget(15),
              CommonButton(
                  borderRadius: 10,
                  title: S.of(context).makeShaktikendr,
                  onTap: () {
                    Navigator.pushNamed(
                        context, RoutePath.editShaktiKendraScreen,
                        arguments: {'isEdit': false});
                  },
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

  buildBottomContainer({required Data data}) {
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
                "${S.of(context).mandal} - ${data.mandal?.name}",
                style: GoogleFonts.poppins(
                    color: AppColor.naturalBlackColor, fontSize: 12),
              ),
              trailing: InkWell(
                onTap: () {},
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
                          data.booths?.length.toString() ?? '0',
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
                  onTap: () {
                    dataEntryDeleteDialog(
                        mandalName: data.mandal?.name ?? '', id: data.id);
                  },
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
              InkWell(
                onTap: () {
                  cubit.isExpanded = !cubit.isExpanded;
                  cubit.emitState();
                },
                child: Row(
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
                    Icon(
                      !cubit.isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up_sharp,
                      color: AppColor.naturalBlackColor,
                    )
                  ],
                ),
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

  dataEntryDeleteDialog(
      {String? mandalName,
      int? id,
      ShaktiKendraCubit? cubit,
      int? index}) async {
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("${S.of(context).deletrShaktiKendrTitle}?",
                          textAlign: TextAlign.left,
                          style: textStyleWithPoppin(
                              fontSize: 16,
                              color: AppColor.black.withOpacity(0.9),
                              fontWeight: FontWeight.w400)),
                    ),
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
                              onTap: (() {
                                print("delete");
                                Navigator.pop(context);
                                context
                                    .read<ShaktiKendraCubit>()
                                    .deleteShaktiKendr(id: id!);
                              }),
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
                spaceHeightWidget(30),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: AppColor.borderColor, fontSize: 16),
                ),
                spaceHeightWidget(30),
                Expanded(
                  child: vidhanSabha.data?.locations?.isNotEmpty ?? false
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: vidhanSabha.data?.locations?.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.zilaSelected =
                                        vidhanSabha.data?.locations?[index];
                                    cubit.zilaSelectedName = vidhanSabha
                                            .data?.locations?[index].name ??
                                        '';
                                    cubit.getShaktiKendra(
                                        id: cubit.zilaSelected?.id ?? 357);
                                    cubit.emitState();
                                    Navigator.pop(context);
                                  },
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      vidhanSabha
                                              .data?.locations?[index].name ??
                                          '',
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
                          })
                      : Text(
                          S.of(context).noDataAvailable,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              color: AppColor.black, fontSize: 16),
                        ),
                )
              ],
            ),
          )),
    );
  }
}
