import 'package:flutter/material.dart';

/**
 * ResponsiveUiConfig
 * Singleton class to manage responsive UI configurations
 * It initializes screen dimensions based on MediaQuery
 * Provides methods to set width and height based on screen size
 */

class ResponsiveUiConfig {
  late MediaQueryData _mediaQueryData;
  late double _screenWidth;
  late double _screenHeight;

  /// Base design dimensions (e.g., iPhone X: 375x812)
  static const double baseWidth = 375;
  static const double baseHeight = 812;

  factory ResponsiveUiConfig() {
    return _instance;
  }

  ResponsiveUiConfig._private();

  static final ResponsiveUiConfig _instance = ResponsiveUiConfig._private();

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  void initialize(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
  }

  double setWidth(num value) => _screenWidth * (value / baseWidth);

  double setHeight(num value) => _screenHeight * (value / baseHeight);
}

extension ExtensionsOnNum on num {
  static final ResponsiveUiConfig _responsiveUiConfig = ResponsiveUiConfig();

  double get w => _responsiveUiConfig.setWidth(this);

  double get h => _responsiveUiConfig.setHeight(this);
}
