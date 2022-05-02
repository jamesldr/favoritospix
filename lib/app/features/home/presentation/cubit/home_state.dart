part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<FavoritePix>? favorites;
  const HomeState({this.favorites});

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
