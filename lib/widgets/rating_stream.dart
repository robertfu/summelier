import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:summelier/bloc/rating_bloc.dart';

class RatingStream extends StatelessWidget {
  const RatingStream({
    Key? key,
    required this.ratingBloc,
    required this.controller,
  }) : super(key: key);

  final RatingBloc ratingBloc;
  final PanelController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ratingBloc.rating,
      builder: (_, AsyncSnapshot<double> snapshot) {
        double rating = 0;
        if (!snapshot.hasError && snapshot.hasData) {
          rating = snapshot.data!;
        }
        return RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          maxRating: 5,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            ratingBloc.updateRating(rating);
            controller.open();
          },
        );
      },
    );
  }
}
