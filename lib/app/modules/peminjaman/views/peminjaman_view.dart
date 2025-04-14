import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/peminjaman/controllers/peminjaman_controller.dart';
import 'package:sislab/app/data/peminjaman_response.dart'; // Pastikan path ini benar

class PeminjamanView extends StatelessWidget {
  final PeminjamanController controller = Get.put(PeminjamanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Peminjaman', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightGreen[300], // Warna app bar yang lebih menarik
        elevation: 2, // Tambahkan sedikit bayangan
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.peminjamanList.isEmpty) {
          return Center(
            child: Text(
              'Tidak ada data peminjaman.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated( // Menggunakan ListView.separated untuk menambahkan pemisah
          itemCount: controller.peminjamanList.length,
          separatorBuilder: (context, index) => Divider(color: Colors.grey[300]), // Pemisah antar item
          itemBuilder: (context, index) {
            final peminjaman = controller.peminjamanList[index];
            return Padding( // Tambahkan padding di luar Card
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                elevation: 3, // Tambahkan bayangan pada card
                shape: RoundedRectangleBorder( // Bentuk card yang lebih modern
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding( // Tambahkan padding di dalam Card
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        peminjaman.codePeminjaman ?? "-",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: Colors.blueGrey, size: 16),
                          SizedBox(width: 5),
                          Text('Peminjam: ${peminjaman.anggota?.namaPeminjam ?? "Tidak diketahui"}'),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.local_activity_outlined, color: Colors.green, size: 16),
                          SizedBox(width: 5),
                          Text('Kegiatan: ${peminjaman.jenisKegiatan ?? "-"}'),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, color: Colors.orange, size: 16),
                          SizedBox(width: 5),
                          Text('Tanggal: ${peminjaman.tanggalPeminjaman ?? "-"}'),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.timer_outlined, color: Colors.purple, size: 16),
                          SizedBox(width: 5),
                          Text('Waktu: ${peminjaman.waktuPeminjaman ?? "-"}'),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.room_outlined, color: Colors.redAccent, size: 16),
                          SizedBox(width: 5),
                          Text('Ruangan: ${peminjaman.ruangan?.namaRuangan ?? "-"}'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Barang Dipinjam:', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      if (peminjaman.peminjamanDetails != null && peminjaman.peminjamanDetails!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: peminjaman.peminjamanDetails!.map((detail) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  Icon(Icons.inventory_2_outlined, color: Colors.blueGrey[400], size: 14),
                                  SizedBox(width: 5),
                                  Text('- ${detail.barang?.namaBarang ?? "Barang tidak ada"} (${detail.jumlahPinjam} pcs)'),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('- Tidak ada barang yang dipinjam'),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}