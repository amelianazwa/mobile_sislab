import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/barang/controllers/barang_controller.dart';
import 'package:sislab/app/data/barang_response.dart';

class BarangView extends StatelessWidget {
  final controller = Get.put(BarangController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Barang",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreen[300], // Warna app bar yang cerah
        elevation: 2,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.barangList.isEmpty) {
          return const Center(
            child: Text(
              'Wah, data barangnya kosong nih!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          itemCount: controller.barangList.length,
          separatorBuilder: (context, index) => const Divider(color: Colors.grey), // Pemisah antar item
          itemBuilder: (context, index) {
            final item = controller.barangList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                elevation: 3, // Ada sedikit bayangan biar kelihatan 'naik'
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Sudutnya melengkung biar modern
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[200], // Warna lingkaran avatar
                    foregroundColor: Colors.white, // Warna huruf di dalam lingkaran
                    child: Text(
                      item.codeBarang!.substring(0, 2).toUpperCase(), // Ambil 2 huruf pertama kode barang
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    item.namaBarang ?? '-',
                    style: const TextStyle(fontWeight: FontWeight.bold), // Nama barang lebih menonjol
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Merk: ${item.merk ?? '-'}", style: const TextStyle(fontSize: 14)),
                      Text("Jumlah: ${item.jumlah ?? '0'} buah", style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Detail:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                      Text(
                        item.detail ?? '-',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        textAlign: TextAlign.end,
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