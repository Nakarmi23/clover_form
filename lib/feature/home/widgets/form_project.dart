import 'package:clover_form/feature/form_detail/widgets/form_text_field.dart';
import 'package:flutter/material.dart';

class FormProject extends StatelessWidget {
  const FormProject({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['ProjectName']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 16),
          child: Column(
            children: [
              FormTextField(
                hint: "Project Name",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['ProjectName'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Project Classification",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['ProjectClassification'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Project Start Date",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['ProjectStartDate'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Project Completion Date",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['ProjectCompletionDate'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Province",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['ProvinceId'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "District",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['DistrictId'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "LLGId",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['LLGId'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Location",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['Location'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Gross Command Area",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['GrossCommandArea'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Net Command Area",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['NetCommandArea'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "East",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['East'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "West",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['West'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "North",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['North'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "South",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['South'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Water Source Name",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['WaterSourceName'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Water Source Type",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['WaterSourceType'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Catchment of Source",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['CatchmentofSource'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Min Monthly Flow",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['MinMonthlyFlow'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "High Flood Discharge",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['HighFloodDischarge'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Source Location",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['SourceLocation'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Total Main Canal",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['TotalMainCanal'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Main Canal Length",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['MainCanalLength'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Total Branch Canals",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['TotalBranchCanals'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Branch Canal Length",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['BranchCanalLength'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Latitude",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['Latitude'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Longitude",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['Longitude'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Elevation",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['Elevation'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Main Canal Design Discharge",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['MainCanalDesignDischarge'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Minor And Direct Outlets",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['MinorAndDirectOutlets'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Tertiary Canals",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['TertiaryCanals'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Structures",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['Structures'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Minor And Direct Off Takes",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['MinorAndDirectOffTakes'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Building",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['Building'],
              ),
              const SizedBox(
                height: 16,
              ),
              FormTextField(
                hint: "Project Description",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['ProjectDescription'],
              ),
              FormTextField(
                hint: "Status",
                borderColor: Colors.black,
                readOnly: true,
                initialValue: data['Status'],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
