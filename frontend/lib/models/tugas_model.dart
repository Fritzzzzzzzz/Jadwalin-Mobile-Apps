class TugasModel {
  final String matkul;
  final String judul;
  final String deadline;
  final String? deskripsi;

  String status;

  TugasModel({
    required this.matkul,
    required this.judul,
    required this.deadline,
    this.deskripsi,
    this.status = 'Belum Selesai',
  });
}
