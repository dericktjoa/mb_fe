import 'package:mb_fe/animal_description/model/animal.dart';

final List<Animal> animals = [
  Animal(
    name: 'Badak',
    continent: 'Asia & Afrika', 
    fact: 'Cula badak terbuat dari keratin, materi yang sama seperti kuku manusia.',
    modelPath: 'images/Rhinoceros.glb',
    imagePath: 'lib/assets/images/badak.jpeg',
 
    description: [
      {
        'title': 'Mamalia Besar Terancam Punah',
        'content': 'Badak merupakan salah satu mamalia besar di dunia yang terancam punah. Di Indonesia sendiri terdapat dua spesies, yaitu badak sumatera (Dicerorhinus sumatrensis) dan badak jawa (Rhinoceros sondaicus).'
      },
      {
        'title': 'Badak Sumatera',
        'content': 'Dikenal sebagai badak berambut atau badak Asia bercula dua. Badak sumatera merupakan badak terkecil dengan tinggi 112-145 cm dan berat mencapai 500-1000 kg. Sebagaimana spesies badak Afrika, ia memiliki dua cula.'
      },
      {
        'title': 'Badak Jawa',
        'content': 'Sering disebut badak bercula satu, memiliki kulit bermosaik yang menyerupai baju baja. Ukurannya sedikit lebih kecil dari badak india. Culanya pun lebih kecil dari spesies badak lainnya, biasanya kurang dari 20 cm.'
      }
    ],
  ),
  Animal(
    name: 'Panda',
    continent: 'Asia',
    fact: 'Panda gemar makan bambu dan menghabiskan sekitar 12 jam sehari untuk makan.',
    modelPath: 'images/Panda.glb',
    imagePath: 'lib/assets/images/panda.jpeg',
    description: [
      {
        'title': 'Spesies Ikonik Tiongkok',
        'content': 'Panda raksasa adalah mamalia beruang yang terkenal dengan bulu hitam-putihnya yang khas. Mereka hidup di hutan pegunungan Tiongkok dan diet utamanya terdiri dari bambu.'
      },
      {
        'title': 'Adaptasi Unik',
        'content': 'Panda dewasa memiliki berat mencapai 100-115 kg. Mereka memiliki adaptasi unik berupa "ibu jari palsu" pada pergelangan tangannya, yang sebenarnya adalah tulang pergelangan tangan yang termodifikasi untuk membantunya memegang bambu saat makan.'
      }
    ],
  ),
  Animal(
    name: 'Harimau',
    continent: 'Asia',
    fact: 'Setiap harimau memiliki pola belang yang unik, seperti sidik jari pada manusia.',
    modelPath: 'images/Tiger.glb',
    imagePath: 'lib/assets/images/harimau.jpeg',
    description: [
      {
        'title': 'Kucing Terbesar di Dunia',
        'content': 'Harimau adalah spesies kucing terbesar yang dikenal dengan corak belang vertikal pada bulu oranye atau kuning kemerahan. Mereka adalah predator puncak di ekosistemnya.'
      },
      {
        'title': 'Anatomi Pemburu',
        'content': 'Dengan tubuh yang kuat, rahang yang kokoh, serta cakar dan gigi yang sangat tajam, harimau adalah pemburu yang tangguh. Sayangnya, beberapa subspesies seperti Harimau Sumatera kini berada di ambang kepunahan.'
      }
    ],
  ),
];