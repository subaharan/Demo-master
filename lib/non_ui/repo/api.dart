import 'dart:async';

import 'dart:io';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';



const remainingUrl = "/api/RIapi/";

const baseUrl = "https://run.mocky.io/v3/183c14ce-191b-45e1-b75c-d6cfb9d6069b";
var dio = Dio();
class API {


  static Future getDemoModel() async {
    return dio.get(baseUrl);
  }

//
}
