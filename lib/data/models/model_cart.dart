class CartModel {
  final String nama;
  final int harga;
  final String gambar;
  int jumlah;

  CartModel({
    required this.nama,
    required this.harga,
    required this.gambar,
    this.jumlah = 1,
  });
}