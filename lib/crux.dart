import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'listen.dart';

typedef _shareCallback = void Function(String value);
void _shareDefaultCallback(String value) => debugPrint(value);

class Sharex extends StatelessWidget {
  final Widget widget;
  final _shareCallback onShare;

  Sharex(this.widget, {Key key, this.onShare = _shareDefaultCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listen(
      this.widget,
      resumedHandler: this.handler,
    );
  }

  void handler() {
    Clipboard.getData(Clipboard.kTextPlain)
        .then((value) => {this.onShare(value.text)})
        .catchError((error) => {throw error});
  }
}
