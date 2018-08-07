import 'dart:async';
import 'dart:io';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_websocket/server.dart';


Future<Angel> createServer() async {
  var app = new Angel();
  app.configure(new AngelWebSocket(app).configureServer);
  app.configure(new MyWebSocketController(new AngelWebSocket(app)).configureServer);




  app.use('/items', new MapService());

  var ws = app.container.make(AngelWebSocket) as AngelWebSocket;
  app.all('/ws', ws.handleRequest);

  var itemService = app.service('/items');
  await itemService.create({'foo':'bar'});

  ws.onData.listen(print);
  return app;
}

@Expose('/boats')
class MyWebSocketController extends WebSocketController{
  MyWebSocketController(AngelWebSocket ws) : super(ws){
  }

  @Expose('/')
  boats() =>print('boats');

  @ExposeWs('get_boat')
  getBoat(WebSocketContext socket){
    socket.send('got_boat', {'model' : 'cx9'});
  }

  @ExposeWs('test')
  void test() {
    print("Test");
  }

}

class MyService extends Service{

  final List items = [{'foo':'bar' , 'hoo': 'boo'}];


  @override
  Future create(data, [Map params]) async{
    // TODO: implement create
    return items;
  }

  @override
  Future index([Map params]) async{
    // TODO: implement index
    return items;
  }

  @override
  Future read(id, [Map params]) async {

    print('inside read');
    print(id.runtimeType);
    // TODO: implement read

//    try {

      if (id < 0 || id >= items.length)
        throw new AngelHttpException.notFound();

//      return items[id];
//    } on AngelHttpException {
//      rethrow;
//    } catch(e){
//      throw new AngelHttpException.badRequest();
//    }
  }
}