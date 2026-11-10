class AuthDemoStore {
  // Tempat menyimpan banyak data pengguna
  static List<Map<String, String>> daftarPengguna = [];

  // Fungsi untuk mendaftarkan pengguna baru
  static bool daftar({
    required String namaPengguna,
    required String emailPengguna,
    required String passwordPengguna,
  }) {
    // Periksa apakah email sudah digunakan
    final emailSudahAda = daftarPengguna.any(
      (pengguna) => pengguna['email'] == emailPengguna,
    );

    if (emailSudahAda) {
      return false;
    }

    // Simpan pengguna baru ke dalam List
    daftarPengguna.add({
      'nama': namaPengguna,
      'email': emailPengguna,
      'password': passwordPengguna,
    });

    return true;
  }

  // Fungsi untuk memeriksa login
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
