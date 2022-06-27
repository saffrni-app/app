import 'dart:ui';

class LightColors {
  static const Color pp = Color(0xffdd8e58);
  static const Color aa = Color(0xffffdd9a);
  static const Color bb = Color(0xff0e1e52);
  static const Color cc = Color(0xff7da9f4);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff262626);
  static const Color black3 = Color(0xff9e9e9e);
  static const Color grey = Color(0xffe0e0e0);
  static const Color green = Color(0xff1b5e20);
  static const Color grey2 = Color(0xff616161);
  static const Color blue = Color(0xff2962ff);
 // Colors.grey[200]
}

class DarkColors {
  static const Color aa = Color(0xff262626);
  static const Color bb = Color(0xff777777);

}

class ColorFilters {
  static final greyscale = ColorFilter.matrix(<double>[
    0.2126,0.7152,0.0722,0,0,
    0.2126,0.7152,0.0722,0,0,
    0.2126,0.7152,0.0722,0,0,
    0,0,0,0,0,
  ]);
}