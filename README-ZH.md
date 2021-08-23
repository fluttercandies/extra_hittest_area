# expand_hittest_area

[![pub package](https://img.shields.io/pub/v/expand_hittest_area.svg)](https://pub.dartlang.org/packages/expand_hittest_area) [![GitHub stars](https://img.shields.io/github/stars/fluttercandies/expand_hittest_area)](https://github.com/fluttercandies/expand_hittest_area/stargazers) [![GitHub forks](https://img.shields.io/github/forks/fluttercandies/expand_hittest_area)](https://github.com/fluttercandies/expand_hittest_area/network)  [![GitHub license](https://img.shields.io/github/license/fluttercandies/expand_hittest_area)](https://github.com/fluttercandies/expand_hittest_area/blob/master/LICENSE)  [![GitHub issues](https://img.shields.io/github/issues/fluttercandies/expand_hittest_area)](https://github.com/fluttercandies/expand_hittest_area/issues) <a target="_blank" href="https://jq.qq.com/?_wv=1027&k=5bcc0gy"><img border="0" src="https://pub.idqqimg.com/wpa/images/group.png" alt="flutter-candies" title="flutter-candies"></a>

Language: [English](README.md) | 中文简体

增加额外的 hitTest 区域，而不影响本身的 widget 大小和布局。

## 父 widgets

跟官方的 widgets 一样，使用它们来保证，当额外 hitTest 区域超出了父 widget的大小的时候，一样能接收到 hitTest。


* `StackHitTestWithoutSizeLimit`
* `RowHitTestWithoutSizeLimit`, `ColumnHitTestWithoutSizeLimit`, `FlexHitTestWithoutSizeLimit`
* `SizedBoxHitTestWithoutSizeLimit`
  

## 监听点击事件的 widgets

* `GestureDetectorHitTestWithoutSizeLimit`
* `RawGestureDetectorHitTestWithoutSizeLimit`
* `ListenerHitTestWithoutSizeLimit`


| parameter        | description               | default         |
| ---------------- | ------------------------- | --------------- |
| extraHitTestArea | 额外增加的 hitTest 区域 | EdgeInsets.zero |
| debugHitTestAreaColor | 用于 debug 的 hitTest 区域背景色 | null |

你可以设置 `ExtraHitTestBase.debugGlobalHitTestAreaColor` 来替代在每个监听 widgets 中单独设置 `debugHitTestAreaColor`

## 实现其他的 HitTestWithoutSizeLimit

如果这个 package 没有你需要的 widgets ， 你可以使用下面的类自己实现。

* `RenderBoxHitTestWithoutSizeLimit`, `RenderBoxChildrenHitTestWithoutSizeLimit`

