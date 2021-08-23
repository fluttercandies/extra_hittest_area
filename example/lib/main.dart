import 'dart:ui';

import 'package:extra_hittest_area/extra_hittest_area.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  ExtraHitTestBase.debugGlobalHitTestAreaColor = Colors.pink.withOpacity(0.4);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget text = const Text(
    'This is test long text',
    maxLines: 1,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext c, int index) {
          return Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: RowHitTestWithoutSizeLimit(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[text, text],
                    ),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                  ),
                ),
                Expanded(
                    child: ColumnHitTestWithoutSizeLimit(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RowHitTestWithoutSizeLimit(
                      children: <Widget>[
                        // getButton  get hittest only in self
                        // getButton1 can get hittest in expand area
                        // getButton2 can get hittest in expand area
                        // getButton3 can get hittest in expand area
                        getButton2('A'),
                        Expanded(
                          child: Container(
                            color: Colors.lightGreen,
                            child: text,
                          ),
                        ),
                        getButton2('B'),
                      ],
                    ),
                    text,
                  ],
                )),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[text, text],
                    ),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                  ),
                ),
              ],
            ),
          );
        },
        itemExtent: 70,
      ),
    );
  }

  Widget getButton(String text) {
    return GestureDetector(
      onTap: () {
        showToast(text);
      },
      child: GestureDetector(
        onTap: () {
          showToast('$text:onTap${i++}',
              duration: const Duration(milliseconds: 500));
        },
        child: mockButtonUI(text),
      ),
    );
  }

  int i = 0;
  Widget getButton1(String text) {
    return StackHitTestWithoutSizeLimit(
      clipBehavior: Clip.none,
      children: <Widget>[
        mockButtonUI(text),
        Positioned(
          left: -16,
          right: -16,
          top: -16,
          bottom: -16,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              showToast('$text:onTap${i++}',
                  duration: const Duration(milliseconds: 500));
            },
            // make sure have some color(non-seen), that it will get the hittest.
            child: const ColoredBox(
              color: Color(0x00100000),
            ),
          ),
        ),
      ],
    );
  }

  Widget getButton2(String text) {
    return GestureDetectorHitTestWithoutSizeLimit(
      child: mockButtonUI(text),
      //debugHitTestAreaColor: Colors.pink.withOpacity(0.4),
      extraHitTestArea: const EdgeInsets.all(16),
      onTap: () {
        showToast('$text:onTap${i++}',
            duration: const Duration(milliseconds: 500));
      },
    );
  }

  Widget getButton3(String text) {
    return ListenerHitTestWithoutSizeLimit(
      child: mockButtonUI(text),
      debugHitTestAreaColor: Colors.pink.withOpacity(0.4),
      extraHitTestArea: const EdgeInsets.all(16),
      onPointerUp: (PointerUpEvent value) {
        showToast('$text:onPointerUp${i++}',
            duration: const Duration(milliseconds: 500));
      },
    );
  }

  Widget mockButtonUI(String text) {
    return Container(
      height: 16,
      width: 16,
      alignment: Alignment.center,
      child: Text(text),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        color: Colors.white,
      ),
    );
  }
}
