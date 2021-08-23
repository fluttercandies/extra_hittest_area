import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'hittest.dart';

class ListenerHitTestWithoutSizeLimit extends SingleChildRenderObjectWidget
    with ExtraHitTestBase {
  const ListenerHitTestWithoutSizeLimit({
    Key? key,
    @required Widget? child,
    this.extraHitTestArea = EdgeInsets.zero,
    this.debugHitTestAreaColor,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerCancel,
    this.onPointerSignal,
    this.behavior = HitTestBehavior.opaque,
  }) : super(
          key: key,
          child: child,
        );
  @override
  final EdgeInsets extraHitTestArea;
  @override
  final Color? debugHitTestAreaColor;
  final PointerDownEventListener? onPointerDown;
  final PointerMoveEventListener? onPointerMove;
  final PointerUpEventListener? onPointerUp;
  final PointerCancelEventListener? onPointerCancel;
  final PointerSignalEventListener? onPointerSignal;
  final HitTestBehavior behavior;
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderPointerListenerHitTestWithoutSizeLimit(
      extraHitTestArea: extraHitTestArea,
      debugHitTestAreaColor: debugHitTestAreaColor,
      onPointerDown: onPointerDown,
      onPointerMove: onPointerMove,
      onPointerUp: onPointerUp,
      onPointerCancel: onPointerCancel,
      onPointerSignal: onPointerSignal,
      behavior: behavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context,
      RenderPointerListenerHitTestWithoutSizeLimit renderObject) {
    renderObject
      ..extraHitTestArea = extraHitTestArea
      ..debugHitTestAreaColor = debugHitTestAreaColor
      ..onPointerDown = onPointerDown
      ..onPointerMove = onPointerMove
      ..onPointerUp = onPointerUp
      ..onPointerCancel = onPointerCancel
      ..onPointerSignal = onPointerSignal
      ..behavior = behavior;
  }
}

class RenderPointerListenerHitTestWithoutSizeLimit extends RenderPointerListener
    with
        RenderBoxHitTestWithoutSizeLimit,
        RenderProxyBoxWithHitTestBehaviorHitTestWithoutSizeLimit {
  RenderPointerListenerHitTestWithoutSizeLimit({
    Color? debugHitTestAreaColor,
    EdgeInsets extraHitTestArea = EdgeInsets.zero,

    /// Called when a pointer comes into contact with the screen (for touch
    /// pointers), or has its button pressed (for mouse pointers) at this widget's
    /// location.
    PointerDownEventListener? onPointerDown,

    /// Called when a pointer that triggered an [onPointerDown] changes position.
    PointerMoveEventListener? onPointerMove,

    /// Called when a pointer that triggered an [onPointerDown] is no longer in
    /// contact with the screen.
    PointerUpEventListener? onPointerUp,

    /// Called when the input from a pointer that triggered an [onPointerDown] is
    /// no longer directed towards this receiver.
    PointerCancelEventListener? onPointerCancel,

    /// Called when a pointer signal occurs over this object.
    PointerSignalEventListener? onPointerSignal,
    HitTestBehavior behavior = HitTestBehavior.deferToChild,
  })  : _debugHitTestAreaColor = debugHitTestAreaColor,
        _extraHitTestArea = extraHitTestArea,
        super(
          onPointerDown: onPointerDown,
          onPointerMove: onPointerMove,
          onPointerUp: onPointerUp,
          onPointerCancel: onPointerCancel,
          onPointerSignal: onPointerSignal,
          behavior: behavior,
        );
  Color? _debugHitTestAreaColor;
  Color? get debugHitTestAreaColor => _debugHitTestAreaColor;
  set debugHitTestAreaColor(Color? value) {
    if (_debugHitTestAreaColor != value) {
      _debugHitTestAreaColor = value;
      markNeedsPaint();
    }
  }

  EdgeInsets _extraHitTestArea;
  @override
  EdgeInsets get extraHitTestArea => _extraHitTestArea;
  set extraHitTestArea(EdgeInsets value) {
    if (_extraHitTestArea != value) {
      _extraHitTestArea = value;
      markNeedsLayout();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (kDebugMode) {
      final Color? color =
          debugHitTestAreaColor ?? ExtraHitTestBase.debugGlobalHitTestAreaColor;
      if (color != null) {
        final Rect rect = getHitTestRect(offset);
        context.canvas.drawRect(rect, Paint()..color = color);
      }
    }
    super.paint(context, offset);
  }
}
