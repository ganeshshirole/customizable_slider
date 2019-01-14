import 'package:customisable_slider/customisable_slider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slider Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        primaryColorDark: Colors.blue,
        accentColor: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SliderWidget(
      widgets: [
        Image.network(
            'https://www.bannerbatterien.com/upload/filecache/Banner-Batterien-Windrder2-web_bd5cb0f721881d106522f6b9cc8f5be6.jpg'),
        Image.network(
            'https://cdn.pixabay.com/photo/2015/10/29/14/32/business-1012449_960_720.jpg'),
        Image.network(
            'https://corporateindiamart.files.wordpress.com/2017/12/advertising-banner-100.jpg?w=980&h=344&crop=1'),
        Image.network(
            'https://thumbs.dreamstime.com/t/golden-giltter-bring-gold-confetti-horizontal-banner-illustration-design-glitter-star-color-present-size-67746075.jpg')
      ],
      viewportFraction: 0.94,
      viewportRadius: 5,
      viewportPadding: EdgeInsets.only(left: 3.5, top: 12, right: 3.5),
      constraints: BoxConstraints.expand(height: 145.1),
    ));
  }
}
