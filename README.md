# Jadwalin

Aplikasi manajemen jadwal dan tugas kuliah berbasis Flutter yang membantu mahasiswa mengatur mata kuliah, jadwal perkuliahan, serta tugas akademik secara terorganisir. Aplikasi ini dilengkapi dengan sistem autentikasi, manajemen profil, dashboard mahasiswa, dan dashboard administrator.

---

# Anggota Kelompok

| Nama                     | NIM        |
| ------------------------ | ---------- |
| Muhammad Rizqi Firdaus   | 2402310196 |
| Moh Syarif Jauhari       | 2402310153 |
| Zahrotul Wardah          | 2402310200 |
| Sitti Nurul Ainiyah      | 2402310178 |
| Adinda Tria Fortuna      | 2402310160 |
| Raditia Khairul Muttaqin | 2402310206 |
| Fazril Wiryamanta        | 2402310211 |
| M. Rony Rafliansyah      | 2402310168 |

---

# Deskripsi Aplikasi

Jadwalin merupakan aplikasi mobile yang dirancang untuk membantu mahasiswa dalam mengelola aktivitas perkuliahan sehari-hari. Pengguna dapat mencatat mata kuliah, mengatur jadwal kuliah, mengelola tugas beserta deadline, serta memantau progres penyelesaian tugas melalui dashboard yang informatif.

Selain fitur untuk mahasiswa, aplikasi juga menyediakan dashboard administrator yang dapat digunakan untuk melihat jumlah pengguna dan daftar pengguna yang terdaftar pada sistem.

---

# Fitur Mahasiswa

* Login
* Register
* Dashboard Mahasiswa
* CRUD Mata Kuliah
* CRUD Jadwal Kuliah
* CRUD Tugas Kuliah
* Filter Jadwal
* Filter Tugas
* Edit Profil
* Upload Foto Profil
* Ganti Password
* Logout

---

# Fitur Admin

* Dashboard Admin
* Melihat Total Pengguna
* Melihat Daftar Pengguna
* Profil Admin
* Edit Profil
* Ganti Password
* Logout

---

# Teknologi yang Digunakan

## Frontend

* Flutter
* Dart
* HTTP Package
* Shared Preferences
* Image Picker
* Google Fonts

## Backend

* Node.js
* Express.js
* Prisma ORM
* JWT Authentication
* Multer

## Database

* MySQL

---

# Struktur Folder Project

```text
Jadwalin-Project
│
├── backend
│   ├── prisma
│   ├── src
│   │   ├── controllers
│   │   ├── middleware
│   │   ├── routes
│   │   └── services
│   ├── uploads
│   ├── app.js
│   └── server.js
│
├── frontend
│   ├── lib
│   │   ├── models
│   │   ├── screens
│   │   ├── services
│   │   └── main.dart
│
├── screenshots
│
└── README.md
```

---

# Penjelasan Folder Uploads

Folder:

```text
backend/uploads
```

digunakan untuk menyimpan file foto profil yang diunggah oleh pengguna.

Saat pengguna mengganti foto profil melalui aplikasi Flutter:

1. Flutter mengirim gambar menggunakan Multipart Request.
2. Backend menerima gambar menggunakan Multer.
3. File disimpan ke folder uploads.
4. Nama file disimpan pada database.
5. Foto dapat diakses kembali melalui endpoint:

```text
http://IP_SERVER:3000/uploads/nama_file
```

Contoh:

```text
http://192.168.1.3:3000/uploads/1779843541136.png
```

Folder ini harus tetap ada ketika aplikasi dideploy agar fitur foto profil dapat berjalan dengan baik.

---

# Instalasi Backend

Masuk ke folder backend:

```bash
cd backend
```

Install dependency:

```bash
npm install
```

Buat file `.env`

```env
DATABASE_URL="mysql://root:password@localhost:3306/jadwalin_db"
JWT_SECRET=jadwalin_secret
PORT=3000
```

Jalankan migrasi database:

```bash
npx prisma migrate deploy
```

Jalankan server:

```bash
npm run dev
```

---

# Instalasi Frontend

Masuk ke folder frontend:

```bash
cd frontend
```

Install package:

```bash
flutter pub get
```

Jalankan aplikasi:

```bash
flutter run
```

---

# Akun Admin

Role admin dapat diberikan secara langsung melalui database.

Contoh:

```sql
UPDATE user
SET role = 'admin'
WHERE id = 1;
```

---

# Tampilan Aplikasi

## Login

![Login](screenshots/login_screen.jpeg)

## Dashboard Mahasiswa

![Dashboard Mahasiswa](screenshots/dashboard_user.jpeg)

## Jadwal Kuliah

![Jadwal](screenshots/jadwal_screen.jpeg)

## Tugas Kuliah

![Tugas](screenshots/tugas_screen.jpeg)

## Profil Pengguna

![Profile](screenshots/profile_user.jpeg)

## Dashboard Admin

![Dashboard Admin](screenshots/dashboard_admin.jpeg)

---

# Pengujian

Fitur yang telah diuji:

* Login
* Register
* JWT Authentication
* CRUD Mata Kuliah
* CRUD Jadwal
* CRUD Tugas
* Upload Foto Profil
* Edit Profil
* Ganti Password
* Dashboard Mahasiswa
* Dashboard Admin
* Filter Jadwal
* Filter Tugas

Seluruh fitur berhasil dijalankan tanpa error pada tahap pengujian akhir.

---

# Lisensi

Project ini dibuat untuk keperluan akademik dan pembelajaran pada mata kuliah Software Engineering.
