

import 'package:flutter/material.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/zila_data_page/widget/entry_detail_list.dart';

class DesignationFilterPage extends StatelessWidget {
   DesignationFilterPage({ Key? key,
    this.type,
    this.dataLevelId,
    this.countryStateId,
    }):super(key: key);
final String? type;
  final int? dataLevelId;
  final int? countryStateId;
  @override
  Widget build(BuildContext context) {
    return EntryDetailsList(
      type: type,
      dataLevelId: dataLevelId,
      countryStateId: countryStateId,
    );
  }
}