/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsDatabaseGen {
  const $AssetsDatabaseGen();

  /// File path: assets/database/confession.db
  String get confession => 'assets/database/confession.db';

  /// File path: assets/database/confessioninternal2.db
  String get confessioninternal2 => 'assets/database/confessioninternal2.db';

  /// File path: assets/database/confessionold.db
  String get confessionold => 'assets/database/confessionold.db';

  /// List of all assets
  List<String> get values => [confession, confessioninternal2, confessionold];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/as_said_by_pope.jpg
  AssetGenImage get asSaidByPope =>
      const AssetGenImage('assets/images/as_said_by_pope.jpg');

  /// File path: assets/images/ccc.jpeg
  AssetGenImage get ccc => const AssetGenImage('assets/images/ccc.jpeg');

  /// File path: assets/images/confession.jpg
  AssetGenImage get confession =>
      const AssetGenImage('assets/images/confession.jpg');

  /// File path: assets/images/faq.jpeg
  AssetGenImage get faq => const AssetGenImage('assets/images/faq.jpeg');

  /// File path: assets/images/faq_alt.jpg
  AssetGenImage get faqAlt => const AssetGenImage('assets/images/faq_alt.jpg');

  /// File path: assets/images/fulton_sheen.jpeg
  AssetGenImage get fultonSheen =>
      const AssetGenImage('assets/images/fulton_sheen.jpeg');

  /// List of all assets
  List<AssetGenImage> get values =>
      [asSaidByPope, ccc, confession, faq, faqAlt, fultonSheen];
}

class $AssetsVectorsGen {
  const $AssetsVectorsGen();

  /// File path: assets/vectors/confession.svg
  SvgGenImage get confession =>
      const SvgGenImage('assets/vectors/confession.svg');

  /// File path: assets/vectors/cross.svg
  SvgGenImage get cross => const SvgGenImage('assets/vectors/cross.svg');

  /// File path: assets/vectors/exam.svg
  SvgGenImage get exam => const SvgGenImage('assets/vectors/exam.svg');

  /// File path: assets/vectors/guides.svg
  SvgGenImage get guides => const SvgGenImage('assets/vectors/guides.svg');

  /// File path: assets/vectors/prayer.svg
  SvgGenImage get prayer => const SvgGenImage('assets/vectors/prayer.svg');

  /// List of all assets
  List<SvgGenImage> get values => [confession, cross, exam, guides, prayer];
}

class Assets {
  Assets._();

  static const $AssetsDatabaseGen database = $AssetsDatabaseGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsVectorsGen vectors = $AssetsVectorsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
