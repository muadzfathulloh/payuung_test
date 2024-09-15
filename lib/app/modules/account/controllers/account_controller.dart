import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:payuung/app/data/core/sqflite_core.dart';
import 'package:payuung/app/data/model/cities.dart';
import 'package:payuung/app/modules/profile/controllers/profile_controller.dart';

class AccountController extends GetxController {
  static AccountController get to => Get.isRegistered<AccountController>() ? Get.find() : Get.put(AccountController());
  var currentIndex = 0;

  PageController pageController = PageController(initialPage: 0);
  final ImagePicker _picker = ImagePicker();

  final AppSqlite _sqlite = AppSqlite();
  XFile? imageKtp;

  // formkey
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

  //first page
  TextEditingController namaController = TextEditingController();
  TextEditingController tanggallahirController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  String? jeniskelaminController;
  String? pendidikanController;
  String? statusPernikahanController;

  //second page
  bool isSameAddress = true;

  TextEditingController NIKController = TextEditingController();
  TextEditingController alamatKtpController = TextEditingController();
  TextEditingController kodeposController = TextEditingController();
  String? provinsiController;
  String? kotaController;
  String? kecamatanController;
  String? kelurahanController;
  TextEditingController alamatKtp2Controller = TextEditingController();
  TextEditingController kodepos2Controller = TextEditingController();
  String? provinsi2Controller;
  String? kota2Controller;
  String? kecamatan2Controller;
  String? kelurahan2Controller;

  //third page
  TextEditingController namaUsahaController = TextEditingController();
  TextEditingController alamatUsahaController = TextEditingController();
  TextEditingController nomorRekeningController = TextEditingController();
  TextEditingController cabangBankController = TextEditingController();
  TextEditingController namaPemilikRekeningController = TextEditingController();

  String? jabatan;
  String? lamaBekerja;
  String? sumberPendapatan;
  String? pendapatanKotor;
  String? namaBank;

  Key kotakey = GlobalKey();
  Key kecamatanKey = GlobalKey();
  Key kelurahanKey = GlobalKey();
  Key kota2key = GlobalKey();
  Key kecamatan2Key = GlobalKey();
  Key kelurahan2Key = GlobalKey();

  RxList<Province> provinces = <Province>[].obs;
  RxList<City> cities = <City>[].obs;
  RxList<Province> provinces2 = <Province>[].obs;
  RxList<City> cities2 = <City>[].obs;

  List<DropdownMenuItem<String>> jeniskelaminList = const [
    DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
    DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
  ];

  List<DropdownMenuItem<String>> pendidikanList = const [
    DropdownMenuItem(value: 'SD', child: Text('SD')),
    DropdownMenuItem(value: 'SMP', child: Text('SMP')),
    DropdownMenuItem(value: 'SMA', child: Text('SMA')),
    DropdownMenuItem(value: 'D3', child: Text('D3')),
    DropdownMenuItem(value: 'S1', child: Text('S1')),
    DropdownMenuItem(value: 'S2', child: Text('S2')),
    DropdownMenuItem(value: 'S3', child: Text('S3')),
  ];

  List<DropdownMenuItem<String>> statusPernikahanList = const [
    DropdownMenuItem(value: 'Belum Menikah', child: Text('Belum Menikah')),
    DropdownMenuItem(value: 'Menikah', child: Text('Menikah')),
    DropdownMenuItem(value: 'Duda', child: Text('Duda')),
    DropdownMenuItem(value: 'Janda', child: Text('Janda')),
  ];

  //second page
  List<DropdownMenuItem<String>> provinsiList = const [
    DropdownMenuItem(value: 'Jawa Barat', child: Text('Jawa Barat')),
    DropdownMenuItem(value: 'Jawa Tengah', child: Text('Jawa Tengah')),
    DropdownMenuItem(value: 'Jawa Timur', child: Text('Jawa Timur')),
    DropdownMenuItem(value: 'DKI Jakarta', child: Text('DKI Jakarta')),
    DropdownMenuItem(value: 'Banten', child: Text('Banten')),
  ];

  List<DropdownMenuItem<String>> kotaList = const [
    DropdownMenuItem(value: 'Bandung', child: Text('Bandung')),
    DropdownMenuItem(value: 'Jakarta', child: Text('Jakarta')),
    DropdownMenuItem(value: 'Surabaya', child: Text('Surabaya')),
    DropdownMenuItem(value: 'Semarang', child: Text('Semarang')),
    DropdownMenuItem(value: 'Bekasi', child: Text('Bekasi')),
  ];

  List<DropdownMenuItem<String>> kecamatanList = const [
    DropdownMenuItem(value: 'Cibiru', child: Text('Cibiru')),
    DropdownMenuItem(value: 'Cibaduyut', child: Text('Cibaduyut')),
    DropdownMenuItem(value: 'Cibitung', child: Text('Cibitung')),
    DropdownMenuItem(value: 'Cibinong', child: Text('Cibinong')),
    DropdownMenuItem(value: 'Cibitung', child: Text('Cibitung')),
  ];

  List<DropdownMenuItem<String>> kelurahanList = const [
    DropdownMenuItem(value: 'Cibiru', child: Text('Cibiru')),
    DropdownMenuItem(value: 'Cibaduyut', child: Text('Cibaduyut')),
    DropdownMenuItem(value: 'Cibitung', child: Text('Cibitung')),
    DropdownMenuItem(value: 'Cibinong', child: Text('Cibinong')),
    DropdownMenuItem(value: 'Cibitung', child: Text('Cibitung')),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchProvinces();
    if (ProfileController.to.profile.isNotEmpty) {
      initProfile();
    }
  }

  void initProfile() {
    //init form ProfileController.to.profile;
    namaController.text = ProfileController.to.profile['nama'];
    tanggallahirController.text = ProfileController.to.profile['tanggal_lahir'];
    emailController.text = ProfileController.to.profile['email'];
    nohpController.text = ProfileController.to.profile['no_hp'];
    jeniskelaminController = ProfileController.to.profile['jenis_kelamin'];
    pendidikanController = ProfileController.to.profile['pendidikan'];
    statusPernikahanController = ProfileController.to.profile['status_pernikahan'];
    NIKController.text = ProfileController.to.profile['nik'];
    alamatKtpController.text = ProfileController.to.profile['alamat_ktp'];
    kodeposController.text = ProfileController.to.profile['kodepos'];
    provinsiController = ProfileController.to.profile['provinsi'];
    kotaController = ProfileController.to.profile['kota'];
    kecamatanController = ProfileController.to.profile['kecamatan'];
    kelurahanController = ProfileController.to.profile['kelurahan'];
    alamatKtp2Controller.text = ProfileController.to.profile['alamat_domisili'];
    kodepos2Controller.text = ProfileController.to.profile['kodepos_domisili'];
    provinsi2Controller = ProfileController.to.profile['provinsi_domisili'];
    kota2Controller = ProfileController.to.profile['kota_domisili'];
    kecamatan2Controller = ProfileController.to.profile['kecamatan_domisili'];
    kelurahan2Controller = ProfileController.to.profile['kelurahan_domisili'];
    namaUsahaController.text = ProfileController.to.profile['nama_usaha'];
    alamatUsahaController.text = ProfileController.to.profile['alamat_usaha'];
    jabatan = ProfileController.to.profile['jabatan'];
    lamaBekerja = ProfileController.to.profile['lama_bekerja'];
    sumberPendapatan = ProfileController.to.profile['sumber_pendapatan'];
    pendapatanKotor = ProfileController.to.profile['pendapatan_kotor'];
    namaBank = ProfileController.to.profile['nama_bank'];
    nomorRekeningController.text = ProfileController.to.profile['nomor_rekening'];
    cabangBankController.text = ProfileController.to.profile['cabang_bank'];
    namaPemilikRekeningController.text = ProfileController.to.profile['nama_pemilik_rekening'];
  }

  Future<void> submit() async {
    if (namaController.text.isEmpty ||
        tanggallahirController.text.isEmpty ||
        emailController.text.isEmpty ||
        nohpController.text.isEmpty ||
        jeniskelaminController == null ||
        pendidikanController == null ||
        statusPernikahanController == null ||
        NIKController.text.isEmpty ||
        alamatKtpController.text.isEmpty ||
        kodeposController.text.isEmpty ||
        // provinsiController == null ||
        // kotaController == null ||
        // kecamatanController == null ||
        // kelurahanController == null ||
        namaUsahaController.text.isEmpty ||
        alamatUsahaController.text.isEmpty ||
        jabatan == null ||
        lamaBekerja == null ||
        sumberPendapatan == null ||
        pendapatanKotor == null ||
        namaBank == null ||
        nomorRekeningController.text.isEmpty ||
        cabangBankController.text.isEmpty ||
        namaPemilikRekeningController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all the form');
      return;
    }
    Map<String, dynamic> data = {
      "nama": namaController.text,
      "tanggal_lahir": tanggallahirController.text,
      "email": emailController.text,
      "no_hp": nohpController.text,
      "jenis_kelamin": jeniskelaminController!,
      "pendidikan": pendidikanController!,
      "status_pernikahan": statusPernikahanController!,
      "nik": NIKController.text,
      "alamat_ktp": alamatKtpController.text,
      "kodepos": kodeposController.text,
      "provinsi": provinsiController ?? '',
      "kota": kotaController ?? '',
      "kecamatan": kecamatanController ?? '',
      "kelurahan": kelurahanController ?? '',
      "alamat_domisili": alamatKtp2Controller.text,
      "kodepos_domisili": kodepos2Controller.text,
      "provinsi_domisili": isSameAddress ? (provinsiController ?? '') : provinsi2Controller!,
      "kota_domisili": isSameAddress ? (kotaController ?? '') : kota2Controller!,
      "kecamatan_domisili": isSameAddress ? (kecamatanController ?? '') : kecamatan2Controller!,
      "kelurahan_domisili": isSameAddress ? (kelurahanController ?? '') : kelurahan2Controller!,
      "nama_usaha": namaUsahaController.text,
      "alamat_usaha": alamatUsahaController.text,
      "jabatan": jabatan!,
      "lama_bekerja": lamaBekerja!,
      "sumber_pendapatan": sumberPendapatan!,
      "pendapatan_kotor": pendapatanKotor!,
      "nama_bank": namaBank!,
      "nomor_rekening": nomorRekeningController.text,
      "cabang_bank": cabangBankController.text,
      "nama_pemilik_rekening": namaPemilikRekeningController.text
    };
    //add data to database
    if (ProfileController.to.profile.isEmpty) {
      await _sqlite.insertItem(data);
      await ProfileController.to.getProfile();
      update();
      Get.back();
    } else {
      await _sqlite.updateItem(ProfileController.to.profile['id'], data);
      await ProfileController.to.getProfile();
      update();
      Get.back();
    }
  }

  Future<void> showImagePickerDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Sumber Gambar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeri'),
                onTap: () async {
                  Navigator.of(context).pop();
                  imageKtp = await _picker.pickImage(source: ImageSource.gallery);
                  if (imageKtp != null) {
                    print('Gambar dari galeri: ${imageKtp!.path}');
                  }
                  update();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  imageKtp = await _picker.pickImage(source: ImageSource.camera);
                  if (imageKtp != null) {
                    print('Gambar dari kamera: ${imageKtp!.path}');
                  }
                  update();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> fetchProvinces() async {
    final response = await http.get(Uri.parse('https://dev.farizdotid.com/api/daerahindonesia/provinsi'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['provinsi'];
      provinces.value = data.map((json) => Province.fromJson(json)).toList();
      provinces2.value = data.map((json) => Province.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  Future<void> fetchCities(String provinceId, {bool isSame = false}) async {
    final response = await http.get(Uri.parse('https://dev.farizdotid.com/api/daerahindonesia/kota?id_provinsi=$provinceId'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['kota_kabupaten'];

      print(response);
      if (isSame) {
        cities2.value = data.map((json) => City.fromJson(json)).toList();
      } else {
        cities.value = data.map((json) => City.fromJson(json)).toList();
      }
      update();
    } else {
      throw Exception('Failed to load cities');
    }
  }

  void changeIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    update();
  }
}
