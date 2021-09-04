
import 'package:flutter/material.dart';
import 'package:summelier/bloc/rating_bloc.dart';
import 'package:summelier/models/question_details.dart';

class DetailsWidget extends StatelessWidget {
  final QuestionDetails questionDetails;
  final RatingBloc ratingBloc;

  DetailsWidget(this.questionDetails, this.ratingBloc);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        questionDetails.toggleSelection();
        ratingBloc.refresh();
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(questionDetails.description),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(
                color: Colors.grey, width: 1, style: BorderStyle.solid),
            color:
                questionDetails.selected ? Colors.greenAccent : Colors.yellow),
      ),
    );
  }
}