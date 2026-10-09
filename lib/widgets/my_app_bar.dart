import 'package:flutter/material.dart';

import '../pages/cart_screen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Menghilangkan bayangan
      elevation: 0,

      // Warna background
      backgroundColor: Colors.white,

      // Kolom pencarian
      title: Container(
        height: 40,

        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),

        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Cari produk di sini...',
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),

            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),

            border: InputBorder.none,

            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
            ),
          ),
        ),
      ),

      // Ikon chat dan keranjang
      actions: [

        // Ikon Chat
        IconButton(
          icon: const Icon(
            Icons.chat_outlined,
            color: Colors.black87,
          ),

          onPressed: () {
            // Nanti kita bisa kasih logika chat di sini
          },
        ),

        // Ikon Keranjang
        Stack(
          alignment: Alignment.center,

          children: [

            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black87,
              ),

              onPressed: () {
                // Pindah ke halaman keranjang
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
            ),

            // Badge jumlah barang
            Positioned(
              right: 8,
              top: 8,

              child: Container(
                padding: const EdgeInsets.all(2),

                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),

                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),

                child: const Text(
                  '3',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),

                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
    kToolbarHeight,
  );
}