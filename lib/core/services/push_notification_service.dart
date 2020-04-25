import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kamera_teman/core/providers/chat_provider.dart';

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
  PushNotificationService(this.chatProvider);

  final ChatProvider chatProvider;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future init() async {
    _fcm.subscribeToTopic('admin');
    _fcm.configure(
      // when app is open (foreground)
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage $message');

        if (message['notification']['title'] == "Anda mempunyai pesan baru") {
          // trigger function in provider
          chatProvider.getMessages(id: chatProvider.currentSavedMessageId);
        }
      },
      // when app is in background
      onResume: (Map<String, dynamic> message) async {
        print('onResume $message');

        if (message['notification']['title'] == "Anda mempunyai pesan baru") {
          // trigger function in provider
          chatProvider.getMessages(id: chatProvider.currentSavedMessageId);
        }
      },
      // when app has been terminated
      onBackgroundMessage: myBackgroundMessageHandler,
    );
  }
}
