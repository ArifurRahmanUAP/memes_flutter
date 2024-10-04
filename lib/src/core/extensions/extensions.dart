import 'package:flutter/material.dart';

extension EmptyPadding on num {
  ///Extension for padding vertically
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );

  ///Extension for padding horizontally
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}


extension CharacterRemove on String{
  String removeCharacter(String char) {
    return "${split(char)[0]} ${split(char).length > 1 ? " | ${split(char)[1]}" : ""}";
  }

  String clearText(String removablePattern) {
    List<String> strList = split(removablePattern);

    return strList[0].removeCharacter("##");
  }
}