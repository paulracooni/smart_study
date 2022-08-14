class StudyInfo {
  String studyTitle;
  List<String> paragraphs;
  List<String> _originParagraphs = [];

  StudyInfo({required this.studyTitle, required this.paragraphs}) {
    paragraphs = List<String>.from(paragraphs);
     _originParagraphs = List<String>.from(paragraphs);
  }

  void shuffle() {
    paragraphs.shuffle();
  }

  void rollback() {
    paragraphs = List<String>.from(_originParagraphs);
  }
}