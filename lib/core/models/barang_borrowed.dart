class BarangBorrowed {
  int id;
  String nama;
  int stock;
  int harga;
  int riwayatId;
  int status;
  int totalBiaya;
  String gambar;
  String namaMember;
  String tanggalTempo;

  BarangBorrowed(
      {this.id,
      this.stock,
      this.harga,
      this.nama,
      this.gambar,
      this.namaMember,
      this.totalBiaya,
      this.riwayatId,
      this.status,
      this.tanggalTempo});

  factory BarangBorrowed.fromJson(Map<String, dynamic> json) {
    return BarangBorrowed(
      id: json['id'],
      riwayatId: json['riwayat_id'],
      nama: json['nama'],
      stock: json['stock'],
      harga: json['harga'],
      gambar: json['gambar'],
      status: json['status'],
      totalBiaya: json['totalBiaya'],
      namaMember: json['nama_member'],
      tanggalTempo: json['tanggal_tempo'],
    );
  }
}
