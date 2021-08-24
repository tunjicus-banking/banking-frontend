import 'package:flutter_data/flutter_data.dart';

mixin BankRemoteAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  @override
  DeserializedData<T, DataModel> deserialize(dynamic data, {String? key}) {
    // whatever condition makes sense for your data
    if (data['content'] is Iterable) {
      return super.deserialize(data['content'], key: key);
    }
    return super.deserialize(data, key: key);
  }
}
