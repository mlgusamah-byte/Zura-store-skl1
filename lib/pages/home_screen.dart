import 'package:flutter/material.dart';

import '../services/session_service.dart';
import '../data/dummy/dummy_kategori.dart';
import '../data/dummy/dummy_produk.dart';
import '../data/models/model_kategori.dart';
import '../data/models/model_produk.dart';
import '../widgets/my_app_bar.dart';
import 'detail_product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, Map<String, dynamic>? dataDiri});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = 'Pengguna';
  bool isLogin = false;

  final Color orange = const Color(0xFFEE4D2D);
  final Color background = const Color(0xFFF5F5F5);

  final TextEditingController searchController = TextEditingController();

  String kataPencarian = '';

  @override
  void initState() {
    super.initState();
    loadSession();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Mengambil informasi session pengguna.
  Future<void> loadSession() async {
    final session = SessionService();

    final nama = await session.getUsername();
    final status = await session.isLoggedIn();

    if (!mounted) return;

    setState(() {
      username = nama;
      isLogin = status;
    });

    if (status) {
      showWelcomeDialog();
    }
  }

  // Popup selamat datang.
  void showWelcomeDialog() {
    final sekarang = DateTime.now();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.shopping_bag_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Halo, $username 👋',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Selamat datang di Zura Store!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _infoItem(
                        Icons.verified_user,
                        'Session',
                        isLogin ? 'TRUE' : 'FALSE',
                        isLogin ? Colors.green : Colors.red,
                      ),
                      const SizedBox(height: 10),
                      _infoItem(
                        Icons.person,
                        'Role',
                        'Admin',
                        Colors.blue,
                      ),
                      const SizedBox(height: 10),
                      _infoItem(
                        Icons.calendar_month,
                        'Hari',
                        '${getHari(sekarang)}, ${getTanggal(sekarang)}',
                        Colors.deepPurple,
                      ),
                      const SizedBox(height: 10),
                      _infoItem(
                        Icons.access_time,
                        'Waktu',
                        getJam(sekarang),
                        Colors.orange,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          child: const Text(
                            'Mulai Menjelajahi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget informasi session.
  Widget _infoItem(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String getHari(DateTime tanggal) {
    const hari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    return hari[tanggal.weekday - 1];
  }

  String getTanggal(DateTime tanggal) {
    return '${tanggal.day}-${tanggal.month}-${tanggal.year}';
  }

  String getJam(DateTime tanggal) {
    final jam = tanggal.hour.toString().padLeft(2, '0');
    final menit = tanggal.minute.toString().padLeft(2, '0');

    return '$jam:$menit';
  }

  // Membuka halaman detail produk.
  void bukaDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailProductScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menyaring produk berdasarkan pencarian.
    final produkTampil = products.where((product) {
      return product.name.toLowerCase().contains(
            kataPencarian.toLowerCase(),
          );
    }).toList();

    return Scaffold(
      backgroundColor: background,

      // Menggunakan search bar paling atas.
      appBar: const MyAppBar(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),

            // BANNER PROMO.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF7043),
                      Color(0xFFEE4D2D),
                      Color(0xFFD93820),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'ZURA SALE',
                              style: TextStyle(
                                color: orange,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Belanja Favorit,\nHarga Lebih Hemat!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              height: 1.3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Temukan produk pilihanmu sekarang.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Row(
                            children: [
                              Text(
                                'Yuk, belanja!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.shopping_bag_rounded,
                      color: Colors.white,
                      size: 88,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // KATEGORI.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _judulBagian('Kategori', 'Lihat pilihan'),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 115,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _categoryItem(categories[index]);
                },
              ),
            ),

            const SizedBox(height: 25),

            // PRODUK.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _judulBagian(
                kataPencarian.isEmpty
                    ? 'Produk Terbaru'
                    : 'Hasil Pencarian',
                '${produkTampil.length} produk',
              ),
            ),

            const SizedBox(height: 14),

            if (produkTampil.isEmpty)
              const Padding(
                padding: EdgeInsets.all(35),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 55,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text('Produk tidak ditemukan.'),
                    ],
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: produkTampil.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  return _productItemView(produkTampil[index]);
                },
              ),

            const SizedBox(height: 25),

            // FOOTER.
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Text(
                  'Kamu sedang berbelanja di Zura Store ❤️',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Judul setiap bagian.
  Widget _judulBagian(String judul, String kanan) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          judul,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF292929),
          ),
        ),
        Text(
          kanan,
          style: TextStyle(
            color: orange,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ITEM KATEGORI.
  Widget _categoryItem(Category category) {
    return Container(
      width: 88,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 53,
            height: 53,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: orange.withValues(alpha: 0.07),
              shape: BoxShape.circle,
            ),
            child: Image.network(
              category.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.category_outlined,
                  color: Colors.grey,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // KARTU PRODUK.
  Widget _productItemView(Product product) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      color: Colors.white,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => bukaDetail(product),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk.
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.network(
                        product.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 45,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'PILIHAN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.grey.shade600,
                      size: 21,
                    ),
                  ),
                ],
              ),
            ),

            // Informasi produk.
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Rp ${product.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: orange,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.orange,
                          size: 15,
                        ),
                        const SizedBox(width: 3),
                        const Text(
                          '4.8',
                          style: TextStyle(fontSize: 10),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 1,
                          height: 11,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Zura Store',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: OutlinedButton(
                        onPressed: () => bukaDetail(product),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: orange,
                          padding: EdgeInsets.zero,
                          side: BorderSide(color: orange),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: const Text(
                          'Lihat Produk',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

