import 'package:get/get.dart';
import 'package:themovieflex/Model/movie_detail.dart';
import 'package:themovieflex/Model/top_rated_movie.dart';
import 'package:themovieflex/Network%20Services/api_endpoint.dart';
import 'package:themovieflex/Network%20Services/network_client.dart';
import 'package:themovieflex/Widget/constant.dart';

import '../Model/error_model.dart';

class HomeController extends NetworkClient {
  @override
  void onInit() {
    fetchUpcomingMovieList();
    fetchTopMovieList();
    fetchPopularMovieList();
    super.onInit();
  }

  Movie? topRatedMovieList;
  Movie? popularMovieList;
  Movie? upcomingMovieList;
  Movie? recommendationsMovieList;
  MovieDetail? movieDetail;
  var isLoadingTopRated = false.obs;
  var isLoadingPopular = false.obs;
  var isLoadingUpcoming = false.obs;
  var isLoadingDetails = false.obs;
  var isLoadingRecommendations = false.obs;
  ApiError? apiErrorTopRated;
  ApiError? apiErrorPopular;
  ApiError? apiErrorUpcoming;
  ApiError? apiErrorDetails;
  ApiError? apiErrorRecommendations;

  // Fetch Top Rated Movies
  Future fetchUpcomingMovieList() async {
    isLoadingTopRated(true);
    apiErrorTopRated = null;
    try {
      var response = await get(
        url: ApiEndPoints.upcoming,
      );
      if (response.statusCode == 200) {
        upcomingMovieList = Movie.fromJson(response.data);
      } else {
        apiErrorUpcoming = ApiError(
          message: 'Failed to load upcoming movies',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      apiErrorUpcoming = ApiError(
        message: e.toString(),
        statusCode: null,
      );
      logger.d(apiErrorUpcoming);
    } finally {
      isLoadingTopRated(false);
    }
  }

  Future fetchTopMovieList() async {
    isLoadingTopRated(true);
    apiErrorTopRated = null;
    try {
      var response = await get(url: ApiEndPoints.topRated);
      if (response.statusCode == 200) {
        topRatedMovieList = Movie.fromJson(response.data);
      } else {
        apiErrorTopRated = ApiError(
          message: 'Failed to load top-rated movies',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      apiErrorTopRated = ApiError(
        message: e.toString(),
        statusCode: null,
      );
      logger.d(apiErrorTopRated);
    } finally {
      isLoadingTopRated(false);
    }
  }

  // Fetch Popular Movies
  Future fetchPopularMovieList() async {
    isLoadingDetails(true);
    apiErrorDetails = null;
    try {
      var response = await get(url: ApiEndPoints.popular);
      if (response.statusCode == 200) {
        popularMovieList = Movie.fromJson(response.data);
      } else {
        apiErrorPopular = ApiError(
          message: 'Failed to load popular movies',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      apiErrorPopular = ApiError(
        message: e.toString(),
        statusCode: null,
      );
      logger.d(apiErrorPopular);
    } finally {
      isLoadingPopular(false);
    }
  }

  Future fetchRecommendMovieList(var id) async {
    isLoadingRecommendations(true);
    apiErrorRecommendations = null;
    recommendationsMovieList = null;
    try {
      var response = await get(url: "$id/${ApiEndPoints.recommendations}");
      if (response.statusCode == 200) {
        recommendationsMovieList = Movie.fromJson(response.data);
      } else {
        apiErrorRecommendations = ApiError(
          message: 'Failed to load recommendation movies',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      apiErrorRecommendations = ApiError(
        message: e.toString(),
        statusCode: null,
      );
      logger.d(apiErrorRecommendations);
    } finally {
      isLoadingRecommendations(false);
    }
  }

  Future fetchMovieDetails(var id) async {
    isLoadingDetails(true);
    apiErrorDetails = null;

    try {
      fetchRecommendMovieList(id);
      var response = await get(url: id.toString());
      if (response.statusCode == 200) {
        movieDetail = MovieDetail.fromJson(response.data);
      } else {
        apiErrorDetails = ApiError(
          message: 'Failed to load popular movies',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      apiErrorDetails = ApiError(
        message: e.toString(),
        statusCode: null,
      );
      logger.d(apiErrorDetails);
    } finally {
      isLoadingDetails(false);
    }
  }

  // Future fetchCast(var id) async {
  //   isLoadingDetails(true);
  //   apiErrorDetails = null;

  //   try {
  //     var response = await get(url: "$id/${ApiEndPoints.credits}");
  //     if (response.statusCode == 200) {
  //       movieDetail = MovieDetail.fromJson(response.data);
  //     } else {
  //       apiErrorDetails = ApiError(
  //         message: 'Failed to load popular movies',
  //         statusCode: response.statusCode,
  //       );
  //     }
  //   } catch (e) {
  //     apiErrorDetails = ApiError(
  //       message: e.toString(),
  //       statusCode: null,
  //     );
  //     logger.d(apiErrorDetails);
  //   } finally {
  //     isLoadingDetails(false);
  //   }
  // }
}
