import 'package:flutter/material.dart';

typedef _Callback = void Function();
void _emptyImple() => {};

class Listen extends StatefulWidget {
  final Widget widget;
  final _Callback detachedHandler;
  final _Callback inactiveHandler;
  final _Callback pausedHandler;
  final _Callback resumedHandler;

  Listen(this.widget,
      {Key key,
      this.detachedHandler = _emptyImple,
      this.inactiveHandler = _emptyImple,
      this.pausedHandler = _emptyImple,
      this.resumedHandler = _emptyImple})
      : super(key: key);

  @override
  _ListenState createState() => _ListenState();
}

class _ListenState extends State<Listen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.widget;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    this.handleLifeCycleState(state);
  }

  void handleLifeCycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        widget.detachedHandler();
        break;
      case AppLifecycleState.inactive:
        widget.inactiveHandler();
        break;
      case AppLifecycleState.paused:
        widget.pausedHandler();
        break;
      case AppLifecycleState.resumed:
        widget.resumedHandler();
        break;
      default:
    }
  }
}
