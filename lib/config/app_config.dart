import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: 'SpinAround Navigator');

enum AuthMode { login, signup }
