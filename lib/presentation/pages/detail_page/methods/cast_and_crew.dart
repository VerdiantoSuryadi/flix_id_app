import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie.dart';
import '../../../misc/methods.dart';
import '../../../providers/movie/actors_provider.dart';
import '../../../widgets/network_image_card.dart';

List<Widget> castAndCrew({required Movie movie, required WidgetRef ref}) => [
      const Text(
        'Cast and crew',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...(ref.watch(actorsProvider(movieId: movie.id)).whenOrNull(
                      data: (actors) => actors
                          .where((element) => element.profilePath != null)
                          .map((e) => Padding(
                                padding: EdgeInsets.only(
                                    left: e == actors.first ? 0 : 10),
                                child: Column(
                                  children: [
                                    NetworkImageCard(
                                      width: 100,
                                      height: 152,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/w185/${e.profilePath}',
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        e.name,
                                        style: const TextStyle(fontSize: 12),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                    ) ??
                [])
          ],
        ),
      )
    ];
