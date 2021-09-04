import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:summelier/bloc/rating_bloc.dart';
import 'package:summelier/models/question_details.dart';
import 'package:summelier/widgets/details_widget.dart';

class SlidingWidget extends StatelessWidget {
  const SlidingWidget({
    Key? key,
    required this.controller,
    required this.ratingBloc,
  }) : super(key: key);

  final PanelController controller;
  final RatingBloc ratingBloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SlidingUpPanel(
        controller: controller,
        onPanelClosed: () => ratingBloc.changePanelOpen(false),
        onPanelOpened: () => ratingBloc.changePanelOpen(true),
        minHeight: 0,
        maxHeight: 400,
        padding: EdgeInsets.only(bottom: 60),
        panelBuilder: (ScrollController sc) => SingleChildScrollView(
          controller: sc,
          child: StreamBuilder(
            stream: ratingBloc.questions,
            builder: (BuildContext context,
                AsyncSnapshot<List<QuestionDetails>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error'));
              }
              final questions = snapshot.data;

              return Wrap(
                  alignment: WrapAlignment.center,
                  children: questions!.map((e) => DetailsWidget(e, ratingBloc)).toList());
            },
          ),
        ),
      ),
    );
  }
}
