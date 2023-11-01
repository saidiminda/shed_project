import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';
// ignore: unused_import
import 'package:hotel_booking/widgets/app_bar/appbar_image.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:hotel_booking/widgets/custom_outlined_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class WelcomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final bool _show = false;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  late final PersistentBottomSheetController controller;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Form(
              child: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 20, top: 5, right: 20, bottom: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: getPadding(top: 20),
                        ),
                        Center(
                          child: AppbarSubtitle(
                            text: 'Welcome To Emasuite App',
                            margin: getMargin(
                                left: 50, top: 2, right: 50, bottom: 100),
                            // translation(context).homePage
                          ),
                        ),
                        //  container at center
                        Container(
                          height: 300,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImageConstant.imgWelcomeBack),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: null,
                        ),
                        Center(
                          child: AppbarSubtitle1(
                            text: translation(context).desc1,
                          ),
                        ),

                        CustomOutlinedButton(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(
                                    getHorizontalSize(5.00)),
                                color: const Color(0xffC2892D)),
                            width: getHorizontalSize(165),
                            text: translation(context).register_here,
                            margin: getMargin(
                                left: 50, top: 38, right: 50, bottom: 30),
                            onTap: () {
                              onTapSave(context);
                            }),
                        Padding(
                          padding: getPadding(top: 20),
                        ),
                        Wrap(
                          children: [
                            Text(
                              translation(context).confimpolicy,
                              style: GoogleFonts.dosis(),
                            ),
                            InkWell(
                              child: Text("\n"+
                                translation(context).privacy,
                                style: GoogleFonts.dosis(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: const Color(0xffC2892D),
                                ),
                              ),
                              onTap: () {
                                _terms_conditions(context);
                              },
                            )
                          ],
                        ),
                      ])))),
    ));
  }

  onTapSave(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerPage);
  }

  onTapGetStart(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.dashboard);
  }

  // ignore: non_constant_identifier_names
  void _terms_conditions(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  iconTheme:
                      const IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
                  title: Center(
                    // translation(context).create_property
                    child: AppbarSubtitle(
                      text: 'Terms & Conditions',
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.close,
                        ))
                  ],
                ),
                body: SingleChildScrollView(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: const [
                    Padding(
                      key: Key('showMore'),
                      padding: EdgeInsets.all(16.0),
                      child: ReadMoreText(
                        """ By clicking “Get Started”, or by submitting your information on any  EMA electronic platform 
                        (portal, website, survey etc.), you agree to the terms and conditions of this Agreement and 
                        the  EMA Privacy Policy (“collectively referred to as “Terms”). Please note that this Agreement is 
                        subject to change without prior notice (unless prior notice is required by law). 
                        By completing this online questionnaire, you agree to be legally bound by these terms, 
                        which shall take effect immediately on your first use of this website. If you do not agree to be 
                        legally bound by all the terms, please do not access and/or use the website and/or complete the 
                        questionnaire.  EMA may change the terms at any time by posting changes online. Please review the 
                        terms regularly to ensure you are aware of any changes made by us.
                    You agree that  EMA may collect, process use and store [insert name of contracting entity’s] 
                    personal information (including special personal information) for purposes of:
                    (i) providing the services,
                    (ii) maintaining its internal administrative or client relationship management systems, 
                    including the use of third party IT outsourced providers,
                    (iii) quality and risk management reviews and legal reporting obligations,
                    (iv) providing information about its range of services,
                    (v) carrying out and managing its business operations,
                    (vi) providing professional advice, and
                    (vii) any legitimate business purposes or other activities conducted by  EMA from time to time.  
                    You undertake to keep the personal information up to date by keeping  EMA informed of any changes 
                    that need to be made to the personal information.
                    You warrant that the consent of any other data subject to whose personal information shall be
                     disclosed to  EMA by you in terms of this agreement has been obtained or that you are otherwise 
                     justified in law to disclose such information to  EMA . You further warrant and undertake to immediately 
                     inform  EMA :
                    (i) of any changes to the personal information provided by you in order to keep the data accurate,
                    (ii) should any data subject withdraw any consent previously given and/or
                    (iii) should  EMA for any other reason no longer be entitled to lawfully process the data subject’s 
                    personal information. You agree to hold  EMA and/or any and all of its directors, officers or any other
                     officials thereof respectively, harmless and indemnified against any and all loss, damage, costs 
                     (including legal costs on an attorney and client basis), charges, penalties, fines, interest, 
                     expenses which may be incurred or sustained by  EMA and/or any one or more of the aforesaid persons 
                     as a result of you breaching the aforementioned warranties or failing to comply with any of your 
                     obligations in terms of POPI or any other applicable data protection law or regulation.
                    You understand and agree that the personal information may in appropriate circumstances reside and be 
                    processed outside South Africa and you agree that a  EMA firm or entity acting on its behalf shall be 
                    entitled to transfer and process personal information across country borders to such locations outside 
                    South Africa and for the purposes set out above.
                    You agree that  EMA shall be entitled to retain the personal information for a minimum period of 5 years, 
                    after which, subject to what is set out below, the personal information shall be destroyed in accordance 
                    with the provisions of POPI, or any other applicable data protection law or regulation. You agree that  EMA shall however be entitled to extend the period for which personal information is retained:(i) If this is required or authorised by law,(ii)  EMA reasonably requires the information for a longer period for lawful purposes related to its activities or functions,(iii) this is required by any contract between the parties, or(iv) for statistical or research purposes (subject to appropriate safeguards).
                     EMA is not liable for any damages (including direct, indirect, consequential, incidental, and exemplary) in the event that this site is unavailable to users (by virtue of interruption, suspension, or termination) for any reason, including due to computer or communications link downtime attributable to malfunction, upgrades or preventative or remedial maintenance activities.
                     EMA will not be liable to users in respect of any loss or damage (including consequential loss or inconsequential loss) which may be suffered or incurred, or which may arise directly or indirectly because of services supplied by  EMA .
                    These terms and conditions are subject to warranties and liabilities that cannot by law be disclaimed and 
                     EMA ’s liability for any breach of a condition in relation to supply by it of services to users is 
                     limited to, at  EMA ’s option, supply of the services again, or the payment of the cost of supplying the 
                     services again.  EMA will not be liable for any loss caused by the failure to complete the questionnaire.
                    These terms and conditions are subject to change at the sole discretion of  EMA .
                    Users warrant that all information provided by them on the questionnaire is accurate and does not breach 
                    any law or the rights of any person.
                    You may not sell or modify the material or reproduce, display, distribute, or otherwise use the material 
                    available on this website in any way for any public or commercial purpose. You may not copy or adapt the 
                    code or software that  EMA creates to generate its pages.
                    You may not ‘frame’ or ‘mirror’ any materials or third-party content contained on or accessible from the 
                     EMA site on any other server or internet-based device without the express written authorization of  EMA .
                     EMA will not be liable for any damages (including direct, indirect, consequential, incidental, and 
                     exemplary), if there is any deficiency or inaccuracy in the site attributable to a lack of maintenance of 
                     the site or in relation to the accuracy, sufficiency or otherwise of your application.
                    All users warrant that they have not relied on any representation made by  EMA which has not 
                    been expressly stated in these terms and conditions or the engagement letter for the provision of 
                    specified services by  EMA . On lodging material, users indemnify  EMA and its officers, employees and 
                    agents against any claim, demand, injury, direct or indirect damage, loss or cost, liability, right of 
                    action or claim for compensation in contract, under statute or in tort (including negligence) made against
                     or suffered by any of those indemnified arising, in whole or in part, as a result of your application, 
                     or any activity that is expressed in these terms and conditions to be the responsibility of the user, 
                     or breach of these terms and conditions.
                     EMA does not monitor your data or transmissions, yet it does actively monitor accounts for system 
                     utilisation. Upon any breach of this agreement, or inappropriate use of  EMA services as determined by  
                     EMA in its sole discretion,  EMA reserves the right to terminate your registration.  EMA ’s preferred 
                     course of action is to advise you of your inappropriate use or breach of this agreement and recommend any 
                     necessary corrective action.
                    To enter the Prize Draw, respondents need to complete the full survey.
                    The prize draw (the “Apple iPad”) is open to anyone within the manufacturing and distribution industries. 
                    Employees or their family members may not enter the Prize Draw.
                     EMA accepts no responsibility for entries that are lost, delayed, misdirected or incomplete or cannot be 
                     delivered or entered for any technical or other reason.
                    One winner will be chosen from a random draw of entries received in accordance with these 
                    Terms and Conditions. The draw will be performed by a random computer process.
                   """,
                        trimLines: 20,
                        preDataText: "TERMS & CONDITIONS",
                        preDataTextStyle:
                            TextStyle(fontWeight: FontWeight.w500),
                        style: TextStyle(color: Colors.black),
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: '...Show more',
                        trimExpandedText: ' show less',
                      ),
                    ),
                  ]),
                )),
          );
        });
  }

  void _closeModal() {
    // ignore: unnecessary_null_comparison
    if (controller != null) {
      controller.close();
    }
  }
}
