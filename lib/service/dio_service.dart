
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DioService {
  Dio client(BuildContext context) =>
      Dio(
        BaseOptions(
          baseUrl: "https://api.genderize.io",
          headers: {
            'Accept':
            'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
            'Content-type': 'application/json',
          },
        ),
      )
        ..interceptors.add(LogInterceptor(
          requestHeader: false,
          responseHeader: false,
          requestBody: true,
          responseBody: true,
        ))
        ..interceptors.add(InterceptorsWrapper(onError: (error, event) {
          print("error : ${error.type}");
          print("error : ${error.response?.statusCode}");
          if (error.response?.statusCode == 422) {
            showDialog(context: context, builder: (context) {
              return AlertDialog(title: Text("${error.response?.statusCode}"),);
            });
            Fluttertoast.showToast(
                msg: "Error code ${error.response?.statusCode}, Data ${error
                    .response?.data}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }));
}
