import 'package:flutter/material.dart';

import '../../../network/models/district.dart';
import '../../../network/models/nagapaga.dart';
import '../../../network/models/province.dart';
import '../view/form_detail_child.dart';

class FormAdministrativeLocationSelection extends StatefulWidget {
  final List<Province> allProvinces;
  final List<District> allDistricts;
  final List<Nagapaga> allNagapagas;
  String? selectedProvinceId;
  String? selectedDistrictId;
  String? selectedNagapagaId;
  final String title;
  final ValueChanged<String>? onProvinceSelected;
  final ValueChanged<String>? onDistrictSelected;
  final ValueChanged<String>? onNagapagaSelected;
  final Color borderColor;

  FormAdministrativeLocationSelection({
    super.key,
    required this.allProvinces,
    required this.allDistricts,
    required this.allNagapagas,
    this.selectedProvinceId,
    this.selectedDistrictId,
    this.selectedNagapagaId,
    required this.title,
    this.onProvinceSelected,
    this.onDistrictSelected,
    this.onNagapagaSelected,
    required this.borderColor,
  });

  @override
  _FormAdministrativeLocationSelectionState createState() =>
      _FormAdministrativeLocationSelectionState();
}

class _FormAdministrativeLocationSelectionState
    extends State<FormAdministrativeLocationSelection> {
  late List<String> provinceOptions;
  late List<String> districtOptions;
  late List<String> nagapagaOptions;

  @override
  void initState() {
    super.initState();
    provinceOptions = ['Select a Province'] +
        widget.allProvinces.map((province) => province.provinceName).toList();

    if (widget.selectedProvinceId?.isNotEmpty == true &&
        widget.allDistricts.isNotEmpty) {
      districtOptions = ['Select a District'] +
          widget.allDistricts
              .where((district) =>
                  district.provinceId == widget.selectedProvinceId)
              .map((district) => district.districtName)
              .toList();
    } else {
      districtOptions = ['Select a District'];
    }

    if (widget.selectedDistrictId?.isNotEmpty == true &&
        widget.allNagapagas.isNotEmpty) {
      nagapagaOptions = ['Select a Palika'] +
          widget.allNagapagas
              .where((napaGapa) =>
                  napaGapa.districtId == widget.selectedDistrictId)
              .map((napaGapa) => napaGapa.napaGapaEN)
              .toSet() // Use toSet to ensure unique values
              .toList();
    } else {
      nagapagaOptions = ['Select a Palika'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: widget.borderColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: getTitleFromId(widget.selectedProvinceId,
                    widget.allProvinces, AdminLevel.PROVINCE),
                onChanged: (newValue) {
                  setState(() {
                    var newID = getIdFromTitle(
                        newValue, widget.allProvinces, AdminLevel.PROVINCE);
                    widget.selectedProvinceId = newID;
                    widget.selectedDistrictId = null;
                    widget.selectedNagapagaId = null;

                    // Update districtOptions based on the selected province
                    districtOptions = ['Select a District'] +
                        widget.allDistricts
                            .where((district) => district.provinceId == newID)
                            .map((district) => district.districtName)
                            .toList();

                    widget.onProvinceSelected?.call(newID!);
                    widget.onDistrictSelected?.call('');
                    widget.onNagapagaSelected?.call('');
                  });
                },
                items: provinceOptions.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: getTitleFromId(widget.selectedDistrictId,
                    widget.allDistricts, AdminLevel.DISTRICT),
                onChanged: (newValue) {
                  setState(() {
                    var newID = getIdFromTitle(
                        newValue, widget.allDistricts, AdminLevel.DISTRICT);

                    widget.selectedDistrictId = newID;
                    widget.selectedNagapagaId = null;

                    nagapagaOptions = ['Select a Palika'] +
                        widget.allNagapagas
                            .where((napaGapa) => napaGapa.districtId == newID)
                            .map((napaGapa) => napaGapa.napaGapaEN)
                            .toList();

                    widget.onDistrictSelected?.call(newID!);
                    widget.onNagapagaSelected?.call('');
                  });
                },
                items: districtOptions.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: getTitleFromId(widget.selectedNagapagaId,
                    widget.allNagapagas, AdminLevel.PALIKA),
                onChanged: (newValue) {
                  setState(() {
                    var newID = getIdFromTitle(
                        newValue, widget.allNagapagas, AdminLevel.PALIKA);
                    widget.selectedNagapagaId = newID;

                    widget.onNagapagaSelected?.call(newID!);
                  });
                },
                items: nagapagaOptions.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getTitleFromId(String? id, List<dynamic> list, AdminLevel type) {
    if (id?.isNotEmpty == true) {
      if (type == AdminLevel.PROVINCE) {
        var item = list.firstWhere((element) => element.provinceId == id);
        return item.provinceName;
      } else if (type == AdminLevel.DISTRICT) {
        var item = list.firstWhere((element) => element.districtId == id);
        return item.districtName;
      } else {
        var item = list.firstWhere((element) => element.napaGapaId == id);
        return item.napaGapaEN;
      }
    }

    var t = capitalizeFirstLetter(type.name.toLowerCase());
    return 'Select a $t';
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  String? getIdFromTitle(String? title, List<dynamic> list, AdminLevel type) {
    if (title?.contains('Select a') == false) {
      if (type == AdminLevel.PROVINCE) {
        var item = list.firstWhere((element) => element.provinceName == title);
        return item.provinceId;
      } else if (type == AdminLevel.DISTRICT) {
        var item = list.firstWhere((element) => element.districtName == title);
        return item.districtId;
      } else if (type == AdminLevel.PALIKA) {
        var item = list.firstWhere((element) => element.napaGapaEN == title);
        return item.napaGapaId;
      }
    }

    return '';
  }
}
