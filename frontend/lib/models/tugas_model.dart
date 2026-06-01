class TugasModel {
  final int? id;

  final int matkulId;
  final String namaMatkul;

  final String judul;
  final String? deskripsi;
  final String deadline;
  final String status;

  TugasModel({
    this.id,
    required this.matkulId,
    required this.namaMatkul,
    required this.judul,
    this.deskripsi,
    required this.deadline,
    required this.status,
  });

  factory TugasModel.fromJson(Map<String, dynamic> json) {
    return TugasModel(
      id: json["id"],
      matkulId: json["matkulId"],
      namaMatkul: json["namaMatkul"],
      judul: json["judul"],
      deskripsi: json["deskripsi"],
      deadline: json["deadline"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "matkulId": matkulId,
      "namaMatkul": namaMatkul,
      "judul": judul,
      "deskripsi": deskripsi,
      "deadline": deadline,
      "status": status,
    };
  }
}
