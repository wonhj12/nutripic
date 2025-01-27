import 'package:flutter/material.dart';

class Palette {
  /* Component colors */
  // /// #A8E6CF
  // static const Color primary = Color(0xFFA8E6CF);

  // /// #FB934E
  // static const Color secondary = Color(0xFFFB934E);

  // /// #296C53
  // static const Color sub = Color(0xFF296C53);

  // /// #296C53 alpha 0.1
  // static const Color subContainer = Color.fromRGBO(41, 108, 84, 0.1);

  /// #F1531A
  static const Color delete = Color(0xFFF1531A);

  // /// #FF6A41 alpha 0.1
  // static const Color deleteContainer = Color.fromRGBO(255, 106, 65, 0.1);

  /// #0F402D
  static const Color green950 = Color(0xFF0F402D);

  /// #1F644A
  static const Color green900 = Color(0xFF1F644A);

  /// #197C57
  static const Color green800 = Color(0xFF197C57);

  /// #209B6D
  static const Color green700 = Color(0xFF209B6D);

  /// #3AA980
  static const Color green600 = Color(0xFF3AA980);

  /// #48D4A0
  static const Color green500 = Color(0xFF48D4A0);

  /// #50E8AF
  static const Color green400 = Color(0xFF50E8AF);

  /// #68F1BE
  static const Color green300 = Color(0xFF68F1BE);

  /// #8EF6CF
  static const Color green200 = Color(0xFF8EF6CF);

  /// #C2F8E4
  static const Color green100 = Color(0xFFC2F8E4);

  /// #E4FBF3
  static const Color green50 = Color(0xFFE4FBF3);

  /// #F1FAF9
  // static const Color background = Color(0xFFF9F9FA);

  /* Label colors */
  // /// #252525
  // static const Color black = Color(0xFF252525);

  /// #252525
  static const Color gray900 = Color(0xFF252525);

  /// #2E3137
  static const Color gray800 = Color(0xFF2E3137);

  /// #444554
  static const Color gray700 = Color(0xFF444554);

  /// #5B5D6B
  static const Color gray600 = Color(0xFF5B5D6B);

  /// #777986
  static const Color gray500 = Color(0xFF777986);

  /// #9496A1
  static const Color gray400 = Color(0xFF9496A1);

  /// #BABDC5
  static const Color gray300 = Color(0xFFBABDC5);

  /// #DBDDE7
  static const Color gray200 = Color(0xFFDBDDE7);

  // /// #DBDDE7
  // static const Color gray150 = Color(0xFFDBDDE7);

  /// #F2F4F8
  static const Color gray100 = Color(0xFFF2F4F8);

  /// #FAFAFA
  static const Color gray50 = Color(0xFFFAFAFA);

  /// #FFFFFF
  static const Color gray00 = Color(0xFFFFFFFF);

  /* Text Styles */

  /// Font size: 24
  /// <br />Font weight: Bold
  static const TextStyle heading =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w700);

  /// Font size: 24
  /// <br />Font weight: Bold. Color: white
  // static const TextStyle headingWhite =
  //     TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white);

  /// Font size: 20
  /// <br />Font weight: Medium
  static const TextStyle title1Medium =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

  /// Font size: 20
  /// <br />Font weight: Semi Bold
  static const TextStyle title1SemiBold =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  /// Font size: 18
  /// <br />Font weight: Medium
  static const TextStyle title2Medium =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  /// Font size: 18
  /// <br />Font weight: Semi Bold
  static const TextStyle title2SemiBold =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  /// Font size: 16
  /// <br />Font weight: Medium
  static const TextStyle subtitle1Medium =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  /// Font size: 16
  /// <br />Font weight: Semibold
  static const TextStyle subtitle1SemiBold =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  /// Font size: 14
  /// <br />Font weight: Medium
  static const TextStyle subtitle2Medium =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  /// Font size: 14
  /// <br />Font weight: Semibold
  static const TextStyle subtitle2SemiBold =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  /// Font size: 16
  /// <br />Font weight: Regular
  static const TextStyle body1 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1);

  /// Font size: 14
  /// <br />Font weight: Regular
  static const TextStyle body2 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1);

  /// Font size: 13
  /// <br />Font weight: Regular
  static const TextStyle subbody1 =
      TextStyle(fontSize: 13, fontWeight: FontWeight.w400);

  /// Font size: 13
  /// <br />Font weight: Medium
  static const TextStyle subbody1Medium =
      TextStyle(fontSize: 13, fontWeight: FontWeight.w500);

  /// Font size: 12
  /// <br />Font weight: Regular
  static const TextStyle subbody2 =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

  /// Font size: 12
  /// <br />Font weight: Medium
  static const TextStyle subbody2Medium =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500);

  /// Font size: 10
  /// <br />Font weight: Regular
  static const TextStyle caption5 =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400);

  /// Font size: 11
  /// <br />Font weight: Regular
  static const TextStyle caption4 =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w400);

  /// 레시피 순서 번호
  /// <br />Font size: 40
  /// <br />Font weight: w500
  /// <br />Color: 0xFFBACBA1
  static const TextStyle recipeOrder = TextStyle(
      fontSize: 40, fontWeight: FontWeight.w500, color: Color(0xFFBACBA1));

  /// 레시피 설명
  /// <br />Font size: 16
  /// <br />Font weight: Regular
  /// <br />Color: Black
  static const TextStyle recipeStep =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);

  /// Font size: 10
  ///  <br />Font weight: Regular
  static const TextStyle caption =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400);

  /* Shadows */
  static BoxShadow shadow =
      BoxShadow(color: gray200.withOpacity(0.25), blurRadius: 15);
}
