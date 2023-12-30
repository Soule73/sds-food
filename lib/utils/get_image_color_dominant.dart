import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PaletteColorUtil {
  Future<List<Color?>> updatePaletteGenerator(
      ImageProvider imageProvider) async {
// Créer un objet PaletteGenerator
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);

// Accéder à la couleur dominante
    PaletteColor? dominantColor = paletteGenerator.dominantColor;
    PaletteColor? vibrantColor = paletteGenerator.vibrantColor;
    PaletteColor? mutedColor = paletteGenerator.mutedColor;

    return [dominantColor?.color, vibrantColor?.color, mutedColor?.color];
  }
}
