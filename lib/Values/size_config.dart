import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  void getCurrentOrientation(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      _mediaQueryData = MediaQuery.of(context);
      screenWidth = _mediaQueryData!.size.width;
      screenHeight = _mediaQueryData!.size.height;
      blockSizeHorizontal = screenWidth! / 100;
      blockSizeVertical = screenHeight! / 100;
      _safeAreaHorizontal =
          _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
      _safeAreaVertical =
          _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
      safeBlockHorizontal = screenWidth! - _safeAreaHorizontal! / 100;
      safeBlockVertical = screenHeight! - _safeAreaVertical! / 100;
      /* print('screenWidth $screenWidth');
      print('screenHeight $screenHeight');
      print('blockSizeHorizontal $blockSizeHorizontal');
      print('blockSizeVertical $blockSizeVertical');
      print('safeBlockHorizontal $safeBlockHorizontal');
      print('safeBlockVertical $safeBlockVertical');*/

      // is portrait
    } else {
      _mediaQueryData = MediaQuery.of(context);
      screenWidth = _mediaQueryData!.size.width;
      screenHeight = _mediaQueryData!.size.height;
      blockSizeHorizontal = screenWidth! / 100;
      blockSizeVertical = screenHeight! / 100;
      _safeAreaVertical =
          _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
      _safeAreaHorizontal =
          _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
      safeBlockHorizontal = screenHeight! - _safeAreaVertical! / 100;
      safeBlockVertical = screenWidth! - _safeAreaHorizontal! / 100;

// is landscape
    }
  }
}
