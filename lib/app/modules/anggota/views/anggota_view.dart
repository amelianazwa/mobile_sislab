import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/anggota/controllers/anggota_controller.dart';
import 'package:sislab/app/data/anggota_response.dart';

class AnggotaView extends GetView<AnggotaController> {
  const AnggotaView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnggotaController()); // Register controller

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Anggota'),
        centerTitle: true,
      ),
      body: Obx(() {
        // Debugging: Cek isi anggotaList
        print("Isi anggotaList di View: ${controller.anggotaList}");

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.anggotaList.isEmpty) {
          return const Center(child: Text('Tidak ada data anggota'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: controller.anggotaList.length,
          itemBuilder: (context, index) {
            final Data anggota = controller.anggotaList[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.person, color: Colors.blue),
                  ),
                  title: Text(
                    anggota.namaPeminjam ?? "Nama tidak tersedia",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        anggota.email ?? "Email tidak tersedia",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        anggota.instansiLembaga ?? "Instansi tidak tersedia",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.snackbar(
                      'Anggota Dipilih',
                      anggota.nim ?? "Kode tidak tersedia",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.blue.shade100,
                      colorText: Colors.black,
                      margin: const EdgeInsets.all(10),
                      duration: const Duration(seconds: 2),
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
