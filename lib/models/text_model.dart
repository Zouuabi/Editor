import 'dart:ui';

class TextModel {
  TextModel(
      {this.data = 'Double Tap To Edit Me !',
      required this.fontFamily,
      required this.fontSize,
      this.isSelected = false,
      required this.color}) {
    id = ++lastId;
  }
  late final int id;
  String data;
  String fontFamily;
  double fontSize;
  bool isSelected;
  Color color;
  static int lastId = -1;
}
