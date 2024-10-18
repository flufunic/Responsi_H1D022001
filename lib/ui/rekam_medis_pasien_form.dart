import 'package:aplikasi_manajemen_kesehatan/bloc/rekam_medis_pasien_bloc.dart';
import 'package:aplikasi_manajemen_kesehatan/ui/rekam_medis_pasien_page.dart';
import 'package:aplikasi_manajemen_kesehatan/widget/warning_dialog.dart';
import 'package:flutter/material.dart';
import '/model/rekam_medis_pasien.dart';

class RekamMedisPasienForm extends StatefulWidget {
  RekamMedisPasien? rekamMedisPasien;
  RekamMedisPasienForm({Key? key, this.rekamMedisPasien}) : super(key: key);

  @override
  _RekamMedisPasienFormState createState() => _RekamMedisPasienFormState();
}

class _RekamMedisPasienFormState extends State<RekamMedisPasienForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH REKAM MEDIS";
  String tombolSubmit = "SIMPAN";
  final _patientNameTextboxController = TextEditingController();
  final _symptomTextboxController = TextEditingController();
  final _severityTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.rekamMedisPasien != null) {
      setState(() {
        judul = "UBAH REKAM MEDIS";
        tombolSubmit = "UBAH";
        _patientNameTextboxController.text =
            widget.rekamMedisPasien!.patientName!;
        _symptomTextboxController.text = widget.rekamMedisPasien!.symptom!;
        _severityTextboxController.text =
            widget.rekamMedisPasien!.severity.toString();
      });
    } else {
      judul = "TAMBAH REKAM MEDIS";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: const TextStyle(fontFamily: 'Arial', fontSize: 22),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _patientNameTextField(),
                      const SizedBox(height: 8),
                      _symptomTextField(),
                      const SizedBox(height: 8),
                      _severityTextField(),
                      const SizedBox(height: 20),
                      _buttonSubmit(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Textbox untuk nama pasien
  Widget _patientNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Patient Name",
        labelStyle: const TextStyle(
          fontFamily: 'Arial',
          color: Colors.redAccent,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
      style: const TextStyle(fontFamily: 'Arial', color: Colors.black),
      keyboardType: TextInputType.text,
      controller: _patientNameTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Patient Name harus diisi";
        }
        return null;
      },
    );
  }

  // Textbox untuk gejala
  Widget _symptomTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Symptom",
          labelStyle: const TextStyle(
            fontFamily: 'Arial',
            color: Colors.redAccent,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
        ),
        style: const TextStyle(fontFamily: 'Arial', color: Colors.black),
        keyboardType: TextInputType.text,
        controller: _symptomTextboxController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Symptom harus diisi";
          }
          return null;
        },
      ),
    );
  }

  // Textbox untuk tingkat keparahan
  Widget _severityTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Severity",
          labelStyle: const TextStyle(
            fontFamily: 'Arial',
            color: Colors.redAccent,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
        ),
        style: const TextStyle(fontFamily: 'Arial', color: Colors.black),
        keyboardType: TextInputType.number,
        controller: _severityTextboxController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Severity harus diisi";
          }
          return null;
        },
      ),
    );
  }

  // Tombol simpan/ubah
  Widget _buttonSubmit() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        textStyle: const TextStyle(
          fontFamily: 'Arial',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.rekamMedisPasien != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  // Fungsi untuk menyimpan rekam medis baru
  void simpan() {
    setState(() {
      _isLoading = true;
    });
    RekamMedisPasien createRekamMedisPasien = RekamMedisPasien(id: null);
    createRekamMedisPasien.patientName = _patientNameTextboxController.text;
    createRekamMedisPasien.symptom = _symptomTextboxController.text;
    createRekamMedisPasien.severity =
        int.parse(_severityTextboxController.text);
    RekamMedisPasienBloc.addRekamMedisPasien(
            rekamMedisPasien: createRekamMedisPasien)
        .then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const RekamMedisPasienPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  // Fungsi untuk mengubah rekam medis
  void ubah() {
    setState(() {
      _isLoading = true;
    });
    RekamMedisPasien updateRekamMedisPasien =
        RekamMedisPasien(id: widget.rekamMedisPasien!.id!);
    updateRekamMedisPasien.patientName = _patientNameTextboxController.text;
    updateRekamMedisPasien.symptom = _symptomTextboxController.text;
    updateRekamMedisPasien.severity =
        int.parse(_severityTextboxController.text);
    RekamMedisPasienBloc.updateRekamMedisPasien(
            rekamMedisPasien: updateRekamMedisPasien)
        .then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const RekamMedisPasienPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
