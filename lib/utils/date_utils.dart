const List<String> _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

/// Formats a date like "Oct 1, 2026".
String formatDate(DateTime date) =>
    '${_months[date.month - 1]} ${date.day}, ${date.year}';

/// Strips the time so dates compare by day only.
DateTime dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

bool isOverdue(DateTime date) => dateOnly(date).isBefore(dateOnly(DateTime.now()));

bool isToday(DateTime date) => dateOnly(date) == dateOnly(DateTime.now());
