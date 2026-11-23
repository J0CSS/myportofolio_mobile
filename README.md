### Tugas 7

1. Widget tree adalah susunan widget dengan layer yang membentuk ui flutter. Widget di tingkat atas menjadi parent bagi widget yang berada di dalamnya. Parent mengatur struktur dan anak mengisi bagian yang disediakan parent.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!
- MyApp         : widget buatan sendiri yang menjadi titik awal struktur aplikasi.
- MaterialApp   : menyediakan kerangka aplikasi bergaya Material, termasuk tema dan halaman awal.
- MyHomePage    : widget buatan sendiri yang menyusun halaman utama portofolio.
- Scaffold      : menyediakan kerangka halaman, seperti area AppBar dan body.
- AppBar        : menampilkan bilah atas dengan judul aplikasi.
- Text          : menampilkan teks, misalnya judul, nama, NPM, kelas, dan pesan.
- ListView      : menyusun konten halaman secara vertikal dan memungkinkan halaman digulir.
- Row           : menyusun kartu informasi secara horizontal.
- InfoCard      : widget buatan sendiri untuk menampilkan judul dan isi informasi dalam kartu.
- Card          : memberi tampilan kartu pada informasi.
- Container     : mengatur lebar, padding, dan konten kartu.
- Column        : menyusun widget secara vertikal, seperti judul dan isi pada InfoCard.
- SizedBox      : memberikan jarak berukuran tertentu.
- Padding       : menambahkan ruang di sekeliling anaknya.
- GridView.count: menampilkan menu dalam susunan kisi dengan jumlah kolom tertentu.
- ItemCard      : widget buatan sendiri untuk menampilkan satu item menu yang dapat ditekan.
- Material      : menyediakan permukaan Material dan warna latar untuk item menu.
- InkWell       : membuat area anak merespons sentuhan dan menjalankan onTap.
- Center        : menempatkan kontennya di tengah.
- Icon          : menampilkan ikon menu.
- SnackBar      : menampilkan pesan sementara setelah item menu ditekan.
- ScaffoldMessenger: mengakses pengelola pesan milik Scaffold.
- NeverScrollableScrollPhysics: mengatur agar kisi tidak menggulir sendiri; halaman digulir melalui ListView.


3. MaterialApp adalah widget yang untuk konfigurasi dasar aplikasi dengan style Material Design. Yang pada tugas ini mengatur judul aplikasi, tema warna, material 3, halaman awal dengan home: MyHomePage().

Widget ini sering menjadi root widget karena menampung halaman-halaman aplikasi, menyediakan konfigurasi, dan layanan yang dibutuhkan widget di bawahnya. MyApp menjadi widget teratas yang diberikan ke runApp, dan MaterialApp berada di dalamnya.

4. StatelessWidget cocok untuk tampilan yang tidak berubah. Nilai tampilannya berasal dari konfigurasi atau data yang diterima. Contoh di proyek ini: MyApp, MyHomePage, InfoCard, dan ItemCard.

StatefulWidget digunakan ketika widget perlu menyimpan dan memperbarui keadaan yang berubah, seperti nilai penghitung, status pilihan, atau input form. 

Inti: StatelessWidget untuk tampilan yang tidak dipengaruhi perubahan. Pilih StatefulWidget ketika di dalam widget perlu mengubah tampilannya dari waktu ke waktu. 

5. BuildContext adalah referensi posisi sebuah widget di dalam widget tree. Flutter menggunakannya agar widget dapat menemukan informasi dari widget di atasnya. Di dalam build, konteks ini dipakai, misalnya, oleh Theme.of(context) untuk mengambil warna tema dan oleh MediaQuery.of(context) untuk membaca ukuran layar. ScaffoldMessenger.of(context) juga memakai konteks untuk menemukan pengelola SnackBar yang sesuai.

6. Hot reload menerapkan perubahan kode ke aplikasi yang sedang berjalan dan mempertahankan state yang ada. Ini berguna untuk perubahan tampilan atau logika dalam widget yang sudah aktif.

Hot restart memulai ulang aplikasi dari awal, state aplikasi direset. Hot restart diperlukan ketika perubahan perlu diterapkan sejak awal proses aplikasi atau hot reload tidak memperbarui keadaan yang sedang berjalan. Contohnya termasuk perubahan yang bergantung pada inisialisasi awal atau perubahan pada main().

Full restart menghentikan dan menjalankan ulang aplikasi sepenuhnya. Ini dapat diperlukan ketika perubahan terkait proses native atau konfigurasi platform, seperti perubahan kode Android/iOS, plugin, atau konfigurasi build, yang tidak diterapkan oleh hot reload maupun hot restart saja.

AI Disclosure
Gen AI yang digunakan adalah chatgpt luna 6 medium. Startegi prompting adalah dari awal mencantumkan tutorial dn tugas sepenuhnya agar ai dpat memahami konteks secara akurat. Kemudian saya akan mengerjakan codenya sendiri terlebih dahulu dan menanyakan AI apakah sudah sesuai dengan checklist. Pada tugas ini AI mempunyai 3 peran, yaitu mereview ulang checklist, mengatasi pixel out of bound, dan git flow saat perubahan di main dan branch berbeda tetapi sudah di commit. Pada masalah pixel, AI mensugesti halaman view dapat di scroll dan memberikan codenya secara langsung.

AI chat: [text](https://chatgpt.com/s/cx_6afb28e710788191bcaa32ef4913961e)


### Tugas 8
1. Navigator.push() -> seperti stack, membuka halaman baru di atas halaman sekarang
Navigator.pushReplacement() -> menghapus halaman terlebih dahulu kemudian baru membuka halaman baru
Navigator.pop() ->  menutup halaman paling atas kemudian memunculkan halaman sebelumnya
Metode untuk membuka formulir dari kartu aksi -> push()
Opsi Home di drawer membawa pengguna kembali ke halaman utama dengan cara memakai pushReplacement(). Dimana saat user memilih Home di drawer, Navigator.pushReplacement() mengganti halaman formulir dan  membuka page main. 

2. Scaffold untuk frame halaman, seperti area untuk AppBar, isi halaman, dan drawer. Dengan susunan ini di beberapa halaman dapat menjaga layoutnya agar konsisten. Seperti pda AppBar yang memakai warna indigo di halaman utama dan formulir.

3. Padding memberi jarak di sekitar input agar formulir lebih mudah dibaca. SingleChildScrollView agar user dapat mengscroll halaman saat widget tidak muat di layar.

4. GlobalKey<FormState> memberi akses ke status formulir. Setiap validator memeriksa nilai kolom, lalu validate() mengecek saat tombol save ditekan. Contohnya, URL thumbnail abc ditolak karena bukan URL http atau https yang valid. Memilih jenis kolom atau papan ketik yang sesuai membantu pengguna memasukkan data, tetapi tidak memastikan nilainya valid, recheck dengan logika lain tetap diperlukan.

AI Disclosure: Tidak memakai AI untuk tugas ini