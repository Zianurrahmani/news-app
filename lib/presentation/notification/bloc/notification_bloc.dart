import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final _box = Hive.box('notifications');

  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoad);
    on<MarkAsRead>(_onMarkAsRead);
    on<ClearNotifications>(_onClear);
  }

  void _onLoad(LoadNotifications event, Emitter emit) {
    final data = _box.values.toList();
    emit(NotificationLoaded(data));
  }

  void _onMarkAsRead(MarkAsRead event, Emitter emit) {
    final noti = _box.getAt(event.index);
    _box.putAt(event.index, {
      ...noti,
      "read": true,
    });
    add(LoadNotifications());
  }

  void _onClear(ClearNotifications event, Emitter emit) {
    _box.clear();
    emit(NotificationLoaded([]));
  }
}
