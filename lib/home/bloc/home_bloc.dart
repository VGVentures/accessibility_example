import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:very_good_accessibility/app/app.dart';
import 'package:very_good_accessibility/generated/assets.gen.dart';

part 'home_event.dart';
part 'home_state.dart';

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
    final dogs = [
      Dog(
        image: Assets.images.schnauzer.path,
        imageLabel: 'Two Miniature Schnauzer smiling and playing',
        title: 'Miniature Schnauzer',
        titleLabel: 'Miniature Schnauzer title',
        description: 'Stocky, robust little dogs standing 12 to 14 inches, '
            'Miniature Schnauzers were bred down from their larger '
            'cousins, Standard Schnauzers. The bushy beard and eyebrows '
            'give Minis a charming, human-like expression. The hard, wiry '
            'coat comes in three color patterns: salt and pepper, '
            'black and silver, and solid black.',
        descriptionLabel: 'Miniature Schnauzer description',
      ),
      Dog(
        image: Assets.images.shibainu.path,
        imageLabel: 'One Shiba Inu smiling face with a blur background',
        title: 'Shiba Inu',
        titleLabel: 'Shiba Inu title',
        description: 'Originally bred as a hunting dog, the Shiba Inu is '
            "among the world's oldest breeds and one of six native to  "
            'Japan. A smaller version of the Akita breed, '
            'the name Shiba Inu translates '
            "as 'small dog' in Japanese and it is a Spitz-type "
            'breed characterised by its thick coat, '
            'pointed ears and curly tail',
        descriptionLabel: 'Shiba Inu description',
      ),
      Dog(
        image: Assets.images.golden.path,
        imageLabel: 'One Golden Retrieve smiling face with a blur background',
        title: 'Golden Retrieve',
        titleLabel: 'Golden Retrieve title',
        description: 'The Golden Retriever is a sturdy, muscular dog of '
            'medium size, famous for the dense, lustrous coat of gold that '
            'gives the breed its name. The broad head, with its friendly '
            'and intelligent eyes, short ears, and straight muzzle, '
            'is a breed hallmark.',
        descriptionLabel: 'Golden Retrieve description',
      ),
    ];

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
      emit(
        state.copyWith(
          favoriteDogs: [
            for (final dog in state.favoriteDogs)
              if (dog != event.dog) dog,
          ],
        ),
      );
    }
  }

  FutureOr<void> _onChangeSelectedIndexRequested(
    ChangeSelectedIndexRequested event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(selectedIndex: event.index));
  }
}
