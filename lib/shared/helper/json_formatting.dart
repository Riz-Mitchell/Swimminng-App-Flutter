// Capitalize the first letter
String capitalizeFirst(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

// Convert enum to JSON string
String enumToJson<T extends Enum>(T enumValue) =>
    capitalizeFirst(enumValue.name);

// Convert JSON string to enum, ignoring case for safety
T enumFromJson<T extends Enum>(List<T> values, String jsonString) {
  final lower = jsonString.toLowerCase();
  return values.firstWhere(
    (e) => e.name.toLowerCase() == lower,
    orElse: () => throw Exception('Unknown enum value: $jsonString'),
  );
}
