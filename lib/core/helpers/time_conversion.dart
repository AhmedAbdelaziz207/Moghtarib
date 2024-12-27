String timeAgo(DateTime timestamp) {
  final now = DateTime.now();

  // Check if timestamp is in the future
  if (timestamp.isAfter(now)) {
    return 'just now';
  }

  final difference = now.difference(timestamp);

  if (difference.inDays >= 7) {
    // Return the exact date if the timestamp is older than a week
    return '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}';
  } else if (difference.inDays >= 1) {
    // Return days ago
    return '${difference.inDays}d';
  } else if (difference.inHours >= 1) {
    // Return hours ago
    return '${difference.inHours}h';
  } else if (difference.inMinutes >= 1) {
    // Return minutes ago
    return '${difference.inMinutes}m';
  } else {
    // Return seconds ago
    return '${difference.inSeconds}s';
  }
}

