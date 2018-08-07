import 'dart:io';
import 'package:angel_framework/angel_framework.dart';
import 'package:FeedServer/angel_hello.dart';

main() async {

  var app = await createServer();
  var http = new AngelHttp(app);
  var server = await http.startServer(InternetAddress.anyIPv4 , 8080);
  print('Listening at ${server.address.address} on port ${server.port}');


}