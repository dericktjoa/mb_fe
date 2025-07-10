import 'package:mb_fe/animal_description/data/animal_data.dart';
import 'package:mb_fe/animal_description/widgets/animal_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';

class Animal3DListPage extends StatelessWidget {
  const Animal3DListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Daftar Hewan 3D'),
      body: ListView.builder(
        itemCount: animals.length,
        itemBuilder: (context, index) {
          final animal = animals[index];
          return ListTile(
            leading: const Icon(Icons.pets),
            title: Text(animal.name),
            subtitle: Text('Benua: ${animal.continent}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AnimalDetailPage(animal: animal), // untuk ganti text pembahasan hewan 
                ),
              );
            },
          );
        },
      ),
    );
  }
}