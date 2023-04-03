

import 'components/banner_carousel.dart';
import 'components/section_first_presentation.dart';

class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      //mainAxisAlignment: MainAxisAlignment.,
      children: const <Widget>[
        SizedBox(height: 5.0),
        BannerCarousel(),
        //InputTextArea(labelText: "nom", hintText: "entrez votre messgae"),
        //InputDate(),
        /*Text(
              ":) Hello AFYA !!",
              style: TextStyle(fontSize: 30.0),
            ),*/
        SizedBox(height: 5.0),
        Expanded(child: FirstPresentation()),
      ],
    ));
  }
}
