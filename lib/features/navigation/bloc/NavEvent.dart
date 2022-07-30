abstract class NavEvent{}

class UpdateNavIndexEvent extends NavEvent {
  int navIndex;
  UpdateNavIndexEvent(this.navIndex);
}
