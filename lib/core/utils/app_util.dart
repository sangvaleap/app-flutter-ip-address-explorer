import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The `AppUtil` class provides helper methods for common tasks in the application.
class AppUtil {
  /// Private constructor to prevent the instantiation of this class.
  AppUtil._();

  /// Prints the specified [value] to the console, but only in debug mode.
  ///
  /// This method is useful for debugging purposes and will print the value
  /// to the console if the app is running in debug mode.
  static void debugPrint(var value) {
    if (kDebugMode) print(value);
  }

  /// Checks if the provided [value] is considered null or empty.
  ///
  /// This method considers various representations of null or empty values,
  /// such as an empty string, null, "null", "NULL", "N/A", or "n/a".
  ///
  /// Returns `true` if the value is considered null or empty; otherwise, `false`.
  static bool checkIsNull(value) {
    return ["", null, "null", "NULL", "N/A", "n/a"].contains(value);
  }

  // Shows a snack bar with the specified [message] in the given [context].
  ///
  /// The optional [durationSc] parameter sets the duration for which the snack bar is displayed (default: 2 seconds).
  ///
  /// This method uses [ScaffoldMessenger] to show a snack bar at the bottom of the screen.
  /// If a current snack bar is shownig, it will hide the current snack bar, and show a new snack bar
  static void showSnackBar(BuildContext context, String message,
      {int durationSc = 2}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: durationSc),
        ),
      );
  }

  /// Converts an SVG asset to a Uint8List representation with a specified size.
  ///
  /// This method takes an SVG asset path, loads the SVG picture, and converts it
  /// into a Uint8List with the specified dimensions.
  ///
  /// Parameters:
  /// - `svgAsset`: The path to the SVG asset file.
  /// - `size`: The desired size of the resulting image.
  ///
  /// Returns:
  /// A [Future] that completes with the Uint8List representation of the SVG image.
  static Future<Uint8List> convertSvgAssetToUint8List(
      String svgAsset, Size size) async {
    // Load SVG picture information using Flutter's SVG package.
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(svgAsset), null);
    // Determine the device pixel ratio.
    double devicePixelRatio =
        PlatformDispatcher.instance.views.first.devicePixelRatio;
    // Calculate the width and height based on the desired size and device pixel ratio.
    int width = (size.width * devicePixelRatio).toInt();
    int height = (size.height * devicePixelRatio).toInt();
    // Calculate the scale factor to fit the SVG picture into the desired size.
    final scaleFactor = min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );
    // Create a PictureRecorder to record the scaled picture.
    final recorder = PictureRecorder();
    // Draw the scaled picture onto the recorder's canvas.
    Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);
    // End the recording and obtain a rasterized picture.
    final rasterPicture = recorder.endRecording();
    // Convert the rasterized picture to an Image with the specified width and height.
    final image = rasterPicture.toImageSync(width, height);
    // Convert the Image to a Uint8List (byte data) in PNG format.
    final byteData = (await image.toByteData(format: ImageByteFormat.png))!;
    // Return the Uint8List representation of the image.
    return byteData.buffer.asUint8List();
  }
}
