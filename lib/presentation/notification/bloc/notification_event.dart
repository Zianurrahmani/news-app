abstract class NotificationEvent {}

class LoadNotifications extends NotificationEvent {}

class MarkAsRead extends NotificationEvent {
  final int index;
  MarkAsRead(this.index);
}

class ClearNotifications extends NotificationEvent {}
