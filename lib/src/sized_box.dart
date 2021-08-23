import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'hittest.dart';

class SizedBoxHitTestWithoutSizeLimit extends SizedBox {
  const SizedBoxHitTestWithoutSizeLimit(
      {Key? key, double? width, double? height, Widget? child})
      : super(
          key: key,
          child: child,
          width: width,
          height: height,
        );

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
    return RenderConstrainedBoxHitTestWithoutSizeLimit(
      additionalConstraints: _additionalConstraints,
    );
  }

  BoxConstraints get _additionalConstraints {
    return BoxConstraints.tightFor(width: width, height: height);
  }
}

class RenderConstrainedBoxHitTestWithoutSizeLimit extends RenderConstrainedBox
    with RenderBoxHitTestWithoutSizeLimit {
  RenderConstrainedBoxHitTestWithoutSizeLimit({
    RenderBox? child,
    required BoxConstraints additionalConstraints,
  }) : super(
          child: child,
          additionalConstraints: additionalConstraints,
        );
}
