import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../network/repositories/url_entry_repository.dart';
import '../models/url_entry.dart';

part 'url_entry_event.dart';

part 'url_entry_state.dart';

class UrlEntryCubit extends Cubit<UrlEntryState> {
  final UrlEntryRepository urlEntryRepository;

  UrlEntryCubit({required this.urlEntryRepository})
      : super(const UrlEntryState());

  void updateState() {
    emit(state.copyWith(status: UrlEntryStatus.initial));
  }

  void fetchSiteInfo(String siteUrl) {
    if (!isSiteUrlValid(siteUrl)) {
      return;
    }
    siteUrl=makeValidUrl(siteUrl);
    emit(
      state.copyWith(status: UrlEntryStatus.loading),
    );
    urlEntryRepository
        .getSiteInfo(siteUrl)
        .then(
          (value) => emit(
            state.copyWith(
              status: UrlEntryStatus.success,
              urlEntry: value,
            ),
          ),
        )
        .onError(
          (error, stackTrace) => emit(
            state.copyWith(
                status: UrlEntryStatus.failure,
                errorMsg: "Something went wrong. Please try again later."),
          ),
        );
  }

  bool isSiteUrlValid(String siteUrl) {
    if (siteUrl.isEmpty) {
      emit(
        state.copyWith(
            status: UrlEntryStatus.invalid,
            errorMsg: "Server url cannot be empty"),
      );
      return false;
    } else {
      String pattern = r'[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(siteUrl)) {
        emit(
          state.copyWith(
              status: UrlEntryStatus.invalid,
              errorMsg: "Please enter valid url"),
        );
        return false;
      }
    }
    return true;
  }

  String makeValidUrl(String siteUrl){
    if(!siteUrl.startsWith("http") && !siteUrl.startsWith("https")){
      return "https://$siteUrl";
    }else{
      return siteUrl;
    }
  }
}
