import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../attendeesformpage/cubit/FetchCubit.dart';
import '../../attendeesformpage/cubit/FetchStates.dart';
import '../../attendeesformpage/screens/CustomDD.dart';

class EditableDropDown extends StatefulWidget {
  final String vidhanSabhaPreFilled;
  final String boothPreFilled;
  const EditableDropDown({Key? key, required this.vidhanSabhaPreFilled, required this.boothPreFilled}) : super(key: key);

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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: CustomDropDown(
                  title: "विधान सभा *",

                  selectedValue: cubit.vidhanSabhaSelected,
                  hintText: 'विधान सभा का चयन करें',
                  dropDownList: cubit.acList
                      .map((e) =>
                      DropdownMenuItem(value: e, child: Text(e.name)))
                      .toList(),

                  onChange: ((value) {
                    cubit.onChangeVidhanSabha(value!);
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: CustomDropDown(
                  title: "बूथ *",
                  selectedValue: cubit.boothSelected,
                  hintText: 'बूथ चुनें',
                  dropDownList: cubit.boothList
                      .map((e) =>
                      DropdownMenuItem(value: e, child: Text(e.name)))
                      .toList(),
                  onChange: ((value) {
                    cubit.onChangeBooth(value!);
                  }),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
