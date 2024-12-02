part of 'url_entry_cubit.dart';

enum UrlEntryStatus { initial, invalid, loading, success, failure }

final class UrlEntryState extends Equatable {
  final UrlEntryStatus status;
  final UrlEntry? urlEntry;
  final String? errorMsg;

  const UrlEntryState(
      {this.status = UrlEntryStatus.initial, this.urlEntry, this.errorMsg});

  UrlEntryState copyWith({
    UrlEntryStatus? status,
    UrlEntry? urlEntry,
    String? errorMsg,
  }) {
    return UrlEntryState(
        status: status ?? this.status,
        urlEntry: urlEntry ?? this.urlEntry,
        errorMsg: errorMsg ?? this.errorMsg);
  }

  @override
  List<Object?> get props => [status, urlEntry, errorMsg];

  @override
  String toString() {
    return 'UrlEntryState{status: $status, urlEntry: $urlEntry, errorMsg: $errorMsg}';
  }
}
