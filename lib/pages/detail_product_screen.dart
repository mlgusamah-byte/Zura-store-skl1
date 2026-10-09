import 'package:flutter/material.dart';
import 'package:mysample/data/models/model_produk.dart';

import '../data/dummy/dummy_cart.dart';
import '../data/models/model_cart.dart';

class DetailProductScreen extends StatelessWidget {
  final Product product;

  const DetailProductScreen({
    super.key,
    required this.product,
  });

  // =====================================================
  // TAMBAH PRODUK KE KERANJANG
  // =====================================================
  void tambahKeKeranjang(BuildContext context) {
    bool sudahAda = false;

    // Cek apakah produk sudah ada
    for (var barang in dataKeranjang) {
      if (barang.nama == product.name) {
        // Kalau sudah ada, jumlahnya ditambah
        barang.jumlah++;

        sudahAda = true;

        break;
      }
    }

    // Kalau belum ada, masukkan produk baru
    if (!sudahAda) {
      dataKeranjang.add(
        CartModel(
          nama: product.name,
          harga: product.price,
          gambar: product.image,
          jumlah: 1,
        ),
      );
    }

    // Tampilkan pesan
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Produk ditambahkan ke keranjang',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      // =====================================================
      // APP BAR
      // =====================================================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Detail Produk',

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),

            onPressed: () {},
          ),
        ],
      ),

      // =====================================================
      // BODY
      // =====================================================
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // =================================================
            // GAMBAR PRODUK
            // =================================================
            Container(
              width: double.infinity,

              height: size.height * 0.42,

              margin: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(28),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),

                child: Image.network(
                  product.image,

                  fit: BoxFit.cover,

                  loadingBuilder: (
                    context,
                    child,
                    loadingProgress,
                  ) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },

                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 60,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            // =================================================
            // INFORMASI PRODUK
            // =================================================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                120,
              ),

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // -------------------------------
                  // RATING
                  // -------------------------------
                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.15),

                          borderRadius:
                              BorderRadius.circular(20),
                        ),

                        child: const Row(
                          children: [

                            Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.amber,
                            ),

                            SizedBox(width: 5),

                            Text(
                              '4.8',

                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        '120 ulasan',

                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // -------------------------------
                  // NAMA PRODUK
                  // -------------------------------
                  Text(
                    product.name,

                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // -------------------------------
                  // HARGA
                  // -------------------------------
                  Text(
                    'Rp ${product.price}',

                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111111),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // -------------------------------
                  // GARIS
                  // -------------------------------
                  Container(
                    height: 1,
                    color: Colors.grey.shade200,
                  ),

                  const SizedBox(height: 24),

                  // -------------------------------
                  // DESKRIPSI
                  // -------------------------------
                  const Text(
                    'Deskripsi Produk',

                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Produk berkualitas dengan desain modern '
                    'dan nyaman digunakan. Dibuat dengan material '
                    'pilihan sehingga cocok digunakan untuk '
                    'kebutuhan sehari-hari.',

                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // -------------------------------
                  // ULASAN
                  // -------------------------------
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        'Ulasan Pembeli',

                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextButton(
                        onPressed: () {},

                        child: const Text(
                          'Lihat Semua',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // -------------------------------
                  // REVIEW CARD
                  // -------------------------------
                  Container(
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),

                      borderRadius:
                          BorderRadius.circular(20),
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Row(
                          children: [

                            const CircleAvatar(
                              radius: 22,

                              child: Icon(
                                Icons.person,
                              ),
                            ),

                            const SizedBox(width: 12),

                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [

                                  Text(
                                    'Ahmad',

                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Row(
                                    children: [

                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      ),

                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      ),

                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      ),

                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      ),

                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        const Text(
                          'Produknya bagus dan sesuai dengan '
                          'deskripsi. Pengiriman juga cepat.',

                          style: TextStyle(
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // =====================================================
      // BOTTOM BUTTON
      // =====================================================
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            12,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, -5),
              ),
            ],
          ),

          child: Row(
            children: [

              // -------------------------------
              // KERANJANG
              // -------------------------------
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {

                    // Masukkan produk ke keranjang
                    tambahKeKeranjang(context);

                  },

                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                  ),

                  label: const Text(
                    'Keranjang',
                  ),

                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      55,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // -------------------------------
              // BELI SEKARANG
              // -------------------------------
              Expanded(
                child: ElevatedButton(
                  onPressed: () {

                    // Masukkan produk ke keranjang
                    tambahKeKeranjang(context);

                  },

                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      55,
                    ),

                    backgroundColor: Colors.black,

                    foregroundColor: Colors.white,

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),

                  child: const Text(
                    'Beli Sekarang',

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}