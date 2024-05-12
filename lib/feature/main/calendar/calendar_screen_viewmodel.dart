import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/model/paginated_session_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/feature/main/calendar/calendar_screen_state.dart';

class CalendarScreenViewModel extends ChangeNotifier {
  final UserApiService _userApiService;

  CalendarScreenViewModel(this._userApiService);

  CalendarScreenState _state = CalendarScreenState();
  CalendarScreenState get state => _state;

  Future<void> getUpcomingSessionsBetweenDates(DateTime startDate, DateTime endDate) async {
    _update(loading: true);
    try {
      PaginatedSessionDto sessions = await _userApiService.getUpcomingSessionsBetweenDates(
        startDate,
        endDate,
      );
      _update(upcomingSessions: sessions.result, loading: false);
    } catch (e) {
      _update(loading: false);
    }
  }

  void _update({
    bool? loading,
    List<SessionDto>? upcomingSessions,
    String? message,
  }) {
    _state = _state.copy(
      loading: loading,
      upcomingSessions: upcomingSessions,
      message: message,
    );

    notifyListeners();
  }
}
