import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../utils/constants.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  StreamController<Map<String, dynamic>>? _controller;
  StreamController<bool>? _connectionController;
  
  // DONE: Implement WebSocket connection
  // - connect()
  // - disconnect()
  // - Stream<Map<String, dynamic>> get stream
  // - Handle real-time market updates
  
  Stream<Map<String, dynamic>>? get stream => _controller?.stream;
  Stream<bool>? get connectionStream => _connectionController?.stream;
  bool get isConnected => _channel != null;
  
  void connect() {
    disconnect();
    _controller = StreamController<Map<String, dynamic>>.broadcast();
    _connectionController = StreamController<bool>.broadcast();
    _channel = WebSocketChannel.connect(Uri.parse(AppConstants.wsUrl));
    _connectionController?.add(true);

    _channel!.stream.listen(
      (message) {
        try {
          final data = json.decode(message.toString());
          if (data is Map<String, dynamic>) {
            _controller?.add(data);
          }
        } catch (_) {
          // Ignore malformed messages.
        }
      },
      onError: (_) {
        _connectionController?.add(false);
      },
      onDone: () {
        _connectionController?.add(false);
      },
    );
  }
  
  void disconnect() {
    _channel?.sink.close();
    _controller?.close();
    _connectionController?.close();
    _channel = null;
    _controller = null;
    _connectionController = null;
  }
}
