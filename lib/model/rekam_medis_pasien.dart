class RekamMedisPasien {
  int? id;
  String? patientName;
  String? symptom;
  int? severity;
  RekamMedisPasien({this.id, this.patientName, this.symptom, this.severity});
  factory RekamMedisPasien.fromJson(Map<String, dynamic> obj) {
    return RekamMedisPasien(
        id: obj['id'],
        patientName: obj['patient_name'],
        symptom: obj['symptom'],
        severity: obj['severity']);
  }

  static addRekamMedisPasien({required RekamMedisPasien rekammedispasien}) {}

  static updateRekamMedisPasien({required RekamMedisPasien rekamMedisPasien}) {}
}
