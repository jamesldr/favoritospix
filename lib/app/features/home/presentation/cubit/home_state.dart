part of 'home_cubit.dart';

class HomeState extends Equatable {
  List<FavoritePix>? favorites;
  HomeState({
    this.favorites,
  });

  @override
  List get props => [favorites];

  HomeState copyWith({
    List<FavoritePix>? favorites,
  }) {
    return HomeState(
      favorites: favorites ?? this.favorites,
    );
  }
}

class _InitialState extends HomeState {
  _InitialState() : super(favorites: []);
}
