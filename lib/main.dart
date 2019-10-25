import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test2/Models/WeatherModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';


Future<WeatherModel> getWeather(String lat, String lng) async{
  final reponse= await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=06ccac2af34c3e92791d3d0cc000704e&units=metric');

  if(reponse.statusCode == 200){
    var result = json.decode(reponse.body);
    var model = WeatherModel.fromJson(result);
    return model;
  }
  else
    throw Exception('Failed to load Weather Information');
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp>{


  Map<String,double> currentLocation = new Map();
  StreamSubscription<Map<String,double>> locaitionSubscription;

  Location location = new Location();
  String error;


  @override
  void initState() {
    super.initState();

    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;

    initPlatformState();
    locaitionSubscription = location.onLocationChanged().listen((Map<String,double> result){
      setState(() {
        currentLocation = result;
      });
    });
  }

  @override


  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Weather App',
      //theme: ThemeData.light(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Weahter App'),
        ),
        body: Container(
          //width: 500,
            child: FutureBuilder<WeatherModel>(future: getWeather(currentLocation['latitude'].toString(),currentLocation['longitude'].toString()),
              builder: (context, snapshot){
              if(snapshot.hasData)
                {
                  WeatherModel model = snapshot.data;
                  //format date
                  var fm = new DateFormat('h:mm');
                  var fm_date = new DateFormat('d MMM yyy');
                  var fm_hour = new DateFormat.Hm();
                  return Column(
                    children: <Widget>[
                      Container(
                        width: 500,
                        height: 380,
                        color: Colors.green,
                          child: Column(
                            children: <Widget>[
                              Text('${model.name}',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Image.network('https://openweathermap.org/img/wn/${model.weather[0].icon}@2x.png'),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text('${model.main.temp}°C',
                                  style: TextStyle(
                                    fontSize: 100.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 35.0),
                                child: Text('${fm.format(new DateTime.fromMillisecondsSinceEpoch((model.dt*1000), isUtc: false))}',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight:  FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text('${fm_date.format(new DateTime.fromMillisecondsSinceEpoch((model.dt*1000),isUtc: false))}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Wind (Speed/Deg):',
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                Expanded(
                                  child:Text('${model.wind.speed}(m/s)/${model.wind.deg}',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    decoration: TextDecoration.none,
                                  ),
                                  textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Pressure: ',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                                Expanded(
                                  child: Text('${model.main.pressure} hpa',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      decoration: TextDecoration.none),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Humidity: ',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                                Expanded(
                                    child:  Text('${model.main.humidity}%',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('GeoCode: ',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                                Expanded(
                                    child: Text('[${model.coord.lat}/${model.coord.lon}]',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 140,
                        height: 60,
                        padding: const EdgeInsets.only(top: 10.0),
                        child: RaisedButton(
                          child: Text('CANCEL',style: TextStyle(fontSize: 20.0),),
                            onPressed: (){
                              showAlertDialog(context);
                            }),
                      )
                    ],
                  );
                }
              else if(snapshot.hasError)
                return Text('${snapshot.error}',style: TextStyle(fontSize: 30.0,color: Colors.red)
                ,);
              return CircularProgressIndicator();//default show loading
            },
            ),
          ),
        ),
    );
  }

  void initPlatformState() async {
    Map<String,double> my_location;

    try{
      my_location = await location.getLocation();
      error = '';
    }on PlatformException catch(e){
      if(e.code == 'PERMISSION_DENIED')
        error = 'Permission denied';
      else if(e.code == 'PERMISSION_DENIED_NEVER_ASK')
        error = 'Permission denied - please ask the user';
      my_location = null;
    }
    setState(() {
      currentLocation = my_location;
    });
  }

  void showAlertDialog(BuildContext context){
    var alertDialog = new AlertDialog(
      title: Text('Information'),
      content: Text('Do you want to exit?'),
      actions: <Widget>[
        RaisedButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text('No')
          ,),
        RaisedButton(
          onPressed: (){
            SystemNavigator.pop();
          },
          child: Text('Yes'),
        ),
      ],
    );
    showDialog(
        context: context,
    builder: (BuildContext context){
          return alertDialog;
    });
  }
}