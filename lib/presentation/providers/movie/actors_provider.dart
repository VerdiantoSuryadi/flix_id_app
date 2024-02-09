import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/actor.dart';
import '../../../domain/entities/result.dart';
import '../../../domain/usecases/get_actors/get_actors.dart';
import '../../../domain/usecases/get_actors/get_actors_params.dart';
import '../usecases/get_actors_provider.dart';

part 'actors_provider.g.dart';

@riverpod
Future<List<Actor>> actors(ActorsRef ref, {required int movieId}) async {
  GetActors getActors = ref.read(getActorsProvider);

  var actorsResult = await getActors(GetActorParams(movieId: movieId));

  return switch (actorsResult) {
    Success(value: final actors) => actors,
    Failed(message: _) => const []
  };
}
