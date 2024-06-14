import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:rest_client/rest_client.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc({
    required RestClient restClient,
  })  : _restClient = restClient,
        super(HomePageState()) {
    on<LoadAllRatesEvent>(_onLoadAllRatesEvent);
    on<LoadNextPageEvent>(_onLoadNextPageEvent);
  }

  final List<RateModel> _allRates = [];
  final RestClient _restClient;

  Future<void> _onLoadAllRatesEvent(
    LoadAllRatesEvent event,
    Emitter<HomePageState> emit,
  ) async {
    if (_allRates.isNotEmpty) {
      return;
    }
    emit(state.copyWith(loading: true));
    try {
      final rates = await _restClient.getRates();
      _allRates.addAll(rates);
    } finally {
      emit(state.copyWith(loading: false));
    }
    add(LoadNextPageEvent());
  }

  Future<void> _onLoadNextPageEvent(
    LoadNextPageEvent event,
    Emitter<HomePageState> emit,
  ) async {
    if (_allRates.isEmpty || state.loading) {
      return;
    }
    emit(state.copyWith(loading: true));
    try {
      final totalPages = _allRates.length / 15;
      final nextPage = state.currentPage + 1;
      if (nextPage <= totalPages) {
        await Future.delayed(const Duration(milliseconds: 1000), () {});
        final nextRates = _allRates.take(nextPage * 15).toList();
        debugPrint('nextPage=$nextPage\nnextRates.len=${nextRates.length}');
        emit(
          state.copyWith(
            currentPage: nextPage,
            rates: nextRates,
          ),
        );
      }
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
