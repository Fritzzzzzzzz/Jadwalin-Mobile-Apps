class MatkulModel {
  final int? id;

  final String nama;

  final String dosen;

  final String semester;

  MatkulModel({
    this.id,

    required this.nama,

    required this.dosen,

    required this.semester,
  });

  factory MatkulModel.fromJson(Map<String, dynamic> json) {
    return MatkulModel(
      id: json["id"],

      nama: json["nama"],

      dosen: json["dosen"],

      semester: json["semester"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "nama": nama, "dosen": dosen, "semester": semester};
  }
}
