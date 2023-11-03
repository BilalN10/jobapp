import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class CheckHTML extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Widget from HTML'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: HtmlWidget(
              '<p><strong>Albania</strong> is a country located in<span style="color: #ff6600;"> Southeastern Europe</span> and is officially known as the Republic of Albania.&nbsp;&nbsp;over 50% of the population is dependent on agriculture, foreign businesses have migrated to Albania, creating employment opportunities in industries like energy, textiles, transport infrastructure, and tourism. The country is considered an <span style="color: #ff6600;">upper-middle-income</span> economy with a high Human Development Index.</p>'),
        ),
      ),
    );
  }
}
