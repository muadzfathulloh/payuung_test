import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/app/modules/account/controllers/account_controller.dart';
import 'package:payuung/app/widgets/app_button.dart';
import 'package:payuung/app/widgets/dropdown_widget.dart';
import 'package:payuung/app/widgets/text_field_widget.dart';

class TimelineThird extends StatelessWidget {
  const TimelineThird({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AccountController.to;
    return Form(
      key: AccountController.to.formKey3,
      child: GetBuilder<AccountController>(
        builder: (controller) {
          return ListView(
            children: [
              TextFieldWidget(
                labelText: 'NAMA USAHA/PERUSAHAAN',
                controller: controller.namaUsahaController,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'Nama Usaha/Perusahaan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFieldWidget(
                  labelText: 'ALAMAT USAHA',
                  controller: controller.alamatUsahaController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Alamat Usaha tidak boleh kosong';
                    }
                    return null;
                  }),
              DropdownWidget(
                labelText: 'JABATAN',
                value: controller.jabatan,
                items: const [
                  DropdownMenuItem(value: 'Manager', child: Text('Manager')),
                  DropdownMenuItem(value: 'Staff', child: Text('Staff')),
                  DropdownMenuItem(value: 'Intern', child: Text('Intern')),
                ],
                onChanged: (p0) => controller.jabatan = p0.toString(),
                validator: (p0) => p0 == null ? 'Jabatan tidak boleh kosong' : null,
              ),
              DropdownWidget(
                labelText: 'LAMA BEKERJA',
                value: controller.lamaBekerja,
                items: const [
                  DropdownMenuItem(value: '< 1 Tahun', child: Text('< 1 Tahun')),
                  DropdownMenuItem(value: '1-3 Tahun', child: Text('1-3 Tahun')),
                  DropdownMenuItem(value: '> 3 Tahun', child: Text('> 3 Tahun')),
                ],
                onChanged: (p0) => controller.lamaBekerja = p0.toString(),
                validator: (p0) => p0 == null ? 'Lama bekerja tidak boleh kosong' : null,
              ),
              DropdownWidget(
                labelText: 'SUMBER PENDAPATAN',
                value: controller.sumberPendapatan,
                items: const [
                  DropdownMenuItem(value: 'Gaji', child: Text('Gaji')),
                  DropdownMenuItem(value: 'Usaha', child: Text('Usaha')),
                  DropdownMenuItem(value: 'Investasi', child: Text('Investasi')),
                ],
                onChanged: (p0) => controller.sumberPendapatan = p0.toString(),
                validator: (p0) => p0 == null ? 'Sumber pendapatan tidak boleh kosong' : null,
              ),
              DropdownWidget(
                labelText: 'PENDAPATAN KOTOR PERTAHUN',
                value: controller.pendapatanKotor,
                items: const [
                  DropdownMenuItem(value: '< 50 Juta', child: Text('< 50 Juta')),
                  DropdownMenuItem(value: '50-100 Juta', child: Text('50-100 Juta')),
                  DropdownMenuItem(value: '> 100 Juta', child: Text('> 100 Juta')),
                ],
                onChanged: (p0) => controller.pendapatanKotor = p0.toString(),
                validator: (p0) => p0 == null ? 'Pendapatan kotor pertahun tidak boleh kosong' : null,
              ),
              DropdownWidget(
                labelText: 'NAMA BANK',
                value: controller.namaBank,
                items: const [
                  DropdownMenuItem(value: 'Bank A', child: Text('Bank A')),
                  DropdownMenuItem(value: 'Bank B', child: Text('Bank B')),
                  DropdownMenuItem(value: 'Bank C', child: Text('Bank C')),
                ],
                onChanged: (p0) => controller.namaBank = p0.toString(),
                validator: (p0) => p0 == null ? 'Nama bank tidak boleh kosong' : null,
              ),
              TextFieldWidget(
                  labelText: 'CABANG BANK',
                  controller: controller.cabangBankController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Cabang bank tidak boleh kosong';
                    }
                    return null;
                  }),
              TextFieldWidget(
                  labelText: 'NOMOR REKENING',
                  controller: controller.nomorRekeningController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Nomor rekening tidak boleh kosong';
                    }
                    return null;
                  }),
              TextFieldWidget(
                  labelText: 'NAMA PEMILIK REKENING',
                  controller: controller.namaPemilikRekeningController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Nama pemilik rekening tidak boleh kosong';
                    }
                    return null;
                  }),

              //Button
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: AppButton.outlined(
                      text: 'Kembali',
                      onTap: () async {
                        controller.changeIndex(1);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButton.elevated(
                      text: 'Simpan',
                      onTap: () async {
                        controller.submit();

                        if (controller.formKey3.currentState!.validate()) {
                          // controller.changeIndex(3);
                        }
                        // controller.changeIndex(2);
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
