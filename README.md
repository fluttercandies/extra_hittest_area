# extra_hittest_area

[![pub package](https://img.shields.io/pub/v/extra_hittest_area.svg)](https://pub.dartlang.org/packages/extra_hittest_area) [![GitHub stars](https://img.shields.io/github/stars/fluttercandies/extra_hittest_area)](https://github.com/fluttercandies/extra_hittest_area/stargazers) [![GitHub forks](https://img.shields.io/github/forks/fluttercandies/extra_hittest_area)](https://github.com/fluttercandies/extra_hittest_area/network)  [![GitHub license](https://img.shields.io/github/license/fluttercandies/extra_hittest_area)](https://github.com/fluttercandies/extra_hittest_area/blob/master/LICENSE)  [![GitHub issues](https://img.shields.io/github/issues/fluttercandies/extra_hittest_area)](https://github.com/fluttercandies/extra_hittest_area/issues) <a target="_blank" href="https://jq.qq.com/?_wv=1027&k=5bcc0gy"><img border="0" src="https://pub.idqqimg.com/wpa/images/group.png" alt="flutter-candies" title="flutter-candies"></a>

Language: README.md | [中文简体](README-ZH.md)

Manually add the extra hitTest area of a widget without changing its size or layout.


## Parent widgets

The widgets are the same as offical widgets. They are make sure your widget can get hitTest from parent, use them if extra hitTest area are beyond the size of parent.

* `StackHitTestWithoutSizeLimit`
* `RowHitTestWithoutSizeLimit`, `ColumnHitTestWithoutSizeLimit`, `FlexHitTestWithoutSizeLimit`
* `SizedBoxHitTestWithoutSizeLimit`
## Listener widgets

* `GestureDetectorHitTestWithoutSizeLimit`
* `RawGestureDetectorHitTestWithoutSizeLimit`
* `ListenerHitTestWithoutSizeLimit`


| parameter        | description               | default         |
| ---------------- | ------------------------- | --------------- |
| extraHitTestArea | The extra area of hitTest | EdgeInsets.zero |
| debugHitTestAreaColor | The color of the extra area | null |

you can also set `ExtraHitTestBase.debugGlobalHitTestAreaColor` instead set `debugHitTestAreaColor` in everytime.


```dart
return GestureDetectorHitTestWithoutSizeLimit(
  child: mockButtonUI(text),
  //debugHitTestAreaColor: Colors.pink.withOpacity(0.4),
  extraHitTestArea: const EdgeInsets.all(16),
  onTap: () {
    showToast('$text:onTap${i++}',
        duration: const Duration(milliseconds: 500));
  },
);
```

## Implements other HitTestWithoutSizeLimit

if some widgets are not included in this package, you can implements them with following classes.

* `RenderBoxHitTestWithoutSizeLimit`, `RenderBoxChildrenHitTestWithoutSizeLimit`

