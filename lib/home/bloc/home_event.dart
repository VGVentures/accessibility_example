part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {}

class UpdateFavoriteRequested extends HomeEvent {
  UpdateFavoriteRequested({required this.dog});

  final Dog dog;

  @override
  List<Object?> get props => [dog];
}

class DogsRequested extends HomeEvent {
  DogsRequested();

  @override
  List<Object?> get props => [];
}

class ChangeSelectedIndexRequested extends HomeEvent {
  ChangeSelectedIndexRequested({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}
