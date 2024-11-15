import 'package:notes/core/navigation/routes/reminders_route.dart';

class ReminderDetailsRoute {
  static const dateKeyArg = 'date';
  static const idKeyArg = 'id';

  static const name = 'reminder_details';

  static String getRouteWithArgs({required DateTime date, String? id}) {
    final buffer = StringBuffer('${RemindersRoute.name}/$name?$dateKeyArg=$date');
    if (id != null) {
      buffer.write('&$idKeyArg=$id');
    }
    return buffer.toString();
  }
}
