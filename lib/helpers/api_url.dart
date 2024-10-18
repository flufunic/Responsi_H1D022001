class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id/'; //sesuaikan dengan ip laptop / localhost teman teman / url server Codeigniter

  static const String registrasi = baseUrl + 'api/registrasi';
  static const String login = baseUrl + 'api/login';
  static const String listRekamMedisPasien =
      baseUrl + 'api/kesehatan/rekam_medis_pasien';
  static const String createRekamMedisPasien =
      baseUrl + 'api/kesehatan/rekam_medis_pasien';

  static String updateRekamMedisPasien(int id) {
    return baseUrl +
        'api/kesehatan/rekam_medis_pasien/' +
        id.toString() +
        '/update'; //sesuaikan dengan url API yang sudah dibuat
  }

  static String showRekamMedisPasien(int id) {
    return baseUrl +
        'api/kesehatan/rekam_medis_pasien' +
        id.toString(); //sesuaikan dengan url API yang sudah dibuat
  }

  static String deleteRekamMedisPasien(int id) {
    return baseUrl +
        'api/kesehatan/rekam_medis_pasien/' +
        id.toString() +
        '/delete'; //sesuaikan dengan url API yang sudah dibuat
  }
}
