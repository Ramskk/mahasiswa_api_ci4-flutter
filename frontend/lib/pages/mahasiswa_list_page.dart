import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../services/api_service.dart';
import 'mahasiswa_form_page.dart';

class MahasiswaListPage extends StatefulWidget {
  const MahasiswaListPage({super.key});

  @override
  State<MahasiswaListPage> createState() => _MahasiswaListPageState();
}

class _MahasiswaListPageState extends State<MahasiswaListPage> {
  late Future<List<Mahasiswa>> future;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    future = ApiService.getMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mahasiswa'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MahasiswaFormPage()),
          ).then((value) {
            if (value == true) {
              setState(() => loadData());
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Mahasiswa>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(child: Text('Data mahasiswa kosong'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final m = data[index];

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(m.nama.isNotEmpty
                        ? m.nama[0].toUpperCase()
                        : '?'),
                  ),
                  title: Text(
                    m.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('NIM  : ${m.nim}'),
                      Text('Prodi: ${m.prodi}'),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                MahasiswaFormPage(mahasiswa: m),
                          ),
                        ).then((value) {
                          if (value == true) {
                            setState(() => loadData());
                          }
                        });
                      }

                      if (value == 'delete') {
                        await ApiService.deleteMahasiswa(m.id);
                        setState(() => loadData());
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(
                          'Hapus',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
