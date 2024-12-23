import 'package:flutter/material.dart';

class Palette {
  /* Component colors */
  /// #A8E6CF
  static const Color primary = Color(0xFFA8E6CF);

  /// #FB934E
  static const Color secondary = Color(0xFFFB934E);

  /// #296C53
  static const Color sub = Color(0xFF296C53);

  /// #296C53 alpha 0.1
  static const Color subContainer = Color.fromRGBO(41, 108, 84, 0.1);

  /// #FF6A41
  static const Color delete = Color(0xFFFF6A41);

  /// #FF6A41 alpha 0.1
  static const Color deleteContainer = Color.fromRGBO(255, 106, 65, 0.1);

  /// #F1FAF9
  // static const Color background = Color(0xFFF1FAF9);
  static const Color background = Color(0xFFF9F9FA);

  /* Label colors */
  /// #252525
  static const Color black = Color(0xFF252525);

  /// #2E3137
  static const Color gray900 = Color(0xFF2E3137);

  /// #444554
  static const Color gray800 = Color(0xFF444554);

  /// #5B5D6B
  static const Color gray700 = Color(0xFF5B5D6B);

  /// #777986
  static const Color gray500 = Color(0xFF777986);

  /// #9496A1
  static const Color gray400 = Color(0xFF9496A1);

  /// #AAADB7
  static const Color gray300 = Color(0xFFAAADB7);

  /// #BDC0CB
  static const Color gray200 = Color(0xFFBDC0CB);

  /// #DBDDE7
  static const Color gray150 = Color(0xFFDBDDE7);

  /// #ECEEF4
  static const Color gray100 = Color(0xFFECEEF4);

  /// #F9F9F9
  static const Color gray50 = Color(0xFFF9F9F9);

  /// #FFFFFF
  static const Color white = Color(0xFFFFFFFF);

  /* Text Styles */

  /// Font size: 24
  /// <br />Font weight: Bold
  static const TextStyle heading =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w700);

  /// Font size: 24
  /// <br />Font weight: Bold. Color: white
  static const TextStyle headingWhite =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white);

  /// Font size: 20
  /// <br />Font weight: Bold
  static const TextStyle title =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  /// Font size: 14
  /// <br />Font weight: Semibold
  static const TextStyle subtitle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  /// Font size: 14
  /// <br />Font weight: Regular
  static const TextStyle body =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1);

  /// Font size: 12
  /// <br />Font weight: Regular
  static const TextStyle subbody =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

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
