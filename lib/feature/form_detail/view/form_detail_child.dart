import 'package:clover_form/feature/form_detail/widgets/form_date_selection.dart';
import 'package:clover_form/feature/form_detail/widgets/form_selection.dart';
import 'package:clover_form/feature/form_detail/widgets/form_text_field.dart';
import 'package:clover_form/feature/form_detail/widgets/from_number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../home/models/form_model_field.dart';
import '../cubit/form_detail_cubit.dart';
import '../widgets/form_administrative_location_selection.dart';
import '../widgets/map_selection.dart';

enum AdminLevel { PROVINCE, DISTRICT, PALIKA }

class FormDetailChild extends StatelessWidget {
  final List<FormModelField> fields;
  final Map<int, TextEditingController> controllersMap = {};
  final Map<int, String> selectedDropdownValues = {};
  final Map<int, String?> datesValues = {};
  final Map<int, String?> mapValue = {};
  final String formID;

  FormDetailChild({super.key, required this.fields, required this.formID}) {
    for (int i = 0; i < fields.length; i++) {
      var field = fields[i];

      // Initialize mapvalues
      if (field.dataLabel == "GetGPS") {
        mapValue[i] = field.formValue??"";
      }
      // Initialize controllersMap
      if (field.type == "text" || field.type == "number") {
        controllersMap[i] = TextEditingController(text: field.formValue ?? "");
      }

      // Initialize selectedDropdownValues
      if (field.tagName == "select") {
        selectedDropdownValues[i] = field.formValue ?? "Select an option";
      } else if (field.dataLabel == "GetAdministrativeLocation") {
        var administrativeLocationValue = field.formValue;
        if (administrativeLocationValue != null &&
            administrativeLocationValue.isNotEmpty) {
          selectedDropdownValues[i] = administrativeLocationValue;
        }
      }

      // Initialize datesValues
      if (field.type == "date") {
        datesValues[i] = field.formValue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemBuilder: (context, index) {
        if (index == fields.length) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                for (var entry in controllersMap.entries) {
                  var textFieldValue = entry.value.text;
                  if (textFieldValue.isNotEmpty) {
                    context
                        .read<FormDetailCubit>()
                        .updateFormFieldValue(entry.key, textFieldValue);
                  }
                }
                for (var entry in selectedDropdownValues.entries) {
                  var value = entry.value;
                  if (!value.contains('Select an option')) {
                    context
                        .read<FormDetailCubit>()
                        .updateFormFieldValue(entry.key, value!);
                  }
                }
                for (var entry in datesValues.entries) {
                  var value = entry.value;
                  if (value?.isNotEmpty == true) {
                    context
                        .read<FormDetailCubit>()
                        .updateFormFieldValue(entry.key, value!);
                  }
                }
                for (var entry in mapValue.entries) {
                  print("on save $entry");
                  print("on save ${entry.key}");
                  var value = entry.value;
                  if (value?.isNotEmpty == true) {
                    context
                        .read<FormDetailCubit>()
                        .updateFormFieldValue(entry.key, value!);
                  }
                }
                context.read<FormDetailCubit>().submitForm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E0189),
              ),
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          var field = fields.elementAt(index);
          if (field.tagName == "input") {
            if (field.dataLabel == "GetGPS") {
              var lat = "";
              var lng = "";
              if (mapValue[index]?.contains(",") == true) {
                lat = mapValue[index]!.split(",")[0];
                lng = mapValue[index]!.split(",")[1];
              }
              return Container(
                child: OSMMapWidget(
                  onMarkerPlaced: (LatLng position) {
                    mapValue[index] =
                        "${position.latitude}, ${position.longitude}";
                  },
                  initialMarkerPosition: lat.isNotEmpty && lng.isNotEmpty
                      ? LatLng(double.parse(lat), double.parse(lng))
                      : null,
                ),
              );
            }
            if (field.type == "text") {
              var controller = controllersMap[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: FormTextField(
                  controller: controller!,
                  hint: field.required == true
                      ? "${field.label ?? ""} *"
                      : field.label ?? "",
                  borderColor:
                      field.isInvalid == true ? Colors.red : Colors.black,
                ),
              );
            } else if (field.type == "date") {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormDateSelection(
                      title: field.label ?? "Select Date",
                      onDateSelected: (selectedDate) {
                        datesValues[index] = selectedDate ?? "";
                      },
                      defaultDate: datesValues[index],
                      borderColor:
                          field.isInvalid == true ? Colors.red : Colors.black,
                    ),
                  ],
                ),
              );
            } else if (field.type == "number") {
              var controller = controllersMap[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: FormNumberTextField(
                  controller: controller!,
                  hint: field.required == true
                      ? "${field.label ?? ""} *"
                      : field.label ?? "",
                  borderColor:
                      field.isInvalid == true ? Colors.red : Colors.black,
                ),
              );
            } else if (field.dataLabel == "GetAdministrativeLocation") {
              var administrativeLocationValue =
                  selectedDropdownValues[index] ?? '';
              var locationParts =
                  administrativeLocationValue.split('-AdminData-');

              var selectedProvinceId =
                  (locationParts.isNotEmpty && locationParts[0].isNotEmpty)
                      ? locationParts[0]
                      : null;
              var selectedDistrictId =
                  (locationParts.length > 1 && locationParts[1].isNotEmpty)
                      ? locationParts[1]
                      : null;
              var selectedNagapagaId =
                  (locationParts.length > 2 && locationParts[2].isNotEmpty)
                      ? locationParts[2]
                      : null;

              var provinces = context.read<FormDetailCubit>().provinces;
              var districts = context.read<FormDetailCubit>().districts;
              var nagapagas = context.read<FormDetailCubit>().nagapagas;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: FormAdministrativeLocationSelection(
                  title: field.label ?? "Select Administrative location",
                  borderColor:
                      field.isInvalid == true ? Colors.red : Colors.black,
                  allProvinces: provinces,
                  allDistricts: districts,
                  allNagapagas: nagapagas,
                  selectedProvinceId: selectedProvinceId,
                  selectedDistrictId: selectedDistrictId,
                  selectedNagapagaId: selectedNagapagaId,
                  onProvinceSelected: (newValue) {
                    updateLocation(index, AdminLevel.PROVINCE, newValue);
                  },
                  onDistrictSelected: (newValue) {
                    updateLocation(index, AdminLevel.DISTRICT, newValue);
                  },
                  onNagapagaSelected: (newValue) {
                    updateLocation(index, AdminLevel.PALIKA, newValue);
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          } else if (field.tagName == "select") {
            List<String> options = ["Select an option"];
            field.options?.forEach((element) {
              if (element.label != null) {
                options.add(element.label!);
              }
            });

            var selectedOption = selectedDropdownValues[index] ?? "";
            if (selectedOption.isEmpty) {
              if (options.isNotEmpty) {
                selectedOption = options.first;
              }
            }
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: FormSelection(
                title: field.label ?? "",
                options: options,
                index: index,
                onSelectionChanged: (newValue) {
                  selectedDropdownValues[index] = newValue;
                },
                selectedOption: selectedOption,
                borderColor:
                    field.isInvalid == true ? Colors.red : Colors.black,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      },
      separatorBuilder: (context, index) =>
          const Divider(height: 5, color: Colors.white),
      itemCount: fields.length + 1,
    );
  }

  void updateLocation(int index, AdminLevel adminLevel, value) {
    var administrativeLocationValue = selectedDropdownValues[index] ?? '';
    var locationParts = administrativeLocationValue.split('-AdminData-');

    var province = (locationParts.isNotEmpty && locationParts[0].isNotEmpty)
        ? locationParts[0]
        : '';
    var district = (locationParts.length > 1 && locationParts[1].isNotEmpty)
        ? locationParts[1]
        : '';
    var nagapaga = (locationParts.length > 2 && locationParts[2].isNotEmpty)
        ? locationParts[2]
        : '';

    if (adminLevel == AdminLevel.PROVINCE) {
      province = value;
    } else if (adminLevel == AdminLevel.DISTRICT) {
      district = value;
    } else {
      nagapaga = value;
    }
    selectedDropdownValues[index] =
        '$province-AdminData-$district-AdminData-$nagapaga';
  }
}
