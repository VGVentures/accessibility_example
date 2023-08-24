import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:very_good_accessibility/app/app.dart';
import 'package:very_good_accessibility/generated/assets.gen.dart';

part 'home_event.dart';
part 'home_state.dart';

/// A list of dogs to display in our app.
/// This is for demo purposes only.
/// In a real app, this data would be fetched from a database or API.
final List<Dog> dogs = [
  Dog(
    image: Assets.images.schnauzer.path,
    imageLabel: 'Two Miniature Schnauzer smiling and playing',
    title: 'Miniature Schnauzer',
    description: 'Stocky, robust little dogs standing 12 to 14 inches, '
        'Miniature Schnauzers were bred down from their larger '
        'cousins, Standard Schnauzers. The bushy beard and eyebrows '
        'give Minis a charming, human-like expression. The hard, wiry '
        'coat comes in three color patterns: salt and pepper, '
        'black and silver, and solid black.',
  ),
  Dog(
    image: Assets.images.shibainu.path,
    imageLabel: 'One Shiba Inu smiling face with a blur background',
    title: 'Shiba Inu',
    description: 'Originally bred as a hunting dog, the Shiba Inu is '
        "among the world's oldest breeds and one of six native to  "
        'Japan. A smaller version of the Akita breed, '
        'the name Shiba Inu translates '
        "as 'small dog' in Japanese and it is a Spitz-type "
        'breed characterised by its thick coat, '
        'pointed ears and curly tail',
  ),
  Dog(
    image: Assets.images.golden.path,
    imageLabel: 'One Golden Retrieve smiling face with a blur background',
    title: 'Golden Retrieve',
    description: 'The Golden Retriever is a sturdy, muscular dog of '
        'medium size, famous for the dense, lustrous coat of gold that '
        'gives the breed its name. The broad head, with its friendly '
        'and intelligent eyes, short ears, and straight muzzle, '
        'is a breed hallmark.',
  ),
];

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<DogsRequested>(_onDogsRequested);
    on<UpdateFavoriteRequested>(_onUpdateFavoriteRequested);
    on<ChangeSelectedIndexRequested>(_onChangeSelectedIndexRequested);
  }

  FutureOr<void> _onDogsRequested(
    DogsRequested event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(dogs: dogs, status: HomeStatus.success));
  }

  FutureOr<void> _onUpdateFavoriteRequested(
    UpdateFavoriteRequested event,
    Emitter<HomeState> emit,
  ) {
    if (!state.favoriteDogs.contains(event.dog)) {
      emit(
        state.copyWith(
          favoriteDogs: [...state.favoriteDogs, event.dog],
        ),
      );
    } else {
      final favoriteDogs =
          state.favoriteDogs.where((dog) => dog != event.dog).toList();

      emit(state.copyWith(favoriteDogs: favoriteDogs));
    }
  }

  FutureOr<void> _onChangeSelectedIndexRequested(
    ChangeSelectedIndexRequested event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(selectedIndex: event.index));
  }
}
