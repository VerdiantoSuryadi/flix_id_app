import '../../../data/repositories/movie_repository.dart';
import '../../entities/actor.dart';
import '../../entities/result.dart';
import '../usecase.dart';
import 'get_actors_params.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorParams> {
  final MovieRepository _movieRepository;

  GetActors({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Actor>>> call(GetActorParams params) async {
    var actorListResult = await _movieRepository.getActors(id: params.movieId);

    return switch (actorListResult) {
      Success(value: final actorList) => Result.success(actorList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
