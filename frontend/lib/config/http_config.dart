import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:http/http.dart' as h;

final localHost = Platform.isIOS ? "127.0.0.1" : "10.0.2.2";

final baseUrl = 'http://$localHost:3000';

final http = ChopperClient(
  // Base URL
  baseUrl: Uri.parse(baseUrl),

  // Http Client
  client: h.Client(),

  // Interceptors for logging and debugging
  interceptors: [
    ChuckerChopperInterceptor(),
    ChuckerHttpLoggingInterceptor(),
  ],
);
