// import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:ably_flutter/ably_flutter.dart';
import 'package:eden_demo/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AblyService {
  // ignore: non_constant_identifier_names
  String ORDERS_CHANNEL = 'ORDER';
  final ClientOptions _clientOptions = ClientOptions(
    key: Keys.ablyKey,
  );
  late Realtime _realtime;

  Stream<ConnectionStateChange> get connection => _realtime.connection.on();
  RealtimeChannel channel(String chn) => _realtime.channels.get(chn);
  Future<void> init() async {
    _realtime = Realtime(options: _clientOptions);
    await _realtime.connect();
  }
}

final ablyServiceProvider = Provider<AblyService>((ref) {
  return AblyService();
});
