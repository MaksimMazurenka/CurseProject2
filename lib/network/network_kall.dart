import 'package:http/http.dart' as http;

Future<String?> uploadImageApi(String filePath) async{
  //http.MultipartRequest request = new http.MultipartRequest("POST", Uri.parse('https://10.0.2.2:44395/api/upload'));
  http.MultipartRequest request = new http.MultipartRequest("POST", Uri.parse('http://localhost:5000/api/upload'));
  http.MultipartFile multipartFile = await  http.MultipartFile.fromPath('file', filePath);
  request.files.add(multipartFile);
  var headers = {"content-type": "multipart/from-data"};
  request.headers.addAll(headers);
  var response = await request.send();
  if(response.statusCode == 200){
    final responseString = await response.stream.bytesToString();
    return responseString;
  }else{
    return null;
  }
}