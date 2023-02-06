import 'package:flutter/material.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/widgets/header_widget_edit_shakti_kendra.dart';

import '../../../../../../Values/space_height_widget.dart';

class EditShaktiKendraScreen extends StatefulWidget {
  const EditShaktiKendraScreen({Key? key}) : super(key: key);

  @override
  State<EditShaktiKendraScreen> createState() => _EditShaktiKendraScreenState();
}

class _EditShaktiKendraScreenState extends State<EditShaktiKendraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              spaceHeightWidget(10),
              headerWidgetEditShaktiKendra(context),
              spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
