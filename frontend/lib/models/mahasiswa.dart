class Mahasiswa {
  final int id;
  final String nama;
  final String nim;
  final String prodi;


  Mahasiswa({
    required this.id,
    required this.nama,
    required this.nim,
    required this.prodi,
  });


  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: int.parse(json['id'].toString()),
      nama: json['nama'].toString(),
      nim: json['nim'].toString(),
      prodi: json['prodi'].toString(),
    );
  }
}