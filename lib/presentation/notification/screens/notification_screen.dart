import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/notification/bloc/notification_bloc.dart';
import 'package:news_app/presentation/notification/bloc/notification_event.dart';
import 'package:news_app/presentation/notification/bloc/notification_state.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<NotificationBloc>().add(ClearNotifications());
            },
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => NotificationBloc()..add(LoadNotifications()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoaded) {
              if (state.notifications.isEmpty) {
                return const Center(child: Text("No notifications yet"));
              }

              return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final n = state.notifications[index];
                  return ListTile(
                    leading: Icon(
                      n["read"] ? Icons.notifications : Icons.notifications_active,
                      color: n["read"] ? Colors.grey : Colors.blue,
                    ),
                    title: Text(n["title"]),
                    subtitle: Text(n["body"]),
                    onTap: () {
                      context.read<NotificationBloc>().add(MarkAsRead(index));
                    },
                  );
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
