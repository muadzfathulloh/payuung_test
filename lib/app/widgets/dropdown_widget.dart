import 'package:flutter/material.dart';
import 'package:payuung/app/components/app_colors.dart';

class DropdownWidget extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final bool isRequired;
  final Key? dropdownKey;
  final String? labelText;
  final EdgeInsetsGeometry? padding;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final bool enabled;
  final String? Function(String?)? validator;

  const DropdownWidget({
    super.key,
    required this.items,
    this.dropdownKey,
    this.value,
    this.isRequired = true,
    this.enabled = true,
    this.labelText,
    this.padding,
    this.onChanged,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              isRequired ? const Text('* ', style: TextStyle(fontSize: 12, color: Colors.red)) : const SizedBox(),
              Text(labelText ?? 'NAMA LENGKAP', style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField<String?>(
            key: dropdownKey,
            onTap: onTap,
            validator: validator,
            decoration: InputDecoration(
              enabled: enabled,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.grey, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.grey, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.grey200, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            value: value,
            items: items,
            onChanged: (newValue) {
              onChanged?.call(newValue);
              // Handle change
            },
            style: const TextStyle(color: Colors.black, fontSize: 12),
            hint: const Text('Pilih', style: TextStyle(fontSize: 12, color: AppColor.grey400)),
          ),
        ],
      ),
    );
  }
}
