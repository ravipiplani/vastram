import 'package:closet/components/decorated_container.dart';
import 'package:flutter/material.dart';

class WeatherReport extends StatefulWidget {
  WeatherReport({Key key}) : super(key: key);

  _WeatherReportState createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: DecoratedContainer(
          showGradient: false,
          showImage: false,
          padding: EdgeInsets.symmetric(vertical: 30),
          borderLeft: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.wb_sunny, size: 32, color: Colors.white60,),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text('36 ${String.fromCharCode(0x00B0)}',
                        style: TextStyle(fontSize: 60),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('GURGAON',
                  style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white54),),
              )
            ],
          ),
        ),
      )
    );
  }
}