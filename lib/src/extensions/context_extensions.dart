import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {

  bool get isWebMd => MediaQuery.sizeOf(this).width > 1024;

}