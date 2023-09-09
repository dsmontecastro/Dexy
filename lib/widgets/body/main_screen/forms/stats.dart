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
    fontWeight: FontWeight.bold,
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

    final List<RadarEntry> entries = stats.getEntries(mode: StatMode.radar);

    final dataSet = RadarDataSet(
      entryRadius: 2,
      dataEntries: entries,
      borderWidth: widthThick,
      borderColor: borderColor,
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
        color: Colors.grey.shade900.withOpacity(0.5),
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

  static final color = Colors.grey.shade900;
  static const style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final borderDecor = BoxDecoration(
    color: Colors.white.withOpacity(0.25),
    border: Border.all(width: 1, color: color),
  );

  Widget makeCell(String text, double size) {
    return Container(
      decoration: borderDecor,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: style.copyWith(fontSize: size),
      ),
    );
  }

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double width = constraints.maxWidth;
      final fontSize = width * 0.04;

      final names = statNames.map((s) => makeCell(s, fontSize)).toList();
      final values = stats.toList().map((i) {
        return makeCell(i.toString(), fontSize);
      }).toList();

      return Table(
        border: TableBorder.all(width: 2, color: color),
        children: [
          TableRow(children: names),
          TableRow(children: values),
        ],
      );
    });

    //
  }
}
