class QuestionDetails {
  final String description;
  bool selected;

  QuestionDetails(this.description, {this.selected = false});


  void toggleSelection(){
    selected = !selected;
  }
}
