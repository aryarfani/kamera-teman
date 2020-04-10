import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:oktoast/oktoast.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    // final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    // final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future init() async {
    _fcm.subscribeToTopic('admin');
    _fcm.configure(
      // when app is open (foreground)
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage $message');
        showToast(message['notification']['body']);
      },
      // when app is in background
      onResume: (Map<String, dynamic> message) async {
        print('onResume $message');
      },
      // when app has been terminated
      onBackgroundMessage: myBackgroundMessageHandler,
    );
  }
}
