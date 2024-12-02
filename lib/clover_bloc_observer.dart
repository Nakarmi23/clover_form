import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class CloverBlocObserver extends BlocObserver {
  const CloverBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('${bloc.runtimeType} $change');
    }
  }
}
