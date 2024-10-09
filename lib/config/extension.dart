extension NullOrEmptyExtension on Object? {
  bool get isNullOrEmpty {
    if (this == null) return true;

    // Handle String case
    if (this is String) return (this as String).isEmpty;

    // Handle List case
    if (this is List) return (this as List).isEmpty;

    // Handle Map case
    if (this is Map) return (this as Map).isEmpty;

    // Handle Set case
    if (this is Set) return (this as Set).isEmpty;

    return false;
  }
}
