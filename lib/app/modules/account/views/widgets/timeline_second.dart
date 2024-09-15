import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/app/components/app_colors.dart';
import 'package:payuung/app/data/model/cities.dart';
import 'package:payuung/app/modules/account/controllers/account_controller.dart';
import 'package:payuung/app/widgets/app_button.dart';
import 'package:payuung/app/widgets/dropdown_widget.dart';
import 'package:payuung/app/widgets/text_field_widget.dart';

class TimelineSecond extends StatelessWidget {
  const TimelineSecond({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController.to;
    return GetBuilder<AccountController>(
      builder: (_) {
        return Form(
          key: _.formKey2,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, 3)),
                  ],
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _.showImagePickerDialog(context);
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColor.secondary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.contact_mail_rounded, color: AppColor.primary, size: 25),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              children: [
                                const Text('Upload KTP', style: TextStyle(fontSize: 15)),
                                const Spacer(),
                                if (_.imageKtp != null) Image.file(File(_.imageKtp!.path), width: 50, height: 50),
                              ],
                            ),
                          ),
                          if (_.imageKtp == null) const Spacer()
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      labelText: 'NIK',
                      controller: _.NIKController,
                      padding: EdgeInsets.zero,
                      validator: (p0) => p0 == null ? 'NIK tidak boleh kosong' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFieldWidget(
                labelText: 'ALAMAT SESUAI KTP',
                controller: _.alamatKtpController,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              DropdownWidget(
                items: _.provinces.map((Province province) {
                  return DropdownMenuItem<String>(
                    value: province.id.toString(),
                    child: Text(province.name),
                  );
                }).toList(),
                onChanged: (value) async {
                  _.kotaController = null;
                  _.kecamatanController = null;
                  _.kelurahanController = null;
                  _.kotakey = GlobalKey();
                  _.cities.clear();
                  _.provinsiController = value;
                  _.update();
                  _.fetchCities(value!);
                },
                value: _.provinsiController,
                labelText: 'PROVINSI',
                validator: (p0) {
                  if (p0 == null) {
                    return 'Provinsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              DropdownWidget(
                  enabled: _.cities.isNotEmpty,
                  dropdownKey: _.kotakey,
                  items: _.cities.map((City city) {
                    return DropdownMenuItem<String>(
                      value: city.id.toString(),
                      child: Text(city.name),
                    );
                  }).toList(),
                  value: _.kotaController,
                  onChanged: (p0) async {
                    _.kecamatanController = null;
                    _.kelurahanController = null;
                    _.kotaController = p0;
                    _.kecamatanKey = GlobalKey();
                    _.update();
                  },
                  validator: (p0) => p0 == null ? 'Kota tidak boleh kosong' : null,
                  labelText: 'KOTA/KABUPATEN'),
              DropdownWidget(
                  enabled: _.kotaController?.isNotEmpty ?? false,
                  key: _.kecamatanKey,
                  items: _.kotaController?.isNotEmpty ?? false ? _.kecamatanList : [],
                  value: _.kecamatanController,
                  labelText: 'KECAMATAN',
                  validator: (p0) => p0 == null ? 'Kecamatan tidak boleh kosong' : null,
                  onChanged: (p0) {
                    _.kelurahanController = null;
                    _.kecamatanController = p0;
                    _.kelurahanKey = GlobalKey();
                    _.update();
                  }),
              DropdownWidget(
                  enabled: _.kecamatanController?.isNotEmpty ?? false,
                  key: _.kelurahanKey,
                  items: _.kecamatanController?.isNotEmpty ?? false ? _.kelurahanList : [],
                  value: _.kelurahanController,
                  onChanged: (p0) {
                    _.kelurahanController = p0;
                    _.update();
                  },
                  validator: (p0) => p0 == null ? 'Kelurahan tidak boleh kosong' : null,
                  labelText: 'KELURAHAN'),
              TextFieldWidget(
                  labelText: 'KODE POS',
                  controller: _.kodeposController,
                  validator: (p0) => p0!.isEmpty ? 'Kode pos tidak boleh kosong' : null),
              // const SizedBox(height: 20),
              // check alamat domisili sama dengan alamat ktp
              Row(
                children: [
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: AppColor.primary,
                    value: _.isSameAddress,
                    onChanged: (value) {
                      _.isSameAddress = value!;
                      _.update();
                    },
                  ),
                  const Text('Alamat Domisili sama dengan Alamat KTP'),
                ],
              ),
              if (!_.isSameAddress)
                Column(
                  children: [
                    TextFieldWidget(
                        labelText: 'ALAMAT DOMISILI',
                        controller: _.alamatKtp2Controller,
                        validator: (p0) {
                          if (p0!.isEmpty && !_.isSameAddress) {
                            return 'Alamat Domisili tidak boleh kosong';
                          }
                          return null;
                        }),
                    DropdownWidget(
                        items: _.provinces2.map((Province province) {
                          return DropdownMenuItem<String>(
                            value: province.id.toString(),
                            child: Text(province.name),
                          );
                        }).toList(),
                        onChanged: (value) async {
                          _.kota2Controller = null;
                          _.kecamatan2Controller = null;
                          _.kelurahan2Controller = null;
                          _.kota2key = GlobalKey();
                          _.cities2.clear();
                          _.provinsi2Controller = value!;
                          _.update();
                          _.fetchCities(value, isSame: true);
                        },
                        validator: (p0) {
                          if (p0 == null && !_.isSameAddress) {
                            return 'Provinsi Domisili tidak boleh kosong';
                          }
                          return null;
                        },
                        value: _.provinsi2Controller,
                        labelText: 'PROVINSI'),
                    DropdownWidget(
                        enabled: _.cities2.isNotEmpty,
                        dropdownKey: _.kota2key,
                        items: _.cities2.map((City city) {
                          return DropdownMenuItem<String>(
                            value: city.id.toString(),
                            child: Text(city.name),
                          );
                        }).toList(),
                        value: _.kota2Controller,
                        onChanged: (p0) async {
                          _.kecamatan2Controller = null;
                          _.kelurahan2Controller = null;
                          _.kota2Controller = p0;
                          _.kecamatan2Key = GlobalKey();
                          _.update();
                        },
                        validator: (p0) => p0 == null && !_.isSameAddress ? 'Kota Domisili tidak boleh kosong' : null,
                        labelText: 'KOTA/KABUPATEN'),
                    DropdownWidget(
                        enabled: _.kota2Controller?.isNotEmpty ?? false,
                        key: _.kecamatan2Key,
                        items: _.kota2Controller?.isNotEmpty ?? false ? _.kecamatanList : [],
                        value: _.kecamatan2Controller,
                        labelText: 'KECAMATAN',
                        validator: (p0) => p0 == null && !_.isSameAddress ? 'Kecamatan Domisili tidak boleh kosong' : null,
                        onChanged: (p0) {
                          _.kelurahan2Controller = null;
                          _.kecamatan2Controller = p0;
                          _.kelurahan2Key = GlobalKey();
                          _.update();
                        }),
                    DropdownWidget(
                        enabled: _.kecamatan2Controller?.isNotEmpty ?? false,
                        key: _.kelurahan2Key,
                        items: _.kecamatan2Controller?.isNotEmpty ?? false ? _.kelurahanList : [],
                        value: _.kelurahan2Controller,
                        validator: (p0) => p0 == null && !_.isSameAddress ? 'Kelurahan Domisili tidak boleh kosong' : null,
                        onChanged: (p0) {
                          _.kelurahan2Controller = p0;
                          _.update();
                        },
                        labelText: 'KELURAHAN'),
                    TextFieldWidget(
                        labelText: 'KODE POS',
                        controller: _.kodeposController,
                        validator: (p0) {
                          if (p0!.isEmpty && !_.isSameAddress) {
                            return 'Kode pos Domisili tidak boleh kosong';
                          }
                          return null;
                        }),
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: AppButton.outlined(
                      text: 'Sebelumnya',
                      onTap: () async {
                        _.changeIndex(0);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButton.elevated(
                      text: 'Selanjutnya',
                      onTap: () async {
                        if (_.formKey2.currentState!.validate()) {
                          _.changeIndex(2);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
