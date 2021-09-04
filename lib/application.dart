
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summelier/rating.dart';

import 'bloc/rating_bloc.dart';

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => RatingBloc(),
      dispose: (_, RatingBloc ratingBloc) => ratingBloc.dispose(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RatingWidget(),
      ),
    );
  }
}