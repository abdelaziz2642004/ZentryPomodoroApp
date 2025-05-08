import 'package:prj/Models/Notification.dart';

class FireUser {
  final String _id;
  final String _email;
  String _ImageUrl;
  String _fullName;

  set fullName(value) => _fullName = value;
  get ImageUrl => _ImageUrl;
  set ImageUrl(value) => _ImageUrl = value;
  get fullName => _fullName;

  final List<myNotification> _notifications;

  FireUser({
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
       _notifications = notifications ?? [];

  String get id => _id;
  String get email => _email;
  List<myNotification> get notifications => _notifications;

  Map<String, dynamic> toMap() {
    return {
      'name': _fullName,
      'email': _email.trim(),
      'imageUrl': _ImageUrl,
      'id': _id,
    };
  }
}
