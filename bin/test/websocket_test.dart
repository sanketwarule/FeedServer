import 'package:angel_framework/angel_framework.dart';
import 'package:FeedServer/angel_hello.dart';
import 'package:angel_test/angel_test.dart';
import 'package:test/test.dart';
import 'package:angel_websocket/angel_websocket.dart';

main() async {

  Angel app;
  TestClient client;
  
  setUp(() async {
    app = await createServer();
    client = await connectTo(app);
  });

  tearDown(() => client.close());

  test('boats', () async {
    var socket = await client.websocket();
    socket.send('test', new WebSocketAction());

    socket.send('get_boat', new WebSocketAction());

    await socket.on['got_boat'].first.then((e){
      print('Got boat : ${e.data}');
    });

    print('inside test boats');


  });


}