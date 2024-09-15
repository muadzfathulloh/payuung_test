import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/app/components/app_colors.dart';
import 'package:payuung/app/modules/account/controllers/account_controller.dart';
import 'package:payuung/app/widgets/app_button.dart';
import 'package:payuung/app/widgets/dropdown_widget.dart';
import 'package:payuung/app/widgets/text_field_widget.dart';

class TimelineFirst extends StatelessWidget {
  const TimelineFirst({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController.to;
    return GetBuilder<AccountController>(
      builder: (_) {
        return Form(
          key: _.formKey1,
          child: ListView(
            children: [
              TextFieldWidget(
                labelText: 'NAMA LENGKAP',
                controller: _.namaController,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFieldWidget(
                  controller: _.tanggallahirController,
                  onTap: () async {
                    var datePicked = await Get.dialog(
                      Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppColor.primary, // Header background color
                            onPrimary: Colors.white, // Header text color
                            onSurface: Colors.black, // Body text color
                          ),
                        ),
                        child: DatePickerDialog(
                          initialCalendarMode: DatePickerMode.year,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2050),
                        ),
                      ),
                    );
                    print(datePicked);
                    if (datePicked != null) {
                      _.tanggallahirController.text = datePicked.toString();
                    }
                  },
                  enabled: false,
                  validator: (p0) => p0!.isEmpty ? 'Tanggal lahir tidak boleh kosong' : null,
                  labelText: 'TANGGAL LAHIR',
                  suffix: const Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.calendar_month))),
              DropdownWidget(
                  items: _.jeniskelaminList,
                  value: _.jeniskelaminController,
                  labelText: 'JENIS KELAMIN',
                  isRequired: true,
                  onChanged: (p0) => _.jeniskelaminController = p0,
                  validator: (p0) => p0 == null ? 'Jenis kelamin tidak boleh kosong' : null),
              TextFieldWidget(
                  controller: _.emailController,
                  labelText: 'ALAMAT EMAIL',
                  validator: (p0) => p0!.isEmpty ? 'Email tidak boleh kosong' : null),
              TextFieldWidget(
                  controller: _.nohpController,
                  labelText: 'NO. HP',
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'No. HP tidak boleh kosong';
                    }
                    return null;
                  }),
              DropdownWidget(
                items: _.pendidikanList,
                value: _.pendidikanController,
                labelText: 'PENDIDIKAN TERAKHIR',
                isRequired: true,
                onChanged: (p0) => _.pendidikanController = p0,
                validator: (p0) => p0 == null ? 'Pendidikan terakhir tidak boleh kosong' : null,
              ),
              DropdownWidget(
                  items: _.statusPernikahanList,
                  value: _.statusPernikahanController,
                  labelText: 'STATUS PERNIKAHAN',
                  onChanged: (p0) => _.statusPernikahanController = p0,
                  validator: (p0) => p0 == null ? 'Status pernikahan tidak boleh kosong' : null,
                  isRequired: true),
              const SizedBox(height: 20),
              AppButton.elevated(
                text: 'Selanjutnya',
                onTap: () async {
                  if (_.formKey1.currentState!.validate()) {
                    _.changeIndex(1);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
