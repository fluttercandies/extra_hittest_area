import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'hittest.dart';

mixin FlexHitTestWithoutSizeLimitmixin on Flex {
  @override
  RenderFlex createRenderObject(BuildContext context) {
    return RenderFlexHitTestWithoutSizeLimit(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
    );
  }
}

class FlexHitTestWithoutSizeLimit extends Flex
    with FlexHitTestWithoutSizeLimitmixin {
  FlexHitTestWithoutSizeLimit({
    Key? key,
    required Axis direction,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline?
        textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    List<Widget> children = const <Widget>[],
  }) : super(
          direction: direction,
          children: children,
          key: key,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
        );
}

class RowHitTestWithoutSizeLimit extends Row
    with FlexHitTestWithoutSizeLimitmixin {
  RowHitTestWithoutSizeLimit({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline?
        textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    List<Widget> children = const <Widget>[],
  }) : super(
          children: children,
          key: key,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
        );
}

class ColumnHitTestWithoutSizeLimit extends Column
    with FlexHitTestWithoutSizeLimitmixin {
  ColumnHitTestWithoutSizeLimit({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    List<Widget> children = const <Widget>[],
  }) : super(
          children: children,
          key: key,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
        );
}

class RenderFlexHitTestWithoutSizeLimit extends RenderFlex
    with
        RenderBoxHitTestWithoutSizeLimit,
        RenderBoxChildrenHitTestWithoutSizeLimit {
  RenderFlexHitTestWithoutSizeLimit({
    List<RenderBox>? children,
    Axis direction = Axis.horizontal,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Clip clipBehavior = Clip.none,
  }) : super(
          children: children,
          direction: direction,
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          clipBehavior: clipBehavior,
        );

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return hitTestChildrenWithoutSizeLimit(
      result,
      position: position,
      children: getChildrenAsList().reversed,
    );
  }
}
