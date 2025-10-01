import 'dart:math';
import 'package:workmanager/workmanager.dart';
import 'notification_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const dailyTask = "dailyPokemonTask";

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    if (task == dailyTask) {
      final randomId = Random().nextInt(1302) + 1; // random Gen 1
      final notif = NotificationService();

      if (task == dailyTask) {
        final randomId = Random().nextInt(151) + 1; // random Gen 1
        final url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$randomId");
        final resp = await http.get(url);
        if (resp.statusCode == 200) {
          final data = jsonDecode(resp.body);
          final name = data["name"];
          final spriteUrl =
              data["sprites"]["other"]["official-artwork"]["front_default"];

          final notif = NotificationService();
          await notif.init();
          await notif.showBigPictureNotification(
            title: "Pokémon of the Day!",
            body: "${name.toUpperCase()} (#$randomId) is waiting for you!",
            payload: randomId.toString(),
            imageUrl: spriteUrl,
          );
        }
      }

      await notif.init();
      await notif.showNotification(
        title: "Pokémon of the Day!",
        body: "Check out Pokémon #$randomId today!",
        payload: randomId.toString(), // gửi id Pokémon
      );
    }
    return Future.value(true);
  });
}
