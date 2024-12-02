import 'package:equatable/equatable.dart';

import '../../../db/models/saved_form_entity.dart';

class SavedFormModel extends Equatable {
  const SavedFormModel({
    required this.id,
    required this.DataCollectionFormId,
    required this.DataCollectionFormName,
    required this.projectName,
    required this.date,
    this.isSelected = false,
  });

  final String DataCollectionFormId;
  final String DataCollectionFormName;
  final String projectName;
  final String date;
  final int? id;
  final bool isSelected;

  SavedFormModel copyWith({
    String? DataCollectionFormId,
    String? DataCollectionFormName,
    String? projectName,
    String? date,
    int? id,
    bool? isSelected, // Add this line
  }) {
    return SavedFormModel(
      DataCollectionFormId: DataCollectionFormId ?? this.DataCollectionFormId,
      DataCollectionFormName:
          DataCollectionFormName ?? this.DataCollectionFormName,
      projectName: DataCollectionFormName ?? this.projectName,
      date: date ?? this.date,
      id: id ?? this.id,
      isSelected: isSelected ?? this.isSelected, // Add this line
    );
  }

  factory SavedFormModel.fromEntity(SavedFormEntity entity) => SavedFormModel(
        DataCollectionFormId: entity.DataCollectionFormId,
        DataCollectionFormName: entity.DataCollectionFormName,
        projectName: entity.projectName,
        date: entity.date,
        id: entity.id,
      );

  @override
  List<Object?> get props => [
        DataCollectionFormId,
        DataCollectionFormName,
    projectName,
        date,
        isSelected,
      ];
}
