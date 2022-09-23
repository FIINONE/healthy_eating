abstract class RemoteConfigState {}

class RemoteConfigLoading extends RemoteConfigState {}

class RemoteConfigData extends RemoteConfigState {
  final String url;

  RemoteConfigData({
    required this.url,
  });
}

class RemoteConfigCondition extends RemoteConfigState {}

extension RemoteConfigStateUnion on RemoteConfigState {
  T map<T>({
    required T Function(RemoteConfigLoading) loading,
    required T Function(RemoteConfigData) data,
    required T Function(RemoteConfigCondition) condition,
  }) {
    if (this is RemoteConfigLoading) return loading(this as RemoteConfigLoading);
    if (this is RemoteConfigData) return data(this as RemoteConfigData);
    if (this is RemoteConfigCondition) return condition(this as RemoteConfigCondition);

    throw AssertionError('Union does not match any possible values');
  }
}
