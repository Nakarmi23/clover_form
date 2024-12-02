import 'package:clover_form/feature/home/models/form_model_field.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "Saved_Form_Field")
class SavedFormFieldEntity extends Equatable {
  SavedFormFieldEntity({
    this.fieldId,
    this.savedFormId,
    this.id,
    this.formValue,
    this.label,
  });

  @PrimaryKey(autoGenerate: true)
  int? fieldId;
  int? savedFormId;
  String? id;
  String? formValue;
  String? label;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
