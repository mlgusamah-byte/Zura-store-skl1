import 'package:flutter/material.dart';

class Kalkulator_screen extends StatefulWidget {
  const Kalkulator_screen({super.key});

  @override
  State<Kalkulator_screen> createState() => _Kalkulator_screenState();
}

class _Kalkulator_screenState extends State<Kalkulator_screen> {
  // siapkan controller untuk textfield untuk mengambil data
  final angkaPertamaController = TextEditingController();
  final angkaKeduaController = TextEditingController();
  String hasil = 'Hasil perhitungan';

  void hitung(String operasi) {
    // LOGIKA TAMBAHAN: Validasi jika inputan masih kosong agar aplikasi tidak crash
    if (angkaPertamaController.text.isEmpty || angkaKeduaController.text.isEmpty) {
      setState(() {
        hasil = "Mohon isi kedua angka terlebih dahulu";
      });
      return;
    }

    // siapkan dulu variabel angka yang mau dihitung
    double angka1 = double.parse(angkaPertamaController.text);
    double angka2 = double.parse(angkaKeduaController.text);

    // hitung berdasarkan operasi
    // PERBAIKAN LOGIKA: Mengubah sintaksis 'hasilOperasi:' yang salah menjadi penugasan ke variabel 'hasil'
    // serta memperbaiki operator matematika yang sebelumnya semuanya tertulis '+'
    switch (operasi) {
      case '+':
        hasil = (angka1 + angka2).toString();
        break;
      case '-':
        hasil = (angka1 - angka2).toString(); // Diubah ke -
        break;
      case 'x':
        hasil = (angka1 * angka2).toString(); // Diubah ke *
        break;
      case ':':
        if (angka2 == 0) {
          setState(() {
            hasil = "Pembagian dengan nol tidak bisa dilakukan";
          });
          return;
        }
        hasil = (angka1 / angka2).toString();
        break;
      default:
        hasil = "Operasi tidak dikenali";
        return;
    }

    setState(() {
      // PERBAIKAN: Menghapus angka di belakang koma yang tidak perlu (misal 5.0 menjadi 5)
      if (hasil.endsWith('.0')) {
        hasil = hasil.substring(0, hasil.length - 2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        // TAMPILAN: Menambahkan padding di seluruh halaman agar tidak mepet ke layar
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TAMPILAN: Input pertama dengan tipe keyboard khusus angka
            TextField(
              controller: angkaPertamaController, // PERBAIKAN: Controller harus dipasang di sini
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angka Pertama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_one),
              ),
            ),
            const SizedBox(height: 15), // TAMPILAN: Jarak antar input
            // TAMPILAN: Input kedua dengan tipe keyboard khusus angka
            TextField(
              controller: angkaKeduaController, // PERBAIKAN: Controller harus dipasang di sini
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angka Kedua',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_two),
              ),
            ),
            const SizedBox(height: 25),
            // TAMPILAN: Membuat tombol operasi matematika berjejer rapi dan proporsional
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
                      onPressed: () => hitung('+'), 
                      child: const Text("+", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
                      onPressed: () => hitung('-'), 
                      child: const Text("-", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
                      onPressed: () => hitung('x'), 
                      child: const Text("x", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
                      onPressed: () => hitung(':'), 
                      child: const Text(":", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // TAMPILAN: Desain visual untuk menampilkan hasil perhitungan
            Card(
              color: Colors.blue.shade50,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Hasil Perhitungan:',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      hasil,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
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
