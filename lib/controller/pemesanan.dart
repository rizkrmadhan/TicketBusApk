import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tiket/constant.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tiket/screens/dashboard_screen.dart';

class PesananController extends GetxController {
  Future store(
      String category, String awal, String akhir, DateTime datetime) async {
    final response = await http.post(
      Uri.parse(
        '${Url.baseUrl}/api/transportasi',
      ),
      body: jsonEncode(<String, dynamic>{
        // 'start': awal,
        // 'end': akhir,
        // 'category': category,
        // 'waktu': DateFormat('yyyy-MM-dd').format(datetime)
      }),
    );

    if (response.statusCode == 201) {
      Get.to(() => DashboardScreen());
    } else {}
  }
}
