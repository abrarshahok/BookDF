import 'package:chopper/chopper.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:http/http.dart' as h;

const baseUrl = 'https://bookdf.vercel.app';

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
