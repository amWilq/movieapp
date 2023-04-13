import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/movie.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;
  final bool isSimpleModeEnabled;

  DetailPage(
    this.movie,
    this.isSimpleModeEnabled,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildbackground(context, movie),
          _buildmovieButton(context),
          Positioned(
              bottom: 60,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ))
        ],
      ),
    );
  }

  Positioned _buildmovieButton(BuildContext context) {
    return Positioned(
      bottom: 150,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(movie.title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    height: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: isSimpleModeEnabled ? 60 : 22,
                    color: Colors.redAccent)),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(movie.overview,
                  style: isSimpleModeEnabled
                      ? Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(height: 1.75, color: Colors.white)
                      : Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(height: 1.75, color: Colors.white)),
            ),
            const SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'IMDB Rating: ${movie.vote_average}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(Icons.star, color: Colors.yellowAccent, size: 19),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildbackground(context, movie) {
    return [
      Container(
        height: double.infinity,
        color: Color(0xff000B49),
      ),
      CachedNetworkImage(
          imageUrl: movie.poster_path,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          fit: BoxFit.cover),
      const Positioned.fill(
          child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Color(0xff000B49),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.3, 0.5])))),
    ];
  }
}
