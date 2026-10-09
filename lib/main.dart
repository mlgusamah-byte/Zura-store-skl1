
import 'package:flutter/material.dart';

import 'pages/login_screen.dart';
import 'pages/register_screen.dart';
import 'pages/feeds_screen.dart';
import 'pages/home_screen.dart';
import 'pages/mall_screen.dart';
import 'pages/profile_screen.dart';
import 'pages/transaction_screen.dart';

// Kalau ProductGrid mau dijadikan menu sendiri,
// import widget-nya tetap digunakan.
import 'package:mysample/widgets/product_grid.dart';

void main() {
  runApp(const NavigationBarApp());
}

// ==================================================
// MATERIAL APP
// ==================================================

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const NavigationExample(),
      },
    );
  }
}

// ==================================================
// NAVIGATION EXAMPLE
// ==================================================

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() =>
      _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  // Index halaman yang sedang aktif.
  int currentPageIndex = 0;

  // Data yang dikirim dari halaman login.
  Map<String, dynamic>? dataDiri;

  // Mencegah dialog muncul berulang kali.
  bool _dialogSudahMuncul = false;

  // ==================================================
  // MENGAMBIL DATA LOGIN
  // ==================================================

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Map<String, dynamic>) {
      final data = arguments['data'];

      if (data is Map<String, dynamic>) {
        dataDiri = data;
      }

      if (!_dialogSudahMuncul) {
        _dialogSudahMuncul = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _showWelcomeDialog();
        });
      }
    }
  }

  // ==================================================
  // DIALOG SELAMAT DATANG
  // ==================================================

  void _showWelcomeDialog() {
    final nama = dataDiri?['name'] ?? 'Pengguna';
    final username = dataDiri?['username'] ?? '-';
    final role = dataDiri?['role'] ?? 'user';
    final session = dataDiri?['session'] ?? false;

    // Mengambil waktu login atau menggunakan waktu sekarang.
    final waktuLogin = dataDiri?['loginTime'] is DateTime
        ? dataDiri!['loginTime'] as DateTime
        : DateTime.now();

    final tanggal =
        '${waktuLogin.day} '
        '${_namaBulan(waktuLogin.month)} '
        '${waktuLogin.year}';

    final jam =
        '${waktuLogin.hour.toString().padLeft(2, '0')}:'
        '${waktuLogin.minute.toString().padLeft(2, '0')}';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),

            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon sambutan.
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.waving_hand_rounded,
                      color: Colors.deepPurple,
                      size: 42,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Selamat Datang! 👋',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Halo, $nama!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Senang melihatmu kembali di aplikasi. '
                    'Kamu berhasil login sebagai $role.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Informasi akun.
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F5FF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        _infoRow(
                          Icons.person_outline,
                          'Username',
                          username.toString(),
                        ),
                        const SizedBox(height: 12),
                        _infoRow(
                          Icons.calendar_today_outlined,
                          'Tanggal Login',
                          tanggal,
                        ),
                        const SizedBox(height: 12),
                        _infoRow(
                          Icons.access_time_outlined,
                          'Waktu Login',
                          jam,
                        ),
                        const SizedBox(height: 12),
                        _infoRow(
                          Icons.verified_outlined,
                          'Session',
                          session == true ? 'TRUE' : 'FALSE',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Mulai Menjelajah 🚀',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ==================================================
  // BARIS INFORMASI
  // ==================================================

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.deepPurple,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==================================================
  // NAMA BULAN
  // ==================================================

  String _namaBulan(int bulan) {
    const namaBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return namaBulan[bulan - 1];
  }

  // ==================================================
  // BUILD
  // ==================================================

  @override
  Widget build(BuildContext context) {
    // Urutan halaman harus sama dengan urutan menu.
    final List<Widget> pages = [
      HomeScreen(dataDiri: dataDiri), // Index 0
      const FeedsScreen(),            // Index 1
      const MallScreen(),              // Index 2
      TransactionsScreen(),            // Index 3
      ProductGrid(),                   // Index 4
      const ProfileScreen(), // Index 5
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),

      bottomNavigationBar: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),

        child: NavigationBar(
          selectedIndex: currentPageIndex,

          onDestinationSelected: (int selectedMenu) {
            setState(() {
              currentPageIndex = selectedMenu;
            });
          },

          indicatorColor: Theme.of(context).colorScheme.primary,

          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),

            NavigationDestination(
              selectedIcon: Icon(Icons.video_collection),
              icon: Icon(Icons.video_collection_outlined),
              label: 'Feeds',
            ),

            NavigationDestination(
              selectedIcon: Icon(Icons.store),
              icon: Icon(Icons.store_outlined),
              label: 'Mall',
            ),

            NavigationDestination(
              selectedIcon: Icon(Icons.list_alt),
              icon: Icon(Icons.list_alt_outlined),
              label: 'Transactions',
            ),

            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_bag),
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Products',
            ),

            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}