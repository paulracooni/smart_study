import 'package:flutter/material.dart';

enum DisplayMode {
  DESKTOP, TABELT, MOBILE
}

extension DisplayModeSelection on MediaQueryData {
  DisplayMode get displayMode{
    late DisplayMode displayMode;
    if (size.width > 1024) {
      displayMode = DisplayMode.DESKTOP;
    }
    else if (size.width > 768){
      displayMode = DisplayMode.TABELT;
    }
    else{
      displayMode = DisplayMode.MOBILE;
    }
    return displayMode;
  }
}