class AppStateService {
  final Map<Type, dynamic> _types = {};
  final Map<String, dynamic> _strings = {};

  void register<T>(T instance, {String? key}) {
    if (key != null) {
      return _strings.addAll({key: instance});
    }
    return _types.addAll({T: instance});
  }

  T get<T>({String? key}) {
    if (key != null) {
      final value = _strings[key];
      if (value == null) {
        throw Exception("Key not registered");
      }
      return value;
    }

    final value = _types[T];
    if (value == null) {
      throw Exception("Singleton not registered");
    }
    return value;
  }
}

T getValue<T>({String? key}) {
  return AppStateService().get<T>(key: key);
}

T registerOrUpdateValue<T>(T instance, {String? key}) {
  AppStateService().register<T>(instance, key: key);
  return instance;
}
