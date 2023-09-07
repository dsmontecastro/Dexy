import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pokedex/extensions/color.dart';

import 'package:pokedex/types/enums/typing.dart';
import 'package:pokedex/types/classes/stats.dart';
import 'package:pokedex/database/models/pokemon.dart';

class FormStats extends StatefulWidget {
  const FormStats(this.form, {super.key});
  final Pokemon form;

  @override
  createState() => FormStatsState();
}

class FormStatsState extends State<FormStats> {
  //

  // Stat Class Constants ------------------------------------------------------

  static const List<String> titles = radarTitles;

  static final max = List.filled(6, const RadarEntry(value: maxStat));
  static final maxSet = RadarDataSet(
    entryRadius: 0,
    dataEntries: max,
    fillColor: Colors.transparent,
    borderColor: Colors.transparent,
  );

  static final nil = List.filled(6, const RadarEntry(value: 1));
  static final nilSet = RadarDataSet(
    entryRadius: 5,
    dataEntries: nil,
    fillColor: Colors.transparent,
    borderColor: Colors.transparent,
  );

  // Static Design Elements ----------------------------------------------------

  static const double widthThick = 2;
  // static const

  static const radarShape = RadarShape.polygon;

  static const borderColor = Colors.black;
  static const borderThin = BorderSide(color: borderColor);
  static const borderThick = BorderSide(width: widthThick, color: borderColor);

  static const tickStyle = TextStyle(color: Colors.transparent);
  static const titleStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );

  static const cellStyle = TextStyle();

  static const cellDecor = BoxDecoration(
    border: Border.fromBorderSide(borderThick),
  );

  // State Controls ------------------------------------------------------------

  late Stats stats = Stats.blank();
  late Pokemon form = Pokemon.filler();

  @override
  void initState() {
    form = widget.form;
    stats = form.baseStats;
    super.initState();
  }

  @override
  void didUpdateWidget(FormStats oldWidget) {
    super.didUpdateWidget(oldWidget);
    form = widget.form;
    stats = widget.form.baseStats;
  }

  @override
  Widget build(context) {
    //

    final Typing type2 = form.type2;

    final Color color1 = form.type1.bgColor.withOpacity(0.8);
    final Color color2 = form.type2.bgColor.withOpacity(0.7);

    final dataSet = RadarDataSet(
      entryRadius: 2,
      borderWidth: widthThick,
      borderColor: borderColor,
      dataEntries: stats.getEntries(mode: StatMode.radar),
      fillColor: (type2 == Typing.error) ? color1.withLightness(0.3) : color2,
    );

    return LayoutBuilder(builder: (context, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;

      final padH = EdgeInsets.symmetric(horizontal: width * 0.1);
      final padV = EdgeInsets.symmetric(vertical: height * 0.1);

      final Widget chart = RadarChart(
        RadarChartData(
          dataSets: [dataSet, maxSet, nilSet],

          // Title Settings
          titleTextStyle: titleStyle.copyWith(fontSize: height * 0.04),
          titlePositionPercentageOffset: 0.13,
          getTitle: (i, _) => RadarChartTitle(text: titles[i]),

          // Radar Settings
          radarShape: radarShape,
          radarBackgroundColor: color1,
          radarBorderData: borderThick,

          // Tick Settings
          tickCount: 3,
          ticksTextStyle: tickStyle,
          tickBorderData: borderThin,
        ),
      );

      return Container(
        padding: padH,
        child: Column(children: [
          const Spacer(flex: 1),
          Expanded(flex: 6, child: Padding(padding: padV, child: chart)),
          Expanded(flex: 1, child: StatTable(stats)),
          const Spacer(flex: 1),
        ]),
      );
    });
  }
}

class StatTable extends StatelessWidget {
  const StatTable(this.stats, {super.key});
  final Stats stats;
  static final decor = BoxDecoration(
    color: Colors.white,
    border: Border.all(width: 2, color: Colors.grey.shade800),
  );

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double width = constraints.maxWidth;

      final style = TextStyle(fontSize: width * 0.04);

      Widget makeCell(String text) {
        return Container(
          decoration: decor,
          child: Text(text, style: style, textAlign: TextAlign.center),
        );
      }

      final names = statNames.map((s) => makeCell(s)).toList();
      final values = stats.toList().map((i) => makeCell(i.toString())).toList();

      return Table(
        children: [
          TableRow(children: names),
          TableRow(children: values),
        ],
      );
    });

    //
  }
}
