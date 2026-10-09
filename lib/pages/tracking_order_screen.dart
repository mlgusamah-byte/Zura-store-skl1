import 'package:flutter/material.dart';

class TrackingOrderScreen extends StatelessWidget {
  final String nama;
  final String status;

  const TrackingOrderScreen({
    super.key,
    required this.nama,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Lacak Pesanan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= PRODUK =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Pesanan',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Status: $status',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: status.toLowerCase() == 'dikirim'
                          ? Colors.purple
                          : Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Perjalanan Pesanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // ================= TRACKING =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Column(
                children: [

                  _trackingItem(
                    icon: Icons.check_circle,
                    title: 'Pesanan dibuat',
                    subtitle: 'Pesanan berhasil dibuat',
                    active: true,
                  ),

                  _trackingItem(
                    icon: Icons.inventory_2,
                    title: 'Pesanan dikemas',
                    subtitle: 'Penjual sedang menyiapkan pesanan',
                    active: true,
                  ),

                  _trackingItem(
                    icon: Icons.local_shipping,
                    title: 'Pesanan dikirim',
                    subtitle: 'Pesanan sedang dalam perjalanan',
                    active: status.toLowerCase() == 'dikirim',
                  ),

                  _trackingItem(
                    icon: Icons.home,
                    title: 'Pesanan diterima',
                    subtitle: 'Menunggu pesanan sampai',
                    active: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget kecil untuk setiap tahap tracking
  Widget _trackingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool active,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            color: active ? Colors.green : Colors.grey,
            size: 28,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: active ? Colors.black87 : Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
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