part of 'url_entry_cubit.dart';

sealed class UrlEntryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UrlEntryFetched extends UrlEntryEvent {}
