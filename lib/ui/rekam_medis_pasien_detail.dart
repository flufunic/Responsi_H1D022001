import 'package:aplikasi_manajemen_kesehatan/bloc/rekam_medis_pasien_bloc.dart';
import 'package:aplikasi_manajemen_kesehatan/ui/rekam_medis_pasien_form.dart';
import 'package:aplikasi_manajemen_kesehatan/ui/rekam_medis_pasien_page.dart';
import 'package:aplikasi_manajemen_kesehatan/widget/warning_dialog.dart';
import 'package:flutter/material.dart';
import '/model/rekam_medis_pasien.dart';

// ignore: must_be_immutable
class RekamMedisPasienDetail extends StatefulWidget {
  RekamMedisPasien? rekamMedisPasien;

  RekamMedisPasienDetail({Key? key, this.rekamMedisPasien}) : super(key: key);

  @override
  _RekamMedisPasienDetailState createState() => _RekamMedisPasienDetailState();
}

class _RekamMedisPasienDetailState extends State<RekamMedisPasienDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Rekam Medis Pasien',
          style: TextStyle(
            fontFamily: 'Arial',
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 500,
            height: 400,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.red[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Memastikan isi card terpusat
                  children: [
                    Text(
                      "Patient Name: ${widget.rekamMedisPasien!.patientName}",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Symptom: ${widget.rekamMedisPasien!.symptom}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Arial',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Severity: ${widget.rekamMedisPasien!.severity}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Arial',
                      ),
                    ),
                    const SizedBox(height: 20),
                    _tombolHapusEdit(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tombol Edit
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.redAccent,
            side: const BorderSide(color: Colors.redAccent),
          ),
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RekamMedisPasienForm(
                  rekamMedisPasien: widget.rekamMedisPasien!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 16), // Spasi antara tombol
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.redAccent,
            side: const BorderSide(color: Colors.redAccent),
          ),
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.redAccent,
            side: const BorderSide(color: Colors.redAccent),
          ),
          child: const Text("Ya"),
          onPressed: () {
            RekamMedisPasienBloc.deleteRekamMedisPasien(
                    id: widget.rekamMedisPasien!.id!)
                .then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RekamMedisPasienPage()));
            }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        // Tombol batal
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.redAccent,
            side: const BorderSide(color: Colors.redAccent),
          ),
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
