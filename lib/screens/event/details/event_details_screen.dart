import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/events_model.dart';
import 'package:my_gym_book/common/models/exercises_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventModel event;

  const EventDetailsScreen({Key? key, required this.event}) : super(key: key);

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late EventModel event;

  @override
  void initState() {
    super.initState();
    event = widget.event;
    FirebaseAnalyticsService.logEvent(
        "event_details",
        {}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do evento"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Image(image: NetworkImage("https://i.imgur.com/2osZGYs.jpg")),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              event.title,
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: ListView.builder(
                itemCount: event.exercises.length,
                itemBuilder: (context, index) {
                  ExercisesModel cardItem = event.exercises[index];
                  return Card(
                    child: ListTile(
                      title: Text(cardItem.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Series: ${cardItem.series} Repetições: ${cardItem.repetitionCount}'),
                          Text('Intervalo: ${cardItem.interval} segundos'),
                          Text('Carga: ${cardItem.weight}'),
                        ],
                      ),
                      leading: Image(
                        image: NetworkImage(cardItem.imagePath),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
