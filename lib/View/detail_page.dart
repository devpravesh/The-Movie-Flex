import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:themovieflex/Controller/controller.dart';
import 'package:themovieflex/Widget/constant.dart';
import 'package:themovieflex/Widget/movie_section.dart';

import '../Model/movie_detail.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({super.key});
  final HomeController _controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final MovieDetail movie = Get.arguments[0] as MovieDetail;
    return Scaffold(
      appBar: AppBar(title: Text(movie.title ?? "")),
      body: ListView(
        children: [
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                Image.network(
                  imageUrl(movie.backdropPath),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Container(
                  height: 300,
                  color: Colors.black.withOpacity(0.3),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Image.network(
                      imageUrl(movie.posterPath),
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 50,
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 20, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Release Date: ${formatDate(movie.releaseDate.toString())}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.timer,
                              size: 20, color: Colors.white),
                          const SizedBox(width: 8),
                          Text('Runtime: ${movie.runtime} minutes',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 8),
                          Text(
                              'Rating: ${movie.voteAverage} (${movie.voteCount} votes)',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Center(
              child: Text(
                movie.title ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // ),
          const SizedBox(height: 16),

          // Movie Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overview
                Text(
                  movie.overview ?? "",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),

                // Additional Info

                const SizedBox(height: 16),

                // Genres
                Wrap(
                  spacing: 8,
                  children: movie.genres!.map((genre) {
                    return Chip(
                      label: Text(genre.name ?? ""),
                      backgroundColor: Colors.blue.shade100,
                    );
                  }).toList(),
                ),
                // const SizedBox(height: 16),
                // SizedBox(
                //   height: 200,
                //   child: ListView.builder(
                //       physics: const BouncingScrollPhysics(),
                //       shrinkWrap: true,
                //       scrollDirection: Axis.horizontal,
                //       itemCount: 2,
                //       itemBuilder: (context, index) {
                //         return Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: CreditPersonWidget(
                //             imageUrl:
                //                 imageUrl("/52GxBTYdLLc3x3UVSplZdHqj4RR.jpg"),
                //             name: "Andres",
                //             proficiency: "Acting",
                //           ),
                //         );
                //       }),
                // ),
                const SizedBox(height: 16),

                // Production Companies
                Text(
                  'Production Companies:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Column(
                  children: movie.productionCompanies!.map((company) {
                    return ListTile(
                      leading: company.logoPath != null
                          ? Image.network(
                              imageUrl(company.logoPath),
                              width: 50,
                              fit: BoxFit.cover,
                            )
                          : null,
                      title: Text(company.name ?? ""),
                      subtitle: Text(company.originCountry ?? ""),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Collection
                if (movie.belongsToCollection != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Collection: ${movie.belongsToCollection!.name}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      if (movie.belongsToCollection!.backdropPath != null)
                        SizedBox(
                          child: Stack(children: [
                            Container(
                              height: 200,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            Image.network(
                              imageUrl(movie.belongsToCollection!.backdropPath),
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                            if (movie.belongsToCollection!.posterPath != null)
                              Positioned(
                                left: 0,
                                right: 0,
                                child: Image.network(
                                  imageUrl(
                                      movie.belongsToCollection!.posterPath),
                                  width: 130,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              ),
                          ]),
                        ),
                      const SizedBox(height: 8),
                      MovieSection(
                        isLoading: _controller.isLoadingRecommendations,
                        apiError: _controller.apiErrorRecommendations,
                        movieList: _controller.recommendationsMovieList,
                        heading: "Recommendations",
                        getResults: (movieList) => movieList?.results ?? [],
                      )
                    ],
                  ),
                const SizedBox(height: 16),

                // Homepage Link
                if (movie.homepage!.isNotEmpty)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        movie.homepage != null
                            ? launchURL(movie.homepage!)
                            : Fluttertoast.showToast(
                                msg: "Something Went Wrong in URL");
                      },
                      child: const Text('Visit Homepage'),
                    ),
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
