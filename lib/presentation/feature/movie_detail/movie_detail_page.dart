import 'package:flutter/material.dart';
import 'package:movie_app/domain/models/movie_res_model.dart';
import 'package:movie_app/core/utils/app_strings.dart';
import 'package:movie_app/core/utils/debug_logger.dart';

class MovieDetailPage extends StatelessWidget {
  final Result movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    debuggerAdvance(tag: "", value: "MovieDetailPage build method render");
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title ?? AppStrings.movieDetails),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              movie.backdropPath != null
                  ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
                  : '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image,
                  size: 150,
                  color: Colors.grey,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
       /*           const SizedBox(height: 8),
                  Text(
                    movie.overview ?? AppStrings.noDescriptionAvailable,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Rating: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${movie.voteAverage ?? 0}/10'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Release Date: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(movie.releaseDate ?? AppStrings.unknown),
                    ],
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}