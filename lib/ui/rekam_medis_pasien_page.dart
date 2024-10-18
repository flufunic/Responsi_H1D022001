import 'package:aplikasi_manajemen_kesehatan/bloc/rekam_medis_pasien_bloc.dart';
import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '/model/rekam_medis_pasien.dart';
import '/ui/rekam_medis_pasien_detail.dart';
import '/ui/rekam_medis_pasien_form.dart';
import 'login_page.dart';

class RekamMedisPasienPage extends StatefulWidget {
  const RekamMedisPasienPage({Key? key}) : super(key: key);

  @override
  _RekamMedisPasienPageState createState() => _RekamMedisPasienPageState();
}

class _RekamMedisPasienPageState extends State<RekamMedisPasienPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Rekam Medis Pasien',
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.redAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RekamMedisPasienForm(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.redAccent,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(fontFamily: 'Arial'),
              ),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: RekamMedisPasienBloc.getRekamMedisPasiens(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListRekamMedisPasien(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListRekamMedisPasien extends StatelessWidget {
  final List? list;
  const ListRekamMedisPasien({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemRekamMedisPasien(
          rekamMedisPasien: list![i],
        );
      },
    );
  }
}

class ItemRekamMedisPasien extends StatelessWidget {
  final RekamMedisPasien rekamMedisPasien;

  const ItemRekamMedisPasien({Key? key, required this.rekamMedisPasien})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RekamMedisPasienDetail(
                    rekamMedisPasien: rekamMedisPasien)));
      },
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: Colors.red[50], // Warna latar belakang merah muda
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rekamMedisPasien.patientName!,
                      style: const TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Severity: ${rekamMedisPasien.severity}",
                      style: const TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16), // Spasi antara teks dan trailing
              Text(
                rekamMedisPasien.symptom!,
                style: const TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 16,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
