part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  success,
  loading,
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.dogs = const [],
    this.favoriteDogs = const [],
    this.selectedIndex = 0,
  });

  final HomeStatus status;
  final List<Dog> dogs;
  final List<Dog> favoriteDogs;
  final int selectedIndex;

  @override
  List<Object?> get props => [
        status,
        dogs,
        favoriteDogs,
        selectedIndex,
      ];

  HomeState copyWith({
    HomeStatus? status,
    List<Dog>? dogs,
    List<Dog>? favoriteDogs,
    int? selectedIndex,
  }) {
    return HomeState(
      status: status ?? this.status,
      dogs: dogs ?? this.dogs,
      favoriteDogs: favoriteDogs ?? this.favoriteDogs,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
