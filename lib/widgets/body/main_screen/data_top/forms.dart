import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:pokedex/extensions/string.dart';
import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/widgets/_misc/page_buttons.dart';

import 'package:pokedex/database/models/pokemon.dart';
import 'package:pokedex/database/models/species.dart';

import 'gradience.dart';
import 'pkmn_sprite.dart';

class Forms extends StatefulWidget {
  const Forms(this.species, {super.key});
  // final List<int> formIDs;
  final Species species;

  @override
  createState() => FormsState();
}

class FormsState extends State<Forms> {
  //

  // Constants -----------------------------------------------------------------

  static const duration = Duration(milliseconds: 150);
  static const curve = Curves.linear;

  static const scrollOn = ScrollPhysics();
  static const scrollOff = NeverScrollableScrollPhysics();

  // Shiny Form Toggle ---------------------------------------------------------

  bool isShiny = false;
  void toggleShiny() => setState(() => isShiny = !isShiny);

  // PageView Elements & Controllers -------------------------------------------

  late int index = 0;
  late int count = 0;
  late bool hasForms = false;

  late Pokemon form = Pokemon.filler();
  late List<Pokemon> forms = [];
  late final PageController controller;

  // State Update & Reset Methods ----------------------------------------------

  void update() {
    final List<int> formIDs = widget.species.varieties;

    setState(() {
      forms = formIDs.map((i) => context.db.getPokemon(i)).toList();
      count = forms.length;
      hasForms = count > 1;
      index = count * 99;
      form = forms[0];
    });
  }

  @override
  void initState() {
    super.initState();
    update();
    controller = PageController(initialPage: index);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Forms oldWidget) {
    super.didUpdateWidget(oldWidget);
    update();
    controller.jumpToPage(index);
  }

  // PageView Manipulation -----------------------------------------------------

  void changeForm(int i) {
    setState(() => index = i);
    context.db.changeForm(i);
    form = forms[index % count];
  }

  void nextForm() => stepForm(1);
  void prevForm() => stepForm(-1);

  void stepForm(int i) {
    if (hasForms) {
      i += index;
      changeForm(i);
      controller.animateToPage(
        i,
        curve: curve,
        duration: duration,
      );
    }
  }

  @override
  Widget build(context) {
    //

    final Species species = widget.species;
    final name = form.name.form(species.name);

    final buttons = PageButtons(
      shaded: false,
      hidden: !hasForms,
      prev: prevForm,
      next: nextForm,
    );

    return LayoutBuilder(builder: (context, constraints) {
      final double width = constraints.maxWidth;
      final double padH = width * 0.15;

      final pageView = PageView.builder(
        physics: hasForms ? scrollOn : scrollOff,
        dragStartBehavior: DragStartBehavior.start,
        onPageChanged: changeForm,
        controller: controller,
        itemBuilder: (_, i) {
          final Pokemon pkmn = forms[i % count];
          return GestureDetector(
            onTap: toggleShiny,
            child: PKMNSprite(pkmn, isShiny),
          );
        },
      );

      return Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            //

            TypeGradient(form.type1, form.type2),

            Column(
              children: [
                const Spacer(flex: 2),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: padH),
                      child: pageView,
                    )),
                Expanded(flex: 1, child: Text(name)),
                const Spacer(flex: 1),
              ],
            ),

            buttons,

            //
          ],
        ),
      );

      //
    });

    //
  }
}
