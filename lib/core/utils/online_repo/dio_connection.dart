import 'package:dio/dio.dart';

class DioConnection{
  static  Dio? _connection;
  DioConnection._Dio();

  static Dio connect(){


    _connection ??= Dio();
    return _connection!;
  }

}