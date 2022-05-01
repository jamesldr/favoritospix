part of 'details_cubit.dart';

class DetailsState extends Equatable {
  const DetailsState({this.model});

  final FavoritePixModel? model;

  @override
  List get props => [model];

  DetailsState copyWith({
    FavoritePixModel? model,
  }) {
    return DetailsState(
      model: model ?? this.model,
    );
  }
}
