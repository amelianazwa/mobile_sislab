import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/barang/controllers/barang_controller.dart';
import 'package:sislab/app/data/barang_response.dart';


class BarangView extends StatelessWidget {
  final controller = Get.put(BarangController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Barang")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.barangList.isEmpty) {
          return const Center(child: Text('Data barang kosong'));
        }

        return ListView.builder(
          itemCount: controller.barangList.length,
          itemBuilder: (context, index) {
            final item = controller.barangList[index];
            return ListTile(
              leading: CircleAvatar(child: Text(item.codeBarang!.substring(0, 2))),
              title: Text(item.namaBarang ?? '-'),
              subtitle: Text("Merk: ${item.merk ?? '-'} | Jumlah: ${item.jumlah ?? '0'}"),
              trailing: Text(item.detail ?? '', style: const TextStyle(fontSize: 12)),
            );
          },
        );
      }),
    );
  }
}
