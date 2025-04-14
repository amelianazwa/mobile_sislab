import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sislab/app/routes/app_pages.dart';
import 'package:sislab/app/modules/profile/views/profile_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Inventaris', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo[300], // Warna app bar yang lebih kalem
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Fitur pencarian (belum diimplementasi)
              print('Tombol pencarian ditekan');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo[200], // Warna header drawer yang lebih lembut
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Menu SISLAB',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Kelola Inventaris dengan Mudah!',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => ProfileView());
              },
            ),
            const Divider(color: Colors.grey), // Pemisah antar menu
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Tampilkan dialog konfirmasi logout
                Get.defaultDialog(
                  title: "Logout",
                  middleText: "Apakah kamu yakin ingin keluar dari aplikasi?",
                  textConfirm: "Ya",
                  textCancel: "Batal",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    final box = GetStorage();
                    box.erase(); // Hapus semua data login/token
                    Get.offAllNamed(Routes.LOGIN); // Navigasi ke halaman login
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView( // Biar bisa di-scroll kalau kontennya banyak
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.waving_hand_outlined, size: 28, color: Colors.amber),
                const SizedBox(width: 8),
                const Text(
                  'Selamat Datang di SISLAB!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                const Spacer(), // Biar icon di ujung
                IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Statistik Cepat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true, // Biar tingginya menyesuaikan isi
              physics: const NeverScrollableScrollPhysics(), // Biar gak bisa di-scroll sendiri
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2, // Sedikit lebih tinggi dari kotak
              children: [
                _buildStatCard('Anggota', '3', Colors.blue.shade200, Icons.people_outline, () {
                  Get.toNamed(Routes.ANGGOTA);
                }),
                _buildStatCard('Barang', '4', Colors.green.shade200, Icons.inventory_2_outlined, () {
                  Get.toNamed(Routes.BARANG);
                }),
                _buildStatCard('Peminjaman', '30', Colors.orange.shade200, Icons.swap_horiz_outlined, () {
                  Get.toNamed(Routes.PEMINJAMAN);
                }),
                _buildStatCard('Pengembalian', '25', Colors.red.shade200, Icons.assignment_returned_outlined, () {
                  print('Tombol Pengembalian ditekan');
                }),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Aktivitas Terakhir',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            _buildActivityTable(), // Widget untuk tabel aktivitas
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData iconData, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 1, // Bayangan lebih tipis
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(iconData, size: 32, color: Colors.white), // Tambah icon
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityTable() {
    // Data dummy untuk tabel (bisa diganti dengan data dari controller)
    final List<Map<String, String>> activityData = [
      {'Aktivitas': 'Peminjaman Barang', 'Waktu': '10:30', 'Status': 'Berhasil'},
      {'Aktivitas': 'Pengembalian Barang', 'Waktu': '14:00', 'Status': 'Selesai'},
      {'Aktivitas': 'Penambahan Barang Baru', 'Waktu': '16:45', 'Status': 'Berhasil'},
      {'Aktivitas': 'Peminjaman Barang', 'Waktu': '19:15', 'Status': 'Menunggu'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2), // Kolom Aktivitas lebih lebar
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        border: TableBorder.all(color: Colors.grey.shade300, width: 1),
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.grey.shade100),
            children: const [
              Padding(padding: EdgeInsets.all(8.0), child: Text('Aktivitas', style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(padding: EdgeInsets.all(8.0), child: Text('Waktu', style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(padding: EdgeInsets.all(8.0), child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          for (var data in activityData)
            TableRow(
              children: [
                Padding(padding: const EdgeInsets.all(8.0), child: Text(data['Aktivitas']!)),
                Padding(padding: const EdgeInsets.all(8.0), child: Text(data['Waktu']!)),
                Padding(padding: const EdgeInsets.all(8.0), child: Text(data['Status']!)),
              ],
            ),
        ],
      ),
    );
  }
}