import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Values/space_height_widget.dart';

class ImagePickerBottomSheet extends StatelessWidget {
 const ImagePickerBottomSheet(
      {Key? key, required this.onTapCamera, required this.onTapGallery})
      : super(key: key);
 final GestureTapCallback onTapCamera;
 final GestureTapCallback onTapGallery;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose',
                style: GoogleFonts.quicksand(
                    fontSize: 20, fontWeight: FontWeight.w800),
              ),
              IconButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  icon: const Icon(
                    Icons.close,
                    size: 25,
                  ))
            ],
          ),
          const Divider(),
          ListTile(
            onTap:onTapCamera,
            //  (() {
            //   Navigator.pop(context);
            //   //cubit.requestPermission(ImageSource.camera);
            // }),
            title: Text(
              'Camera',
              style: GoogleFonts.quicksand(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const Divider(),
          ListTile(
            onTap:onTapGallery, 
            // (() {
            //   Navigator.pop(context);
            //   //cubit.requestPermission(ImageSource.gallery);
            // }),
            title: Text(
              'Gallery',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          const Divider(),
          spaceHeightWidget(20)
        ],
      ),
    );
  }
}
