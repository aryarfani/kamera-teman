class Admin {
  int id;
  String nama;
  String alamat;
  String email;
  String phone;
  String password;
  String gambar;

  Admin({this.id, this.alamat, this.email, this.nama, this.password, this.phone, this.gambar});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      gambar: json['gambar'],
    );
  }
}
