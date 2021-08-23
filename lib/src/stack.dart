import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'hittest.dart';

class StackHitTestWithoutSizeLimit extends Stack {
  /// Creates a stack layout widget.
  ///
  /// By default, the non-positioned children of the stack are aligned by their
  /// top left corners.
  StackHitTestWithoutSizeLimit({
    Key? key,
    AlignmentDirectional alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
    List<Widget> children = const <Widget>[],
  }) : super(
          key: key,
          children: children,
          alignment: alignment,
          textDirection: textDirection,
          fit: fit,
          clipBehavior: clipBehavior,
        );
  bool _debugCheckHasDirectionality(BuildContext context) {
    if (alignment is AlignmentDirectional && textDirection == null) {
      assert(
        debugCheckHasDirectionality(context,
            why: 'to resolve the \'alignment\' argument',
            hint: alignment == AlignmentDirectional.topStart
                ? 'The default value for \'alignment\' is AlignmentDirectional.topStart, which requires a text direction.'
                : null,
            alternative:
                'Instead of providing a Directionality widget, another solution would be passing a non-directional \'alignment\', or an explicit \'textDirection\', to the $runtimeType.'),
      );
    }
    return true;
  }

  @override
  RenderStack createRenderObject(BuildContext context) {
    assert(_debugCheckHasDirectionality(context));
    return RenderStackHitTestWithoutSizeLimit(
      alignment: alignment,
      textDirection: textDirection ?? Directionality.of(context),
      fit: fit,
      clipBehavior: clipBehavior,
    );
  }
}

class RenderStackHitTestWithoutSizeLimit extends RenderStack
    with RenderBoxHitTestWithoutSizeLimit {
  RenderStackHitTestWithoutSizeLimit({
    List<RenderBox>? children,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
  }) : super(
          alignment: alignment,
          children: children,
          textDirection: textDirection,
          fit: fit,
          clipBehavior: clipBehavior,
        );
}
