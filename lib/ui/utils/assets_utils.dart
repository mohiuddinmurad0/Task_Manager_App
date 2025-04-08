import 'dart:typed_data';

class AssetsUtils {
  AssetsUtils._();
  static const String _images = 'assets/images';
  static const String backgroundSVG = '$_images/background.svg';
  static const String logoSVG = '$_images/logo.svg';
}

showBase64Image(base64String) {
  UriData? data = Uri.parse(base64String).data;
  Uint8List images = data!.contentAsBytes();
  return images;
}
