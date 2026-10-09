import 'package:flutter/material.dart';

import '../data/dummy/dummy_transaksi.dart';
import 'transaction_detail_screen.dart';
import 'tracking_order_screen.dart';
import 'buy_again_screen.dart';
class TransactionsScreen extends StatelessWidget {
  TransactionsScreen({super.key});

  // Mengubah angka menjadi format Rupiah
  String formatRupiah(int harga) {
    return 'Rp ${harga.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)}.',
    )}';
  }

  // Mengatur warna sesuai status transaksi
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return Colors.green;

      case 'dikemas':
        return Colors.blue;

      case 'diproses':
        return Colors.orange;

      case 'dikirim':
        return Colors.purple;

      case 'dibatalkan':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  // Mengatur teks tombol sesuai status transaksi
  String getButtonText(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return 'Beli Lagi';

      case 'dikemas':
        return 'Lacak Pesanan';

      case 'dikirim':
        return 'Lacak Pesanan';

      case 'diproses':
        return 'Lihat Pesanan';

      case 'dibatalkan':
        return 'Beli Lagi';

      default:
        return 'Detail';
    }
  }

  // ================= METHOD NAVIGASI =================

// Status selesai → halaman beli lagi
void prosesSelesai(BuildContext context, dynamic item) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BuyAgainScreen(
        nama: item.nama,
        foto: item.foto,
        harga: item.harga,
      ),
    ),
  );
}

// Status dikemas → halaman lacak pesanan
void prosesDikemas(BuildContext context, dynamic item) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TrackingOrderScreen(
        nama: item.nama,
        status: item.status,
      ),
    ),
  );
}

// Status dikirim → halaman lacak pesanan
void prosesDikirim(BuildContext context, dynamic item) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TrackingOrderScreen(
        nama: item.nama,
        status: item.status,
      ),
    ),
  );
}

// Status diproses → halaman detail
void prosesDiproses(BuildContext context, dynamic item) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TransactionDetailScreen(
        nama: item.nama,
        foto: item.foto,
        harga: item.harga,
        status: item.status,
      ),
    ),
  );
}

// Status dibatalkan → halaman detail
void prosesDibatalkan(BuildContext context, dynamic item) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TransactionDetailScreen(
        nama: item.nama,
        foto: item.foto,
        harga: item.harga,
        status: item.status,
      ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,

        title: const Text(
          'Transaksi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),

      // ================= LIST TRANSAKSI =================
      body: ListView.builder(
        padding: const EdgeInsets.all(16),

        itemCount: transactions.length,

        itemBuilder: (context, index) {
          final item = transactions[index];

          // Mengambil warna berdasarkan status
          final statusColor = getStatusColor(item.status);

          // Mengambil teks tombol berdasarkan status
          final buttonText = getButtonText(item.status);

          return Container(
            margin: const EdgeInsets.only(bottom: 16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),

              // Bayangan card
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [

                  // ================= HEADER =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // Tanggal transaksi
                      Flexible(
                        child: Text(
                          item.tanggal,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Status transaksi
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),

                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Text(
                          item.status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Garis pemisah
                  const Divider(height: 1),

                  const SizedBox(height: 16),

                  // ================= PRODUK =================
                  Row(
                    children: [

                      // Gambar produk
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),

                        child: Image.network(
                          item.foto,
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Nama produk
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              item.nama,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              '1 barang',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  const Divider(height: 1),

                  const SizedBox(height: 14),

                  // ================= TOTAL + BUTTON =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      // Total belanja
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            'Total Belanja',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            formatRupiah(item.harga),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 10),

                      // Tombol berdasarkan status
                      Flexible(
                        child: ElevatedButton(
                         onPressed: () {
  final status = item.status.toLowerCase();

  switch (status) {
    case 'selesai':
      prosesSelesai(context, item);
      break;

    case 'dikemas':
      prosesDikemas(context, item);
      break;

    case 'dikirim':
      prosesDikirim(context, item);
      break;

    case 'diproses':
      prosesDiproses(context, item);
      break;

    case 'dibatalkan':
      prosesDibatalkan(context, item);
      break;

    default:
      prosesDiproses(context, item);
      break;
  }
},

                          style: ElevatedButton.styleFrom(
                            // Warna tombol mengikuti status
                            backgroundColor: statusColor,

                            foregroundColor: Colors.white,

                            elevation: 0,

                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          child: Text(
                            buttonText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}