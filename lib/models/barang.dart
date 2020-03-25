class Barang {
  int id;
  String nama;
  int stock;
  int harga;
  String gambar;

  Barang({this.id, this.stock, this.harga, this.nama, this.gambar});

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'],
      nama: json['nama'],
      stock: json['stock'],
      harga: json['harga'],
      gambar: json['gambar'],
    );
  }
}
