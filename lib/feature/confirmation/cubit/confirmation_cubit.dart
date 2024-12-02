import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../db/models/url_entry_entity.dart';
import '../../../network/repositories/url_entry_repository.dart';
import '../../url_entry/models/url_entry.dart';

part 'confirmation_state.dart';

class ConfirmationCubit extends Cubit<ConfirmationState> {
  final UrlEntryRepository urlEntryRepository;

  ConfirmationCubit({required this.urlEntryRepository})
      : super(const ConfirmationState());

  void updateState() {
    emit(state.copyWith(status: ConfirmationStatus.initial));
  }

  void saveSiteInfo(UrlEntry urlEntry) {
    urlEntryRepository
        .saveSiteInfo(UrlEntryEntity.fromModel(urlEntry))
        .then(
          (value) => emit(
            state.copyWith(
              status: ConfirmationStatus.success,
              urlEntry: urlEntry,
            ),
          ),
        )
        .onError(
          (error, stackTrace) => emit(
            state.copyWith(
                status: ConfirmationStatus.failure,
                errorMsg: "Something went wrong. Please try again later."),
          ),
        );
  }
}
