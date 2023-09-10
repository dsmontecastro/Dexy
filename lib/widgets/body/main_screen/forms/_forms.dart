import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:pokedex/extensions/providers.dart';
import 'package:pokedex/widgets/_misc/page_buttons.dart';

import 'package:pokedex/database/models/pokemon.dart';
import 'package:pokedex/database/models/species.dart';

import 'gradience.dart';
import 'background.dart';
import 'stats.dart';
import 'sprite.dart';

class Forms extends StatefulWidget {
  const Forms(this.species, {super.key});
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

    final name = widget.species.name;

    final pageView = PageView.builder(
      physics: hasForms ? scrollOn : scrollOff,
      dragStartBehavior: DragStartBehavior.start,
      onPageChanged: changeForm,
      controller: controller,
      itemBuilder: (_, i) {
        final Pokemon pkmn = forms[i % count];
        return FormSprite(
          form: pkmn,
          species: name,
          shiny: isShiny,
          multi: hasForms,
          toggle: toggleShiny,
        );
      },
    );

    final buttons = PageButtons(
      hidden: !hasForms,
      prev: prevForm,
      next: nextForm,
      spaceH: 0.16,
      shaded: false,
    );

    return Stack(children: [
      const Background(),
      Row(
        children: [
          Expanded(flex: 55, child: FormStats(form)),
          Expanded(
            flex: 45,
            child: Stack(
              children: [
                TypeGradient(form.type1, form.type2),
                pageView,
                buttons,
              ],
            ),
          ),
        ],
      ),
    ]);

    //
  }
}
