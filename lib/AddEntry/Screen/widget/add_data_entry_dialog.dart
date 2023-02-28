import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Values/app_colors.dart';
import '../../../common/appstyle.dart';
import '../../../common/common_button.dart';
import '../../../generated/l10n.dart';
import '../../Cubit/add_entry_cubit.dart';
import '../../network/model/add_entry_data_model.dart';

class AddDataEntryDialog extends StatefulWidget {
  final AddDataEntryModel addDataEntryModel;

  const AddDataEntryDialog({Key? key, required this.addDataEntryModel}) : super(key: key);

  @override
  State<AddDataEntryDialog> createState() => _AddDataEntryDialogState();
}

class _AddDataEntryDialogState extends State<AddDataEntryDialog> {
  @override
  Widget build(BuildContext context) {
    bool isDuplicateEntry =
        (widget.addDataEntryModel.duplication == true) && (widget.addDataEntryModel.showForceSubmit == false);
    bool isForceEntry =
        (widget.addDataEntryModel.duplication == true) && (widget.addDataEntryModel.showForceSubmit == true);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          (isForceEntry)
              ? Text("${widget.addDataEntryModel.message1 ?? ""} ${widget.addDataEntryModel.message2 ?? ""}",
                  style: textStyleWithPoppin(fontSize: 16, color: AppColor.black, fontWeight: FontWeight.w400))
              : const SizedBox(),
          (isDuplicateEntry)
              ? Text(widget.addDataEntryModel.message ?? "",
                  style: textStyleWithPoppin(fontSize: 16, color: AppColor.black, fontWeight: FontWeight.w400))
              : const SizedBox(),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 250),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.addDataEntryModel.data?.length ?? 0,
              itemBuilder: (context, index) {
                var entryData = widget.addDataEntryModel.data?[index];
                return commonListTile(
                    name: entryData?.name ?? "",
                    designation: "${entryData?.designation ?? ""} ${entryData?.unit ?? ""} ${entryData?.subUnit ?? ""}",
                    location: "${entryData?.level ?? ""} - ${entryData?.location ?? ""}",
                    no: index + 1);
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      (S.of(context).cancel),
                      style: const TextStyle(color: AppColor.red, fontSize: 16),
                    )),
              ),
              const SizedBox(width: 10),
              isForceEntry
                  ? Expanded(
                      child: CommonButton(
                        onTap: (() {
                          Navigator.pop(context);
                          final cubit = context.read<AddEntryCubit>();
                          cubit.pressAddEntrySubmitButton(isComeFromForceUpdate: true);
                        }),
                        padding: const EdgeInsets.all(12),
                        title: S.of(context).continueText,
                        borderRadius: 10,
                        style: GoogleFonts.quicksand(color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    )
                  : const SizedBox()
            ],
          )
        ]),
      ),
    );
  }

  Widget commonListTile(
      {required int no, required String name, required String location, required String designation}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.boothContainerColour),
      width: double.infinity,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$no. ",
            style: textStyleWithPoppin(fontSize: 16, color: AppColor.white, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 25),
          child: Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            color: AppColor.addEntryTileColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: textStyleWithPoppin(fontSize: 15, color: AppColor.black, fontWeight: FontWeight.w400)),
                    Text(location,
                        style: textStyleWithPoppin(fontSize: 12, color: AppColor.black, fontWeight: FontWeight.w400)),
                    Text(designation,
                        style: textStyleWithPoppin(fontSize: 12, color: AppColor.orange, fontWeight: FontWeight.w400)),
                  ]),
            ),
          ),
        )
      ]),
    );
  }
}
