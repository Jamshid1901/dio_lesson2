

import 'package:dio/dio.dart';
import 'package:dios_lesson/iterface/main_interface.dart';
import 'package:dios_lesson/model/Name.dart';
import 'package:dios_lesson/service/dio_service.dart';
import 'package:flutter/cupertino.dart';

class MainRepository implements MainFacade {
  @override
  Future getNameInformation(String nameText,BuildContext context) async {
    DioService _dioService = DioService();
    try {
      var response = await _dioService.client(context).get('/?nam=$nameText');

      Name name = Name.fromJson(response.data);
      return name.name ?? "";
    } catch (e) {
      print(e);
    }
  }
}
