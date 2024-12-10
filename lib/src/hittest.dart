import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

mixin RenderBoxHitTestWithoutSizeLimit on RenderBox {
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    assert(() {
      if (!hasSize) {
        if (debugNeedsLayout) {
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary(
                'Cannot hit test a render box that has never been laid out.'),
            describeForError(
                'The hitTest() method was called on this RenderBox'),
            ErrorDescription(
                "Unfortunately, this object's geometry is not known at this time, "
                'probably because it has never been laid out. '
                'This means it cannot be accurately hit-tested.'),
            ErrorHint('If you are trying '
                'to perform a hit test during the layout phase itself, make sure '
                "you only hit test nodes that have completed layout (e.g. the node's "
                'children, after their layout() method has been called).'),
          ]);
        }
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Cannot hit test a render box with no size.'),
          describeForError('The hitTest() method was called on this RenderBox'),
          ErrorDescription(
              'Although this node is not marked as needing layout, '
              'its size is not set.'),
          ErrorHint('A RenderBox object must have an '
              'explicit size before it can be hit-tested. Make sure '
              'that the RenderBox in question sets its size during layout.'),
        ]);
      }
      return true;
    }());

    if (contains(position)) {
      if (hitTestChildren(result, position: position) ||
          hitTestSelf(position)) {
        result.add(BoxHitTestEntry(this, position));
        return true;
      }
    }

    return false;
  }

  bool contains(Offset position) => true;
  // size.contains(position);
}

mixin RenderBoxChildrenHitTestWithoutSizeLimit {
  bool hitTestChildrenWithoutSizeLimit(
    BoxHitTestResult result, {
    required Offset position,
    required Iterable<RenderBox> children,
  }) {
    final List<RenderBox> normal = <RenderBox>[];
    for (final RenderBox child in children) {
      if ((child is RenderBoxHitTestWithoutSizeLimit) &&
          childIsHit(result, child, position: position)) {
        return true;
      } else {
        normal.insert(0, child);
      }
    }

    for (final RenderBox child in normal) {
      if (childIsHit(result, child, position: position)) {
        return true;
      }
    }

    return false;
  }

  bool childIsHit(BoxHitTestResult result, RenderBox child,
      {required Offset position}) {
    final ContainerParentDataMixin<RenderBox> childParentData =
        child.parentData as ContainerParentDataMixin<RenderBox>;
    final Offset offset = (childParentData as BoxParentData).offset;
    final bool isHit = result.addWithPaintOffset(
      offset: offset,
      position: position,
      hitTest: (BoxHitTestResult result, Offset transformed) {
        assert(transformed == position - offset);
        return child.hitTest(result, position: transformed);
      },
    );
    return isHit;
  }
}

mixin ExtraHitTestBase {
  EdgeInsets get extraHitTestArea;
  Color? get debugHitTestAreaColor;
  static Color? debugGlobalHitTestAreaColor;
}

mixin RenderProxyBoxWithHitTestBehaviorHitTestWithoutSizeLimit
    on RenderProxyBoxWithHitTestBehavior {
  EdgeInsets get extraHitTestArea;

  bool contains(Offset position) {
    return getHitTestRect(Offset.zero).contains(position);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    bool hitTarget = false;
    if (contains(position)) {
      hitTarget =
          hitTestChildren(result, position: position) || hitTestSelf(position);
      if (hitTarget ||
          (behavior == HitTestBehavior.translucent &&
              !result.path.contains(_BoxHitTestEntry(this, position)))) {
        result.add(_BoxHitTestEntry(this, position));
      }
    }
    return hitTarget;
  }

  Rect getHitTestRect(Offset offset) {
    Rect rect = offset & size;
    rect = Rect.fromPoints(
      Offset(
          rect.left - extraHitTestArea.left, rect.top - extraHitTestArea.top),
      Offset(rect.right + extraHitTestArea.right,
          rect.bottom + extraHitTestArea.bottom),
    );
    return rect;
  }
}

class _BoxHitTestEntry extends BoxHitTestEntry {
  /// Creates a box hit test entry.
  ///
  /// The [localPosition] argument must not be null.
  _BoxHitTestEntry(RenderBox target, Offset localPosition)
      : super(target, localPosition);

  @override
  int get hashCode => Object.hashAll(<Object?>[target, localPosition]);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _BoxHitTestEntry &&
        target == other.target &&
        localPosition == other.localPosition;
  }
}
