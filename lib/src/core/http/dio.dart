import 'package:ai_tutor/src/core/constants/app_constants.dart';
import 'package:dio/dio.dart';

import 'dio_flutter_transformer.dart';

final options = BaseOptions(
  baseUrl: AppConstants.baseUrl,
  connectTimeout: const Duration(milliseconds: 240000),
  receiveTimeout: const Duration(milliseconds: 240000),
);

final dio = Dio(options)..transformer = FlutterTransformer();

