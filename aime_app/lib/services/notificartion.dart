import 'package:dailyme/main.dart';
import 'package:dailyme/screens/second_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailyme/main.dart';
class NotificationService {
  static Future<void> initializeNotification() async {
    // Initialize Awesome Notifications
    await AwesomeNotifications().initialize(
      // App icon resource path (null for default)
      null,
      // Define notification channels
      [
        NotificationChannel(
          // channelGroupKey: 'high_importance_channel_group',
          channelKey: 'alerts',
          channelName: 'Alerts',
          channelDescription: 'Channel with high importance',
          defaultColor: Colors.red,
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        ),
      ],
      // Define notification channel groups
      // channelGroups: [
      //   NotificationChannelGroup(
      //     channelGroupKey: 'high_importance_channel_group',
      //     channelGroupName: 'High Importance Channel Group',
      //   ),
      // ],
      debug: true,
    );

    // Request permission to send notifications if not allowed
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    // Set up notification listeners
    // await AwesomeNotifications().setListener(
    //   onNotificationCreated: onNotificationCreatedMethod,
    //   onNotificationDisplayed: onNotificationDisplayedMethod,
    //   onNotificationAction: onActionReceivedMethod,
    //   onNotificationDismissed: onDismissActionReceivedMethod,
    // );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification created: $receivedNotification');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification displayed: $receivedNotification');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('Action received: $receivedAction');

    // Handle action based on received payload
    final payload = receivedAction.payload ?? {};
    if (payload['navigate'] == 'true') {
      // Navigate to second screen
      Get.to(SecondScreen(), transition: Transition.zoom);
      // MyApp.navigatorKey.currentState?.push(
      //   MaterialPageRoute(builder: (_)=>const SecondScreen())
      // );
    }
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification dismissed: $receivedNotification');
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? summary,
    Map<String, String>? payload,
    ActionType actionType = ActionType.Default,
    NotificationLayout notificationLayout = NotificationLayout.Default,
    NotificationCategory? category,
    String? bigPicture,
    List<NotificationActionButton>? actionButtons,
    bool scheduled = false,
    int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'alerts',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval!,
              timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }
}



// NotificationService.showNotification(
//   title:"title",
//   body:"body of image",
//   summary: "summary",
//   NotificationLayout:NotificationLayout.BigPicture(
//     bigPicture:"image path",
//   )
// );

// NotificationService.showNotification(
//   title:"title",
//   body:"body of image",
//   payload: {
//     "navigate": "true",
//   },
//   actionButtons:[

//   ]
// );

// NotificationService.showNotification(
//   title:"title",
//   body:"body of image",
//   scheduled: true,
//   Interval: 5,
// );