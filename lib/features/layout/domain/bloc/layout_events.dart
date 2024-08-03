class LayoutEvent{}
class ChangeTabEvent extends LayoutEvent{
  int newTab;
  ChangeTabEvent({required this.newTab});
}
