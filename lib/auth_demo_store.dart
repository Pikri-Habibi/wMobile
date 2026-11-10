
class AuthDemoStore {
  // Tempat menyimpan data seluruh pengguna
  static List<Map<String, String>> daftarPengguna = [];

  // Fungsi untuk mendaftarkan pengguna baru
  static bool daftar({
    required String namaPengguna,
    required String emailPengguna,
    required String nimPengguna,
    required String genderPengguna,
    required String tanggalLahirPengguna,
    required String prodiPengguna,
    required String noHpPengguna,
    required String alamatPengguna,
    required String passwordPengguna,
  }) {
    // Periksa apakah email sudah digunakan
    final emailSudahAda = daftarPengguna.any(
      (pengguna) => pengguna['email'] == emailPengguna,
    );

    if (emailSudahAda) {
      return false;
    }

    // Simpan seluruh data pengguna
    daftarPengguna.add({
      'nama': namaPengguna,
      'email': emailPengguna,
      'nim': nimPengguna,
      'gender': genderPengguna,
      'tanggal_lahir': tanggalLahirPengguna,
      'prodi': prodiPengguna,
      'no_hp': noHpPengguna,
      'alamat': alamatPengguna,
      'password': passwordPengguna,
    });

    return true;
  }

  // Fungsi untuk memeriksa login pengguna
  static Map<String, String>? login({
    required String emailPengguna,
    required String passwordPengguna,
  }) {
    for (final pengguna in daftarPengguna) {
      if (pengguna['email'] == emailPengguna &&
          pengguna['password'] == passwordPengguna) {
        return pengguna;
      }
    }

    return null;
  }
}
