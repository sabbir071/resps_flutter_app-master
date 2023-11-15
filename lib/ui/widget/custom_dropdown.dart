import 'package:flutter/material.dart';


import '../../model/DropdownModel.dart';
import 'custom_text.dart';

class CustomDropDown extends StatelessWidget {
  final String? fieldTitle;
  final DropdownModel? selectedItem;
  final List<DropdownModel> spinnerItemList;
  final void Function(DropdownModel) onChanged;

  const CustomDropDown(
      {Key? key,
        this.fieldTitle,
        required this.spinnerItemList,
        required this.onChanged,
        this.selectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldTitle != null ? FieldTitleText(text: fieldTitle!) : SizedBox(),
        fieldTitle != null
            ? const SizedBox(
          height: 3,
        )
            : SizedBox(),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<DropdownModel>(
                  value: selectedItem,
                  icon: const Icon(Icons.arrow_drop_down),
                  underline: const SizedBox(),
                  isExpanded: true,
                  // Hide default dropdown icon
                  elevation: 16,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  onChanged: (newValue) {
                    onChanged(newValue!);
                  },
                  items: spinnerItemList.map<DropdownMenuItem<DropdownModel>>(
                          (DropdownModel value) {
                        return DropdownMenuItem<DropdownModel>(
                          key: UniqueKey(), // Set a unique key here
                          value: value,
                          child: CustomSimpleText(
                            text: value.name,
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}