class Member {
  int id;
  String nama;
  String alamat;
  String email;
  String phone;
  String password;
  String gambar;

  Member({this.id, this.alamat, this.email, this.nama, this.password, this.phone, this.gambar});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
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
