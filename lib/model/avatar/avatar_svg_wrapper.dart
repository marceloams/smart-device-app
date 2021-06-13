import 'package:flutter_svg/flutter_svg.dart';

class AvatarSvgWrapper {
  final String rawSvg;

  AvatarSvgWrapper(this.rawSvg);

  Future<DrawableRoot> generateLogo() async {
    assert(rawSvg != null);
    try {
      return await svg.fromSvgString(rawSvg, rawSvg);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<DrawableRoot> generateSvg() async {
    DrawableRoot svgRoot = await AvatarSvgWrapper(rawSvg).generateLogo().then((value) {
      return value;
    });
    return svgRoot;
  }
}