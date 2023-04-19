import 'package:flutter/cupertino.dart';
import 'package:gymkhana_club/extras/fucntions.dart';
import 'package:gymkhana_club/shared/providers/data_provider.dart';
import 'package:gymkhana_club/shared/service.dart';
import 'package:provider/provider.dart';

class RoomReservationProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  var dateInput = TextEditingController();
  var time = TextEditingController();
  var days = TextEditingController();
  var room = TextEditingController();
  var remarks = TextEditingController();

  void reserveRoom(BuildContext context) async {
    if (dateInput.text.trim().isEmpty ||
        time.text.trim().isEmpty ||
        days.text.trim().isEmpty ||
        room.text.trim().isEmpty ||
        remarks.text.trim().isEmpty) {
      Functions.showSnackBar(context, "All fields are required");
      return;
    }
    final memberId = context.read<DataProvider>().memberId;
    Functions.showLoaderDialog(context);
    try {
      var url = "Reservations/RoomReservation";
      var body = {
        "id": 0,
        "memberid": memberId,
        "bdate": dateInput.text.trim(),
        "btime": time.text.trim(),
        "noofRooms": int.tryParse(room.text.trim()),
        "noofDays": int.tryParse(days.text.trim()),
        "remarks": remarks.text.trim(),
        "advance": 0
      };
      debugPrint(body.toString());
      await _apiService.post(url, body);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Functions.showSnackBar(context, "Room Reservation Successful");
    } catch (e) {
      Navigator.of(context).pop();
      Functions.showSnackBar(context, "Something went wrong");
    }
  }
}
