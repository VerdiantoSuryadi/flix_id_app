import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie.dart';
import '../../../misc/methods.dart';
import '../../../providers/search/search_provider.dart';
import '../../../widgets/network_image_card.dart';

Widget searchMovieList(
    {required WidgetRef ref, void Function(Movie movie)? onTap}) {
  var searchController = ref.watch(searchControllerProvider);
  var searchText = ref.read(searchProvider);
  return FutureBuilder(
    future: Future.delayed(const Duration(seconds: 1), () => searchController),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done ||
          snapshot.connectionState == ConnectionState.active) {
        if (searchText.isNotEmpty && snapshot.data!.isNotEmpty) {
          return GridView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Column(children: [
                NetworkImageCard(
                  width: ((MediaQuery.of(context).size.width - 48) / 3),
                  height: MediaQuery.of(context).size.width / 2,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}',
                  fit: BoxFit.cover,
                  onTap: () => onTap?.call(snapshot.data![index]),
                ),
                verticalSpace(5),
                Text(
                  snapshot.data![index].title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisExtent: MediaQuery.of(context).size.height / 3,
              // childAspectRatio: MediaQuery.of(context).size.aspectRatio,
            ),
            primary: false,
            shrinkWrap: true,
          );
        } else if (searchText.isNotEmpty && snapshot.data!.isEmpty) {
          return const Center(
            child: Text("Result not found"),
          );
        } else {
          return const SizedBox();
        }
      } else if (snapshot.connectionState == ConnectionState.waiting &&
          searchText.isNotEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return const SizedBox();
      }
    },
  );

  // return FutureBuilder(
  //     future:
  //         Future.delayed(const Duration(seconds: 1), () => searchingController),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         if (snapshot.data!.isNotEmpty && movieData != null) {
  //           return GridView.count(
  //               crossAxisCount: 3,
  //               crossAxisSpacing: 15,
  //               primary: false,
  //               shrinkWrap: true,
  //               childAspectRatio: 0.47,
  //               children: movies.when(
  //                 data: (movie) => movie
  //                     .where((element) => element.title
  //                         .toLowerCase()
  //                         .substring(0)
  //                         .startsWith(
  //                             snapshot.data!.toLowerCase().substring(0)))
  //                     .map((e) => SizedBox(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               NetworkImageCard(
  //                                 imageUrl:
  //                                     'https://image.tmdb.org/t/p/w500/${e.posterPath}',
  //                                 fit: BoxFit.cover,
  //                                 onTap: () => onTap?.call(e),
  //                               ),
  //                               verticalSpace(5),
  //                               Text(
  //                                 e.title,
  //                                 textAlign: TextAlign.center,
  //                                 maxLines: 2,
  //                                 overflow: TextOverflow.ellipsis,
  //                               )
  //                             ],
  //                           ),
  //                         ))
  //                     .toList(),
  //                 error: (error, stackTrace) => [],
  //                 loading: () => [],
  //               ));
  //         } else if (snapshot.data!.isEmpty) {
  //           return const SizedBox();
  //         } else {
  //           return const Center(
  //             child: Text("Result not found"),
  //           );
  //         }
  //       } else if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       } else {
  //         return const Center(
  //           child: Text("Result not found"),
  //         );
  //       }
  //     });
}
