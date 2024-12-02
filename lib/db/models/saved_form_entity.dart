import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "Saved_Form")
class SavedFormEntity extends Equatable {
  SavedFormEntity({
    required this.DataCollectionFormId,
    required this.DataCollectionFormName,
    required this.projectName,
    required this.date,
    this.synced = false,
    this.id,
  });

  @PrimaryKey(autoGenerate: true)
  int? id;
  final String DataCollectionFormId;
  final String DataCollectionFormName;
  final String projectName;
  final bool synced;
  final String date;

  @override
  List<Object?> get props => [
        DataCollectionFormId,
        DataCollectionFormName,
        synced,
        projectName,
        date,
      ];
}
