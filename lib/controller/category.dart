import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tiket/constant.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tiket/screens/dashboard_screen.dart';

class CategoryController extends GetxController {
  Future show() async {
    final response = await http.get(
      Uri.parse(
        '${Url.baseUrl}/api/category',
      ),
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {}
  }
}
