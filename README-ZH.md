# extra_hittest_area

[![pub package](https://img.shields.io/pub/v/extra_hittest_area.svg)](https://pub.dartlang.org/packages/extra_hittest_area) [![GitHub stars](https://img.shields.io/github/stars/fluttercandies/extra_hittest_area)](https://github.com/fluttercandies/extra_hittest_area/stargazers) [![GitHub forks](https://img.shields.io/github/forks/fluttercandies/extra_hittest_area)](https://github.com/fluttercandies/extra_hittest_area/network)  [![GitHub license](https://img.shields.io/github/license/fluttercandies/extra_hittest_area)](https://github.com/fluttercandies/extra_hittest_area/blob/master/LICENSE)  [![GitHub issues](https://img.shields.io/github/issues/fluttercandies/extra_hittest_area)](https://github.com/fluttercandies/extra_hittest_area/issues) <a href="https://qm.qq.com/q/ZyJbSVjfSU">![FlutterCandies QQ 群](https://img.shields.io/badge/dynamic/yaml?url=https%3A%2F%2Fraw.githubusercontent.com%2Ffluttercandies%2F.github%2Frefs%2Fheads%2Fmain%2Fdata.yml&query=%24.qq_group_number&label=QQ%E7%BE%A4&logo=qq&color=1DACE8)

Language: [English](README.md) | 中文简体

增加额外的 hitTest 区域，而不影响本身的大小和布局。

## 父 widgets

跟官方的 widgets 一样，使用它们来保证，当额外 hitTest 区域超出了父 widget的大小的时候，一样能接收到 hitTest。


* `StackHitTestWithoutSizeLimit`
* `RowHitTestWithoutSizeLimit`, `ColumnHitTestWithoutSizeLimit`, `FlexHitTestWithoutSizeLimit`
* `SizedBoxHitTestWithoutSizeLimit`
  

## 监听点击事件的 widgets

* `GestureDetectorHitTestWithoutSizeLimit`
* `RawGestureDetectorHitTestWithoutSizeLimit`
* `ListenerHitTestWithoutSizeLimit`


| parameter             | description                      | default         |
| --------------------- | -------------------------------- | --------------- |
| extraHitTestArea      | 额外增加的 hitTest 区域          | EdgeInsets.zero |
| debugHitTestAreaColor | 用于 debug 的 hitTest 区域背景色 | null            |

你可以设置 `ExtraHitTestBase.debugGlobalHitTestAreaColor` 来替代在每个监听 widgets 中单独设置 `debugHitTestAreaColor`

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

## 实现其他的 HitTestWithoutSizeLimit

如果这个 package 没有你需要的 widgets ， 你可以使用下面的类自己实现。

* `RenderBoxHitTestWithoutSizeLimit`, `RenderBoxChildrenHitTestWithoutSizeLimit`

