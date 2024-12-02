import 'package:clover_form/feature/home/models/form_model.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "Form")
class FormEntity extends Equatable {
  const FormEntity({
    required this.DataCollectionFormId,
    required this.DataCollectionFormName,
    // required this.DataCollectionFormHtlm,
    required this.DataCollectionFormSubmissionURL,
  });

  @PrimaryKey(autoGenerate: false)
  final String DataCollectionFormId;
  final String DataCollectionFormName;
  // final String DataCollectionFormHtlm;
  final String DataCollectionFormSubmissionURL;

  factory FormEntity.toEntity(FormModel form) => FormEntity(
        DataCollectionFormId: form.DataCollectionFormId,
        DataCollectionFormName: form.DataCollectionFormName,
        // DataCollectionFormHtlm: form.DataCollectionFormHtlm,
        DataCollectionFormSubmissionURL: form.DataCollectionFormSubmissionURL,
      );

  @override
  List<Object?> get props => [
        DataCollectionFormId,
        DataCollectionFormName,
        // DataCollectionFormHtlm,
        DataCollectionFormSubmissionURL
      ];
}
