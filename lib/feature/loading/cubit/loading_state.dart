part of 'loading_cubit.dart';

enum LoadingStatus { initial, siteInfo, logged }

final class LoadingState extends Equatable {
  final LoadingStatus status;

  const LoadingState({this.status = LoadingStatus.initial});

  LoadingState copyWith({
    LoadingStatus? status,
  }) {
    return LoadingState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
