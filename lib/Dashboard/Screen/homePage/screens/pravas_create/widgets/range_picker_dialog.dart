import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../cubit/pravas_create_cubit.dart';

class RangePickerDialog extends StatelessWidget {

  const RangePickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PravasCreateCubit>(context);
    return Dialog(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SfDateRangePicker(
              showActionButtons: true,
              selectionMode: DateRangePickerSelectionMode.range,
              view: DateRangePickerView.year,
              onSubmit: (value) {
                cubit.temp = value as PickerDateRange;
                cubit.startDate = ddMMMYYYYfromDateTime(cubit.temp?.startDate ?? DateTime.now());
                cubit.endDate = ddMMMYYYYfromDateTime(cubit.temp?.endDate ?? DateTime.now());
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            )),
      ),
    );
  }
  static String ddMMMYYYYfromDateTime(DateTime date) {
    return DateFormat('dd/MMM/yyyy').format(date);
  }
}
