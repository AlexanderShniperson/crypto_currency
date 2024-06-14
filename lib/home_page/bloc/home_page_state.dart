part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  const HomePageState({
    this.loading = false,
    this.currentPage = 0,
    this.rates = const [],
  });

  final bool loading;
  final int currentPage;
  final List<RateModel> rates;

  @override
  List<Object> get props => [
        loading,
        currentPage,
        rates,
      ];

  HomePageState copyWith({
    bool? loading,
    int? currentPage,
    List<RateModel>? rates,
  }) {
    return HomePageState(
      loading: loading ?? this.loading,
      currentPage: currentPage ?? this.currentPage,
      rates: rates ?? this.rates,
    );
  }
}
