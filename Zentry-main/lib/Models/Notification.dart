class myNotification {
  final String message;
  myNotification({required this.message});

  factory myNotification.fromJson(Map<String, dynamic> json) {
    return myNotification(message: json['message'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
