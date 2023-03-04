import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../attendeesformpage/cubit/FetchCubit.dart';
import '../../attendeesformpage/cubit/FetchStates.dart';
import '../../attendeesformpage/network/model/VidhanSabhaModel.dart';
import '../../attendeesformpage/screens/CustomDD.dart';

class EditableDropDown extends StatefulWidget {
  final String vidhanSabhaPreFilled;
  final String boothPreFilled;

  const EditableDropDown(
      {Key? key,
      required this.vidhanSabhaPreFilled,
      required this.boothPreFilled})
      : super(key: key);

  @override
  State<EditableDropDown> createState() => _EditableDropDown();
}

class _EditableDropDown extends State<EditableDropDown> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchCubit>();
    cubit.fetchAcId();

    return Container(
      color: Colors.white,
      child: BlocConsumer<FetchCubit, FetchStates>(
        listener: (context, state) {
          if (state is FetchedState) {
            cubit.boothSelected = null;
            cubit.vidhanSabhaSelected = null;
            cubit.acList = state.model.data;
          } else if (state is BoothFetchedState) {
            cubit.boothList = state.model.data;
          }
        },
        builder: (context, state) {
          print("hello i am ${cubit.vidhanSabhaSelected}");

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomDropDown(
                title: "विधान सभा *",
                selectedValue: cubit.vidhanSabhaSelected,
                hintText: widget.vidhanSabhaPreFilled,
                dropDownList: cubit.acList
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChange: ((value) {
                  cubit.onChangeVidhanSabha(value!);
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropDown(
                title: "बूथ *",
                selectedValue: cubit.boothSelected,
                hintText: widget.boothPreFilled,
                dropDownList: cubit.boothList
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChange: ((value) {
                  cubit.onChangeBooth(value!);
                }),
              )
            ],
          );
        },
      ),
    );
  }
}
