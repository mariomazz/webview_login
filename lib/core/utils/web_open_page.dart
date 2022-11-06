import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:extension_methods/core/stream.dart';

class WebOpenPage {
  final String path;

  WebOpenPage(this.path);

  void open() {
    window.location.assign(path);
  }

  Future<String> openAndListen() async {
    window.location.assign(path);
    return window.onMessage.asBroadcastStream().map((e) => e.data.toString()).toFuture();
  }
}
