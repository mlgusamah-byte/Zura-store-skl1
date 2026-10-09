import 'package:flutter/material.dart';

import '../data/dummy/dummy_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  // =====================================================
  // MENGHITUNG TOTAL HARGA
  // =====================================================
  int hitungTotal() {
    int total = 0;

    // Menghitung harga × jumlah setiap barang
    for (var barang in dataKeranjang) {
      total = total + (barang.harga * barang.jumlah);
    }

    return total;
  }

  // =====================================================
  // FORMAT HARGA RUPIAH
  // =====================================================
  String formatRupiah(int harga) {
    return 'Rp ${harga.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match.group(1)}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F8),

      // =====================================================
      // APP BAR
      // =====================================================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Keranjang',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      // =====================================================
      // CEK KERANJANG
      // =====================================================
      body: dataKeranjang.isEmpty

          // =================================================
          // KERANJANG KOSONG
          // =================================================
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  // Icon keranjang
                  Container(
                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 70,
                      color: Colors.deepPurple,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Keranjang Masih Kosong',

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Yuk cari produk yang kamu suka!',

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 13,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      'Mulai Belanja',
                    ),
                  ),
                ],
              ),
            )

          // =================================================
          // KERANJANG ADA ISI
          // =================================================
          : Column(
              children: [

                // =================================================
                // DAFTAR BARANG
                // =================================================
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),

                    itemCount: dataKeranjang.length,

                    itemBuilder: (context, index) {

                      // Mengambil barang berdasarkan index
                      final barang = dataKeranjang[index];

                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),

                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(16),

                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Row(
                          children: [

                            // =================================================
                            // GAMBAR PRODUK
                            // =================================================
                            Container(
                              width: 85,
                              height: 85,

                              decoration: BoxDecoration(
                                color: Colors.grey[100],

                                borderRadius:
                                    BorderRadius.circular(12),
                              ),

                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(12),

                                child: Image.network(
                                  barang.gambar,

                                  fit: BoxFit.cover,

                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return const Icon(
                                      Icons
                                          .image_not_supported_outlined,
                                      color: Colors.grey,
                                      size: 35,
                                    );
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // =================================================
                            // INFORMASI PRODUK
                            // =================================================
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [

                                  // Nama produk
                                  Text(
                                    barang.nama,

                                    maxLines: 2,

                                    overflow:
                                        TextOverflow.ellipsis,

                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  // Harga produk
                                  Text(
                                    formatRupiah(
                                      barang.harga,
                                    ),

                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                          FontWeight.w600,
                                      color:
                                          Colors.deepPurple,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // =================================================
                                  // JUMLAH BARANG
                                  // =================================================
                                  Row(
                                    children: [

                                      // Tombol kurang
                                      Container(
                                        width: 30,
                                        height: 30,

                                        decoration: BoxDecoration(
                                          color:
                                              Colors.grey[100],

                                          borderRadius:
                                              BorderRadius
                                                  .circular(8),
                                        ),

                                        child: IconButton(
                                          padding:
                                              EdgeInsets.zero,

                                          onPressed: () {

                                            setState(() {

                                              // Jumlah minimal 1
                                              if (barang.jumlah >
                                                  1) {
                                                barang.jumlah--;
                                              }

                                            });
                                          },

                                          icon: const Icon(
                                            Icons.remove,
                                            size: 16,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      // Jumlah
                                      Text(
                                        '${barang.jumlah}',

                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      // Tombol tambah
                                      Container(
                                        width: 30,
                                        height: 30,

                                        decoration:
                                            BoxDecoration(
                                          color:
                                              Colors.deepPurple,

                                          borderRadius:
                                              BorderRadius
                                                  .circular(8),
                                        ),

                                        child: IconButton(
                                          padding:
                                              EdgeInsets.zero,

                                          onPressed: () {

                                            setState(() {
                                              barang.jumlah++;
                                            });

                                          },

                                          icon: const Icon(
                                            Icons.add,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // =================================================
                            // TOMBOL HAPUS
                            // =================================================
                            IconButton(
                              onPressed: () {

                                setState(() {

                                  // Hapus barang
                                  dataKeranjang.removeAt(
                                    index,
                                  );

                                });

                              },

                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // =================================================
                // TOTAL DAN CHECKOUT
                // =================================================
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    16,
                    20,
                    20,
                  ),

                  decoration: const BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),

                  child: Column(
                    children: [

                      // =================================================
                      // TOTAL
                      // =================================================
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [

                          const Text(
                            'Total Belanja',

                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),

                          Text(
                            formatRupiah(
                              hitungTotal(),
                            ),

                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // =================================================
                      // CHECKOUT
                      // =================================================
                      SizedBox(
                        width: double.infinity,
                        height: 52,

                        child: ElevatedButton(
                          onPressed: () {

                            // Nanti kita sambungkan
                            // ke halaman pembayaran

                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.deepPurple,

                            foregroundColor:
                                Colors.white,

                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                          ),

                          child: const Text(
                            'Lanjut ke Pembayaran',

                            style: TextStyle(
                              fontSize: 16,
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
    );
  }
}