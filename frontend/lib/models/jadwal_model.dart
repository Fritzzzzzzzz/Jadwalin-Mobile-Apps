class JadwalModel {
  final int? id;

  final String namaMatkul;

  final String hari;

  final String jamMulai;

  final String jamSelesai;

  final String ruangan;

  JadwalModel({
    this.id,

    required this.namaMatkul,

    required this.hari,

    required this.jamMulai,

    required this.jamSelesai,

    required this.ruangan,
  });

  factory JadwalModel.fromJson(Map<String, dynamic> json) {
    return JadwalModel(
      id: json["id"],

      namaMatkul: json["namaMatkul"],

      hari: json["hari"],

      jamMulai: json["jamMulai"],

      jamSelesai: json["jamSelesai"],

      ruangan: json["ruangan"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,

      "namaMatkul": namaMatkul,

      "hari": hari,

      "jamMulai": jamMulai,

      "jamSelesai": jamSelesai,

      "ruangan": ruangan,
    };
  }
}
