
import 'package:flutter/material.dart';
import '../auth_demo_store.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil isi input
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _nimController = TextEditingController();
  final _noHpController = TextEditingController();
  final _alamatController = TextEditingController();
  final _passwordController = TextEditingController();

  // Data dropdown dan tanggal lahir
  String? _genderTerpilih;
  String? _prodiTerpilih;
  DateTime? _tanggalLahir;

  bool _sembunyikanPassword = true;

  final List<String> _daftarGender = [
    'Laki-laki',
    'Perempuan',
  ];

  final List<String> _daftarProdi = [
    'TIF',
    'TKK',
    'TRK',
    'MIF',
  ];

  // Mengambil tanggal lahir dari DatePicker
  Future<void> _pilihTanggalLahir() async {
    final tanggalDipilih = await showDatePicker(
      context: context,
      initialDate: DateTime(2006),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
    );

    if (tanggalDipilih != null) {
      setState(() {
        _tanggalLahir = tanggalDipilih;
      });
    }
  }

  // Proses pendaftaran
  void _register() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_genderTerpilih == null ||
        _prodiTerpilih == null ||
        _tanggalLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi semua data terlebih dahulu!'),
        ),
      );
      return;
    }

    final berhasil = AuthDemoStore.daftar(
      namaPengguna: _namaController.text.trim(),
      emailPengguna: _emailController.text.trim(),
      nimPengguna: _nimController.text.trim(),
      genderPengguna: _genderTerpilih!,
      tanggalLahirPengguna: _formatTanggal(_tanggalLahir!),
      prodiPengguna: _prodiTerpilih!,
      noHpPengguna: _noHpController.text.trim(),
      alamatPengguna: _alamatController.text.trim(),
      passwordPengguna: _passwordController.text,
    );

    if (!berhasil) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email sudah terdaftar!'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pendaftaran berhasil! Silakan login.'),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          initialEmail: _emailController.text.trim(),
        ),
      ),
      (route) => false,
    );
  }

  // Format tanggal menjadi DD-MM-YYYY
  String _formatTanggal(DateTime tanggal) {
    final hari = tanggal.day.toString().padLeft(2, '0');
    final bulan = tanggal.month.toString().padLeft(2, '0');
    final tahun = tanggal.year;

    return '$hari-$bulan-$tahun';
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _nimController.dispose();
    _noHpController.dispose();
    _alamatController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Buat Akun Baru',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Silakan lengkapi data diri kamu.',
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 24),

                // Nama
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // Email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // NIM
                TextField(
                  controller: _nimController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'NIM',
                    prefixIcon: Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // Gender
                DropdownButtonFormField<String>(
                  value: _genderTerpilih,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    prefixIcon: Icon(Icons.people_outline),
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text('Pilih Gender'),
                  items: _daftarGender.map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _genderTerpilih = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Gender wajib dipilih';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Tanggal Lahir
                FormField<DateTime>(
                  validator: (value) {
                    if (_tanggalLahir == null) {
                      return 'Tanggal lahir wajib dipilih';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            await _pilihTanggalLahir();
                            field.didChange(_tanggalLahir);
                          },
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Tanggal Lahir',
                              prefixIcon: const Icon(Icons.calendar_month),
                              border: const OutlineInputBorder(),
                              errorText: field.errorText,
                            ),
                            child: Text(
                              _tanggalLahir == null
                                  ? 'Pilih Tanggal Lahir'
                                  : _formatTanggal(_tanggalLahir!),
                              style: TextStyle(
                                color: _tanggalLahir == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Program Studi
                DropdownButtonFormField<String>(
                  value: _prodiTerpilih,
                  decoration: const InputDecoration(
                    labelText: 'Program Studi',
                    prefixIcon: Icon(Icons.school_outlined),
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text('Pilih Program Studi'),
                  items: _daftarProdi.map((prodi) {
                    return DropdownMenuItem(
                      value: prodi,
                      child: Text(prodi),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _prodiTerpilih = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Program studi wajib dipilih';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Nomor HP
                TextFormField(
                  controller: _noHpController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Nomor HP',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nomor HP wajib diisi';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Alamat
                TextFormField(
                  controller: _alamatController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    prefixIcon: Icon(Icons.home_outlined),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Alamat wajib diisi';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _sembunyikanPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _sembunyikanPassword = !_sembunyikanPassword;
                        });
                      },
                      icon: Icon(
                        _sembunyikanPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password wajib diisi';
                    }
                    if (value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Tombol Register
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Daftar'),
                ),

                const SizedBox(height: 12),

                // Kembali ke Login
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Sudah punya akun? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
