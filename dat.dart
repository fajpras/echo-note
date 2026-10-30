void main() {
  // 1. Variabel data diri
  String namaLengkap = 'Nama Kamu';
  String nim = '055';
  String mataKuliah = 'Pemrograman Perangkat Bergerak';

  // 2. Ambil digit terakhir dan parsing ke int
  int digitTerakhir = int.parse(nim.substring(nim.length - 1));

  // 4. Ambil 2 digit terakhir, lalu jumlahkan
  int digitKedua = int.parse(nim.substring(nim.length - 2, nim.length - 1));
  int jumlah = digitKedua + digitTerakhir;
  if (jumlah == 0) {
    jumlah = 5;
  }

  print('=== BIODATA MOBILE DEVELOPER ===');
  print('Nama : $namaLengkap');
  print('NIM   : $nim');
  print('Mata Kuliah : $mataKuliah');
  print('---------------------------------------');
  print('Digit terakhir NIM saya adalah $digitTerakhir.');

  // 3. Logika if-else genap/ganjil
  if (digitTerakhir % 2 == 0) {
    print('Karakteristik: Saya mahasiswa dengan NIM Genap, '
        'saya akan menguasai logika Dart dengan sabar!');
  } else {
    print('Karakteristik: Saya mahasiswa dengan NIM Ganjil, '
        'saya akan mengeksplorasi UI Flutter dengan kreatif!');
  }

  print('---------------------------------------');
  print('Total 2 digit terakhir NIM ($digitKedua + $digitTerakhir) = $jumlah.');
  print('');

  // 5. Perulangan sebanyak hasil penjumlahan
  print('Memulai perulangan:');
  for (int i = 1; i <= jumlah; i++) {
    print('Iterasi ke-$i: $namaLengkap siap mengerjakan project Mobile!');
  }

  print('');
  print('=== PROGRAM SELESAI ===');
}