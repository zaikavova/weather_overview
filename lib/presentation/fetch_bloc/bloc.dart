import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class FetchBloc<Data, DataPM, Param>
    extends Bloc<_FetchBlocEvent, FetchState<DataPM>> {
  FetchBloc(this._fetchDataAction, this._pmFactory)
      : super(FetchState<DataPM>(isLoading: false)) {
    on<_FetchDateEvent<Param>>(_fetchData);
  }

  final FetchDataAction<Data, Param> _fetchDataAction;
  final Factory<Data, DataPM> _pmFactory;

  void fetchData(Param param) => add(_FetchDateEvent(param));

  Future<void> _fetchData(
      _FetchDateEvent<Param> event, Emitter<FetchState<DataPM>> emitter) async {
    emitter(FetchState());

    try {
      final data = await _fetchDataAction.call(event.param);
      emitter(FetchState(
          isLoading: false, items: data.map(_pmFactory.create).toList()));
    } catch (e) {
      emitter(
        FetchState(isLoading: false, error: e.toString(), items: state.items),
      );
      rethrow;
    }
  }
}

abstract class _FetchBlocEvent {}

class _FetchDateEvent<Param> implements _FetchBlocEvent {
  _FetchDateEvent(this.param);

  final Param param;
}
