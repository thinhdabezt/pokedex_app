import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iOSInit,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> showNotification({
    required String title,
    required String body,
    required String payload,
    int id = 0,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'daily_pokemon_channel',
      'Daily Pokémon',
      channelDescription: 'Daily Pokémon suggestion notification',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iOSDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  Future<void> showBigPictureNotification({
    required String title,
    required String body,
    required String payload,
    required String imageUrl,
    int id = 0,
  }) async {
    final bigPicture = BigPictureStyleInformation(
      FilePathAndroidBitmap(imageUrl), // cần convert ảnh online về local file
      contentTitle: title,
      summaryText: body,
    );

    const androidChannel = AndroidNotificationDetails(
      'daily_pokemon_channel',
      'Daily Pokémon',
      channelDescription: 'Daily Pokémon suggestion with image',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: DefaultStyleInformation(true, true),
    );

    const iOSDetails = DarwinNotificationDetails();

    final details = NotificationDetails(
      android: androidChannel,
      iOS: iOSDetails,
    );

    // tải ảnh từ internet về file tạm để dùng
    final http.Response response = await http.get(Uri.parse(imageUrl));
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/pokemon_$id.png';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    final androidDetailsWithImage = AndroidNotificationDetails(
      'daily_pokemon_channel',
      'Daily Pokémon',
      channelDescription: 'Daily Pokémon suggestion with image',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigPictureStyleInformation(
        FilePathAndroidBitmap(filePath),
        contentTitle: title,
        summaryText: body,
      ),
    );

    final detailsWithImage = NotificationDetails(
      android: androidDetailsWithImage,
      iOS: iOSDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      detailsWithImage,
      payload: payload,
    );
  }
}
