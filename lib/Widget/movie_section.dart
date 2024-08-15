import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:themovieflex/Controller/controller.dart';
import 'package:themovieflex/Routes/routes.dart';
import 'constant.dart';
import 'movie_card.dart';

class MovieSection extends StatelessWidget {
  final RxBool isLoading;
  final dynamic apiError;
  final dynamic movieList;
  final String heading;
  final List<dynamic>? Function(dynamic)? getResults;

  const MovieSection({
    super.key,
    required this.isLoading,
    required this.apiError,
    required this.movieList,
    required this.heading,
    this.getResults,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Text(
            heading,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Obx(() {
          if (isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (apiError != null) {
            return Center(child: Text('Error: ${apiError.message}'));
          }

          final results = getResults?.call(movieList);
          if (results == null || results.isEmpty) {
            return const Center(child: Text('No Data Available.'));
          }

          return SizedBox(
            height: 360,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: results.length,
              itemBuilder: (context, index) {
                final movie = results[index];
                return InkWell(
                  onTap: () async {
                    await Get.find<HomeController>()
                        .fetchMovieDetails(movie.id);
                    Get.toNamed(AppRoutes.movieDetail, arguments: [
                      Get.find<HomeController>().movieDetail,
                    ]);
                  },
                  child: MovieCard(
                    imageUrl: imageUrl(movie.posterPath ?? ""),
                    title: movie.title ?? "No Title",
                    releaseDate:
                        movie?.releaseDate.toString() ?? "Unknown Date",
                    score: movie.voteAverage != null
                        ? (movie.voteAverage! * 10)
                        : 0,
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
