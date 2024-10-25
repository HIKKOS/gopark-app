bool castToBool(dynamic value) {
  if (value == null) return false;
  switch (value.runtimeType) {
    case const (int):
      return value == 1;
    case const (String):
      return value == '1';
    case const (bool):
      return value;
    default:
      return false;
  }
}
