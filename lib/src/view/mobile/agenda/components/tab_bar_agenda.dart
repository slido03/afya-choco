import 'package:flutter/material.dart';

/*
 * tab bar for Carnet screen
 */

// ignore: must_be_immutable
class TabBarAgenda extends TabBar {
  TabBarAgenda({
    super.key,
    required super.tabs,
    super.controller,
    super.isScrollable,
    super.indicatorColor,
    super.indicatorWeight,
    super.indicatorPadding,
    super.indicator,
    super.indicatorSize,
    super.labelColor,
    super.labelStyle,
    super.labelPadding,
    super.unselectedLabelColor,
    super.unselectedLabelStyle,
    super.dragStartBehavior,
    super.mouseCursor,
    super.enableFeedback,
    super.automaticIndicatorColorAdjustment,
    super.onTap,
    required this.currentIndex,
    required this.tabIndex,
  }) : oldIndex = currentIndex;

  final int currentIndex;
  late int tabIndex;

  final int oldIndex;
}
