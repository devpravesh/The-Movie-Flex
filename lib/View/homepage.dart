import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/controller.dart';
import '../Widget/movie_section.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomeController _controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Movie Flex"),
      ),
      body: Obx(() {
        if (_controller.isLoadingTopRated.value ||
            _controller.isLoadingPopular.value ||
            _controller.isLoadingUpcoming.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: [
            MovieSection(
              isLoading: _controller.isLoadingUpcoming,
              apiError: _controller.apiErrorUpcoming,
              movieList: _controller.upcomingMovieList,
              heading: 'Upcoming Movies',
              getResults: (movieList) => movieList?.results ?? [],
            ),
            const SizedBox(height: 20),
            MovieSection(
              isLoading: _controller.isLoadingTopRated,
              apiError: _controller.apiErrorTopRated,
              movieList: _controller.topRatedMovieList,
              heading: 'Top Rated Movies',
              getResults: (movieList) => movieList?.results ?? [],
            ),
            const SizedBox(height: 20),
            MovieSection(
              isLoading: _controller.isLoadingPopular,
              apiError: _controller.apiErrorPopular,
              movieList: _controller.popularMovieList,
              heading: 'Popular Movies',
              getResults: (movieList) => movieList?.results ?? [],
            ),
          ],
        );
      }),
    );
  }
}
