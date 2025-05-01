import 'package:prj/Models/Notification.dart';

class user {
  final String _id;
  final String _email;
  final String _userName;
  final String _ImageUrl;
  final String _fullName;
  final List<myNotification> _notifications;

  user({
    String? id,
    String? email,
    String? userName,

    String? ImageUrl,
    String? fullName,
    List<myNotification>? notifications,
  }) : _id = id ?? '',
       _email = email ?? 'Guest',
       _ImageUrl = ImageUrl ?? '',
       _fullName = fullName ?? 'Guest',
       _notifications = notifications ?? [],
       _userName = userName ?? '';

  String get id => _id;
  String get email => _email;
  String get ImageUrl => _ImageUrl;
  String get fullName => _fullName;
  String get userName => _userName;

  List<myNotification> get notifications => _notifications;
}

enum filters { isSugary, isDairy, isDecaf, containsNuts, containsCaffeine }
