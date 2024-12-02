part of 'form_detail_cubit.dart';

enum FormDetailStatus { initial, loading, success,saved,validationError, failed }

final class FormDetailState extends Equatable {
  final FormDetailStatus status;
  final List<FormModelField> formFields;
  final String errorMsg;

  const FormDetailState({
    this.status = FormDetailStatus.initial,
    this.formFields = const <FormModelField>[],
    this.errorMsg = "",
  });

  FormDetailState copyWith({
    FormDetailStatus? status,
    List<FormModelField>? formFields,
    String? errorMsg,
  }) {
    return FormDetailState(
        status: status ?? this.status,
        formFields: formFields ?? this.formFields,
        errorMsg: errorMsg ?? this.errorMsg);
  }

  @override
  List<Object?> get props => [
        status,
        formFields,
        errorMsg,
      ];
}
