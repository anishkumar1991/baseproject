import 'package:flutter/material.dart';

import 'entry_detail_list.dart';

class NewEntryFilterPage extends StatelessWidget {
  NewEntryFilterPage({
    Key? key,
    this.type,
    this.dataLevelId,
    this.countryStateId,
  }) : super(key: key);
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
