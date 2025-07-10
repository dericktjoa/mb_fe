import 'package:mb_fe/animal_description/model/animal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';

class AnimalDetailPage extends StatelessWidget {
  final Animal animal;

  const AnimalDetailPage({super.key, required this.animal});

  void showAnimalInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    animal.imagePath,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          animal.name,
                          style: GoogleFonts.secularOne(fontSize: 34, height: 1.2),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          animal.fact,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const Divider(height: 32, thickness: 1),

                        // --- PERUBAHAN UTAMA DI SINI ---
                        // Menggunakan Column untuk menampilkan daftar deskripsi yang sudah dipecah
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // animal.description sekarang adalah List, kita gunakan map untuk mengubahnya menjadi widget
                          children: animal.description.map((descSection) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Widget untuk 'title'
                                  Text(
                                    descSection['title']!, // Ambil judul dari map
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : const Color(0xFFa6dbbc), // Gunakan warna tema
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  // Widget untuk 'content'
                                  Text(
                                    descSection['content']!, // Ambil konten dari map
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            );
                          }).toList(), // Ubah hasil map menjadi List<Widget>
                        ),

                        // --- AKHIR DARI PERUBAHAN ---

                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? const Color(0xFF333739)
                                  : const Color(0xFFa6dbbc),
                              foregroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Tutup', style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: animal.name, showMenu: false,),
      // appBar: AppBar(
      //   title: Text(animal.name, style: GoogleFonts.secularOne()),
      //   backgroundColor: const Color(0xFFa6dbbc),
      //   elevation: 0,
      //   foregroundColor: Colors.black87,
      // ),
      extendBodyBehindAppBar: true,
      body: ModelViewer(
        backgroundColor: const Color.fromARGB(255, 224, 240, 255),
        src: animal.modelPath,
        alt: animal.name,
        autoRotate: true,
        cameraControls: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAnimalInfoDialog(context),
        label: Text('Info Hewan', style: GoogleFonts.lato()),
        icon: const Icon(Icons.info_outline),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey
            : const Color(0xFFa6dbbc),
        foregroundColor: Colors.black87,
      ),
    );
  }
}