import 'package:bloc/bloc.dart';
import 'package:clover_form/network/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../network/repositories/url_entry_repository.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  final UrlEntryRepository urlEntryRepository;
  final UserRepository userRepository;

  LoadingCubit({required this.urlEntryRepository, required this.userRepository})
      : super(const LoadingState()) {
    getState();
  }

  void getState() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    getUserData();
  }

  void getSiteInfo() async {
    urlEntryRepository.getSiteInfoDb().then(
          (value) => {
            if (value == null)
              {
                emit(
                  state.copyWith(
                    status: LoadingStatus.initial,
                  ),
                ),
              }
            else
              {
                emit(
                  state.copyWith(
                    status: LoadingStatus.siteInfo,
                  ),
                ),
              }
          },
        );
  }

  void getUserData() {
    userRepository.getUserDb().then(
          (value) => {
            if (value != null)
              {
                emit(
                  state.copyWith(
                    status: LoadingStatus.logged,
                  ),
                ),
              }
            else
              {getSiteInfo()}
          },
        );
  }
}
