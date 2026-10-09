
import 'package:flutter/material.dart';
import '../services/session_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Membuat object SessionService.
  final sessionService = SessionService();

  // Username sementara.
  String username = 'Memuat profil...';

  // Status login.
  bool sessionAktif = false;

  @override
  void initState() {
    super.initState();

    // Mengambil data profil.
    ambilProfil();
  }

  // Mengambil username dan status login.
  Future<void> ambilProfil() async {
    final nama = await sessionService.getUsername();
    final status = await sessionService.isLoggedIn();

    if (!mounted) return;

    setState(() {
      username = nama;
      sessionAktif = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FC),

      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF8F8FC),
      ),

      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 20),

          // Avatar berdasarkan huruf pertama username.
          Center(
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.deepPurple,
              child: Text(
                username.isEmpty
                    ? '?'
                    : username[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Nama mengikuti username login.
          Center(
            child: Text(
              username,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: Text(
              '@$username',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Informasi username.
          Card(
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.person_outline,
                color: Colors.deepPurple,
              ),
              title: const Text('Username'),
              subtitle: Text(username),
            ),
          ),

          const SizedBox(height: 12),

          // Informasi session.
          Card(
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              leading: Icon(
                Icons.verified_user_outlined,
                color: sessionAktif ? Colors.green : Colors.grey,
              ),
              title: const Text('Status akun'),
              subtitle: Text(
                sessionAktif ? 'Login aktif' : 'Belum login',
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Tombol logout.
          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () async {
                // Hapus session.
                await sessionService.logout();

                if (!context.mounted) return;

                // Kembali ke halaman login.
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}