import 'package:rxdart/rxdart.dart';
import 'package:summelier/models/question_details.dart';

class RatingBloc {
  final BehaviorSubject<List<QuestionDetails>> questionSubject =
      BehaviorSubject.seeded([
    QuestionDetails('Fair prices'),
    QuestionDetails('Substainable packing'),
    QuestionDetails('Good communication'),
    QuestionDetails('Excellent quality'),
    QuestionDetails('Well packed'),
    QuestionDetails('Good portion')
  ]);

  final BehaviorSubject<bool> panelOpenSubject = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<double> ratingSubject = BehaviorSubject<double>.seeded(0);


  Stream<List<QuestionDetails>> get questions => questionSubject.stream;
  Stream<bool> get panelOpen => panelOpenSubject.stream;
  Stream<double> get rating => ratingSubject.stream;
  Stream<bool> get canSave => ratingSubject.stream.map((currentRating) => currentRating != 0);

  void addQuestion(String question){
    final allQuestions = questionSubject.value;
    allQuestions.add(QuestionDetails(question, selected:  true));
    questionSubject.add(allQuestions);
  }

  void refresh(){
    questionSubject.add(questionSubject.value);
  }


  void changePanelOpen(bool open) {
    panelOpenSubject.add(open);
  }

  void updateRating(double rating) {
    ratingSubject.add(rating);
  }

  void save(){
    final double rating = ratingSubject.value;
    final List<String> goodies = questionSubject.value.where((q) => q.selected).map((q) => q.description).toList();

    print('Rating is $rating, and the googies are $goodies');
  }

  void dispose() {
    questionSubject.close();
    panelOpenSubject.close();
    ratingSubject.close();
  }
}
