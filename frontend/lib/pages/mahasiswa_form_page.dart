import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/mahasiswa.dart';


class MahasiswaFormPage extends StatefulWidget {
  final Mahasiswa? mahasiswa;


  const MahasiswaFormPage({super.key, this.mahasiswa});


  @override
  State<MahasiswaFormPage> createState() => _MahasiswaFormPageState();
}


class _MahasiswaFormPageState extends State<MahasiswaFormPage> {
  final _formKey = GlobalKey<FormState>();


  late TextEditingController namaController;
  late TextEditingController nimController;
  late TextEditingController prodiController;


  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.mahasiswa?.nama ?? '');
    nimController = TextEditingController(text: widget.mahasiswa?.nim ?? '');
    prodiController = TextEditingController(text: widget.mahasiswa?.prodi ?? '');
  }


  @override
  void dispose() {
    namaController.dispose();
    nimController.dispose();
    prodiController.dispose();
    super.dispose();
  }


  void submit() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'nama': namaController.text,
        'nim': nimController.text,
        'prodi': prodiController.text,
      };


      if (widget.mahasiswa == null) {
        await ApiService.createMahasiswa(data);
      } else {
        await ApiService.updateMahasiswa(widget.mahasiswa!.id, data);
      }


      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mahasiswa == null
            ? 'Tambah Mahasiswa'
            : 'Edit Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (v) => v!.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: nimController,
                decoration: const InputDecoration(labelText: 'NIM'),
                validator: (v) => v!.isEmpty ? 'NIM wajib diisi' : null,
              ),
              TextFormField(
                controller: prodiController,
                decoration: const InputDecoration(labelText: 'Prodi'),
                validator: (v) => v!.isEmpty ? 'Prodi wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submit,
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}