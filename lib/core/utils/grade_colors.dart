import 'package:flutter/material.dart';

class GradeUtils {
  final String? pctGrade;

  GradeUtils({this.pctGrade});

  final gradeLookupTable = {
    89.5: {
      'letter': 'A',
      'colors': [Color(0xff166E32), Color(0xff166E32)],
      'circleColor': Colors.green
    },
    79.5: {
      'letter': 'B',
      'colors': [Color(0xff033981), Color(0xff173A67)],
      'circleColor': Colors.blue
    },
    69.5: {
      'letter': 'C',
      'colors': [Color(0xff7D802E), Color(0xff575C29)],
      'circleColor': Colors.yellow
    },
    59.5: {
      'letter': 'D',
      'colors': [Color(0xffBB6A23), Color(0xff684127)],
      'circleColor': Colors.orange
    },
    00.00: {
      'letter': 'E',
      'colors': [Color(0xffB83F3F), Color(0xff5E202A)],
      'circleColor': Colors.red
    },
    null: {
      'letter': 'N/A',
      'colors': [
        Color.fromARGB(135, 102, 102, 102),
        Color.fromARGB(135, 51, 51, 51)
      ],
      'circleColor': Color.fromARGB(255, 143, 143, 143)
    },
  };
  String getLetter() {
    double? grade = double.tryParse(pctGrade!);
    if (grade == null || pctGrade == 'N/A') {
      return gradeLookupTable[null]!['letter'] as String;
    }

    for (double? key in gradeLookupTable.keys) {
      if (grade >= key!) {
        return gradeLookupTable[key]!['letter'] as String;
      }
    }

    return gradeLookupTable[null]!['letter'] as String;
  }

  List<Color> getColors() {
    double? grade = double.tryParse(pctGrade!);

    if (grade == null || pctGrade == 'N/A') {
      return gradeLookupTable[null]!['colors'] as List<Color>;
    }

    for (double? key in gradeLookupTable.keys) {
      if (grade >= key!) {
        return gradeLookupTable[key]!['colors'] as List<Color>;
      }
    }

    return gradeLookupTable[null]!['colors'] as List<Color>;
  }

  Color getCircleColor() {
    double? grade = double.tryParse(pctGrade!);
    if (grade == null || pctGrade == 'N/A') {
      return gradeLookupTable[null]!['circleColor'] as Color;
    }

    for (double? key in gradeLookupTable.keys) {
      if (grade >= key!) {
        return gradeLookupTable[key]!['circleColor'] as Color;
      }
    }

    return gradeLookupTable[null]!['circleColor'] as Color;
  }
}
