class EditEventScreenState {
  final bool loading;
  final bool allDay;
  final String? message;

  EditEventScreenState({this.loading = false, this.allDay = false, this.message});

  EditEventScreenState copy({bool? loading, bool? allDay,  String? message}) {
    return EditEventScreenState(
      loading: loading ?? this.loading,
      allDay: allDay ?? this.allDay,
      message: message ?? this.message,
    );
  }
}