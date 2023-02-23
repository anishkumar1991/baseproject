import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/mannkibaat/lib/attendeesformpage/cubit/FetchStates.dart';

import '../../../attendeesformpage/cubit/FetchCubit.dart';
import '../../../attendeesformpage/screens/CustomDD.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchCubit>();
    cubit.fetchAcId();
    return BlocBuilder<FetchCubit, FetchStates>(
      builder: (context, state) {
        if (state is FetchedState) {
          cubit.boothSelected = null;
          cubit.vidhanSabhaSelected = null;
          cubit.acList = state.model.data;
        } else if (state is BoothFetchedState) {
          cubit.boothList = state.model.data;
        }
        return Column(
          children: [
            Text("Enter Details"),
            Container(
              child: CustomDropDown(
                title: "विधान सभा",
                selectedValue: cubit.vidhanSabhaSelected,
                hintText: 'विधान सभा का चयन करें',
                dropDownList: cubit.acList
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.name ?? '')))
                    .toList(),
                onChange: ((value) {
                  cubit.onChangeVidhanSabha(value!);
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
