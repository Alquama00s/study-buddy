import 'package:flutter/material.dart';
import 'package:study_buddy/models/formula.dart';

class FormMain extends StatelessWidget {
  FormMain({Key? key}) : super(key: key);
  /*final List<Formula> list = [
    Formula(r'\( a \ne 0 \)'),
    Formula(
      r"""\( a \ne 0 \)<br/>
    ${b^2 + C^2}
    """,
      lineno: 2,
    ),
    Formula(r'\( a \ne 0 \)'),
    Formula(r'\( a \ne 0 \)'),
    Formula(r'\( a \ne 0 \)'),
    Formula(r'\( a \ne 0 \)'),
    Formula(r'\( a \ne 0 \)'),
    Formula(r'\( a \ne 0 \)'),
  ];*/
  static List<String> lists = [
    r'\( a \ne 0 \)',
    r'\( a \ne 0 \)',
    r'\( a \ne 0 \)',
    r'\( a \ne 0 \)',
    r'\( a \ne 0 \)',
    r'\( a \ne 0 \)',
    r'\( a \ne 0 \)',
    r'\( a \ne 0 \)',
    r"""<p>                                
                       When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                       $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""",
  ];
  FormulaPage page = FormulaPage(lists /*+ lists + lists*/);
  @override
  Widget build(BuildContext context) {
    return page.render();
  }
}
