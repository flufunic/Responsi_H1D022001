import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/rekam_medis_pasien.dart';

class RekamMedisPasienBloc {
  static Future<List<RekamMedisPasien>> getRekamMedisPasiens() async {
    String apiUrl = ApiUrl.listRekamMedisPasien;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listRekamMedisPasien =
        (jsonObj as Map<String, dynamic>)['data'];
    List<RekamMedisPasien> rekammedispasiens = [];
    for (int i = 0; i < listRekamMedisPasien.length; i++) {
      rekammedispasiens.add(RekamMedisPasien.fromJson(listRekamMedisPasien[i]));
    }
    return rekammedispasiens;
  }

  static Future addRekamMedisPasien(
      {RekamMedisPasien? rekamMedisPasien}) async {
    String apiUrl = ApiUrl.createRekamMedisPasien;

    var body = {
      "patient_name": rekamMedisPasien!.patientName,
      "symptom": rekamMedisPasien.symptom,
      "severity": rekamMedisPasien.severity.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateRekamMedisPasien(
      {required RekamMedisPasien rekamMedisPasien}) async {
    String apiUrl = ApiUrl.updateRekamMedisPasien(rekamMedisPasien.id!);
    print(apiUrl);

    var body = {
      "patient_name": rekamMedisPasien.patientName,
      "symptom": rekamMedisPasien.symptom,
      "severity": rekamMedisPasien.severity
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteRekamMedisPasien({int? id}) async {
    String apiUrl = ApiUrl.deleteRekamMedisPasien(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
