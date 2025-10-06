part of '../../../dash_chat_custom.dart';

extension DoubleClampExtensions on double {

  double clampMax(double max) => this > max ? max : this;

  double clampMin(double min) => this < min ? min : this;

}