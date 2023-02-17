import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../Values/space_width_widget.dart';
import '../../../../../../../generated/l10n.dart';
import '../cubit/guest_cubit.dart';


Widget headerWidgetGuestList(BuildContext context,bool isEdit){
  return Row(
    children: [
      InkWell(
          onTap: (){
            if(isEdit){
              context.read<GuestCubit>().editGuest();
            }else{
              Navigator.pop(context);
            }
          },
          child: const Icon(Icons.arrow_back,size: 25)),
      spaceWidthWidget(10),
       Text(isEdit == true ? S.of(context).edit  : S.of(context).addAttendeesHeader,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)
    ],
  );
}