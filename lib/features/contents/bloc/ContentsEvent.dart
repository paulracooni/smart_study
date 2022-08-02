abstract class ContentsEvent {}

class UpdateChapterIndexEvent extends ContentsEvent {
  int chapterIndex;
  UpdateChapterIndexEvent(this.chapterIndex);
}

class UpdateLevelIndexEvent extends ContentsEvent {
  int levelIndex;
  UpdateLevelIndexEvent(this.levelIndex);
}

class UpdateBookIndexEvent extends ContentsEvent {
  int bookIndex;
  UpdateBookIndexEvent(this.bookIndex);
}