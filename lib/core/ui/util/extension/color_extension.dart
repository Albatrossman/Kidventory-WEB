import 'package:flutter/painting.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';

extension ColorValue on EventColor {
  Color get value {
    switch (this) {
      case EventColor.tomato:
        return const Color(0xFFD50000);
      case EventColor.flamingo:
        return const Color(0xFFE67C73);
      case EventColor.tangerine:
        return const Color(0xFFF4511E);
      case EventColor.banana:
        return const Color(0xFFF6BF26);
      case EventColor.sage:
        return const Color(0xFF33B679);
      case EventColor.basil:
        return const Color(0xFF0B8043);
      case EventColor.peacock:
        return const Color(0xFF039BE5);
      case EventColor.blueberry:
        return const Color(0xFF3F51B5);
      case EventColor.lavender:
        return const Color(0xFF7986CB);
      case EventColor.grape:
        return const Color(0xFF8E24AA);
      default:
        return const Color(0xFF039BE5);
    }
  }

  Color getReadableTextColor() {
    const double minContrastRatio = 4.5;

    double luminanceBackground = value.computeLuminance();
    Color mostReadableColor = const Color(0xFFFFFFFF); // Default color

    for (EventColor color in EventColor.values) {
      double luminanceText = color.value.computeLuminance();
      double contrastRatio = (luminanceBackground > luminanceText)
         ? (luminanceBackground + 0.05) / (luminanceText + 0.05)
          : (luminanceText + 0.05) / (luminanceBackground + 0.05);

      if (contrastRatio >= minContrastRatio &&
          color.value.alpha == 0xFF) { // Check if color is opaque
        mostReadableColor = color.value;
        break;
      }
    }

    return mostReadableColor;
  }
}