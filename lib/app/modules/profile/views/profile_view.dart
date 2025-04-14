import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.put(ProfileController());

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchProfile(); // Ambil data saat tampilan dibuka

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal[300], // Warna app bar yang segar
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value;

        if (user == null) {
          return const Center(child: Text("Wah, kayaknya data penggunanya lagi menghilang nih..."));
        }

        return SingleChildScrollView( // Biar bisa di-scroll kalau datanya banyak
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.teal[200],
                      child: const Icon(Icons.person, size: 70, color: Colors.white),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.amber[300],
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.edit, size: 20, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nama Lengkap',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.name ?? '-',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        const Divider(height: 30, thickness: 1, color: Colors.tealAccent),
                        const Text(
                          'Alamat Email',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.email ?? '-',
                          style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Kamu bisa tambahin info profil lain di sini dengan format yang sama
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Halaman Admin SISLAB',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        Text('_________', style: TextStyle(color: Colors.black54)),
                        // Contoh lain:
                        // SizedBox(height: 8),
                        // Text('Nomor Telepon: -', style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}