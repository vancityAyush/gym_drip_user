// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:twsuser/apiService/AppConstant.dart';
import 'package:twsuser/apiService/apiResponse/ResponseReviewProfile.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';
import 'package:twsuser/screen/ViewAllCertificate.dart';
import 'package:twsuser/screen/viewlltransformation.dart';

class TrainerPreview extends StatefulWidget {
  @override
  _TrainerPreviewState createState() => _TrainerPreviewState();
}

class _TrainerPreviewState extends State<TrainerPreview> {
  Razorpay _razorpay;
  String statusCode = "0", packageId = "", subscribed, packageCharges;

  int selectedIndex;
  bool _isLoad = false;
  bool _isLoadPackage = false;

  void isSubscription() async {
    var status = await Provider.of<ApiManager>(context, listen: false)
        .isSubscriptionApi(context);
    setState(() {
      statusCode = status.errorCode.toString();
      if (status.errorCode == 1) {
        subscribed = status.data.isSubscribed.toString();
      }
    });

    /*status.then((value)async{
      // print("errorCode"+value.toString());
      // setState(() {
      //   statusCode = value['error_code'].toString();
        print(statusCode.toString()+"error");
        if(value['error_code'] == 1){
          subscribed = value['data']['is_subscribed'].toString();
        }
      // });
    });*/
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await Provider.of<ApiManager>(context, listen: false)
        .startSubscriptionApi(packageId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  void openCheckout() async {
    var number = await SharedPrefManager.getPrefrenceString(AppConstant.PHONE);
    var email = await SharedPrefManager.getPrefrenceString(AppConstant.EMAIL);
    var name = await SharedPrefManager.getPrefrenceString(AppConstant.NAME);
    var doubleR = double.parse(packageCharges);
    var rupees = doubleR * 100;

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': rupees,
      'name': name,
      'prefill': {'contact': number.toString(), 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  void initState() {
    isSubscription();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 5;
    double cardHeight = MediaQuery.of(context).size.height * 2.2;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Text(
          "TRAINERS PREVIEW",
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            future: Provider.of<ApiManager>(context).fetchTrainerProfileApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ResponseReviewProfile responseReviewProfile = snapshot.data;
                Data data = responseReviewProfile.data;
                return data.privacyStatus == "PUBLIC"
                    ? Column(
                        children: <Widget>[
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: data.image == null
                                    ? Image.asset(
                                        "assets/images/spalsh.jpg",
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        "http://fitnessapp.frantic.in/" +
                                            data.image,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                  bottom: 10,
                                  right: 0,
                                  left: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          data.name,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4),
                            child: Text(
                              data.bio == null ? "" : data.bio,
                              style: TextStyle(
                                  color: Color(0XFFA3A3A3),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          FutureBuilder(
                              future: Provider.of<ApiManager>(context)
                                  .fetchCertificateTrainerApi(data.clientKey),
                              builder: (context, snapnew) {
                                if (snapnew.hasData) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Certificate/Achievements",
                                            style: TextStyle(
                                                fontSize: 17 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                                color: Color(0XFF4E4E4E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          ViewAllCertificate(
                                                              data: data
                                                                  .clientKey)));
                                            },
                                            child: Text(
                                              "View All",
                                              style: TextStyle(
                                                  fontSize: 17 *
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                  color: Color(0XFF4E4E4E),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Color(0XFFBDBDBD),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: 200,
                                            height: 3,
                                            color: Colors.redAccent,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5.0,
                                            mainAxisSpacing: 5.0,
                                            childAspectRatio:
                                                cardWidth / cardHeight,
                                          ),
                                          itemCount: snapnew
                                                      .data['data'].length ==
                                                  1
                                              ? 1
                                              : snapnew.data['data'].length == 2
                                                  ? 2
                                                  : 2,
                                          itemBuilder: (context, index) {
                                            print("length" +
                                                snapnew.data['data'].length
                                                    .toString());
                                            return Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: snapnew.data['data']
                                                                  [index]
                                                              ['image'] ==
                                                          null
                                                      ? Image.asset(
                                                          "assets/images/spalsh.jpg",
                                                          height: 140,
                                                          width:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .width,
                                                          fit: BoxFit.cover)
                                                      : Image.network(
                                                          "http://fitnessapp.frantic.in/" +
                                                              snapnew.data['data']
                                                                      [index]
                                                                  ['image'],
                                                          height: 140,
                                                          width:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .width,
                                                          fit: BoxFit.cover),
                                                ),
                                                /*else if(snapnew.data['data'].length == 2)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: snapnew.data['data'][1]['image'] == null ? Image.asset("assets/images/spalsh.jpg",height: 140,width:MediaQuery.of(context).size.width,fit: BoxFit.cover):Image.network("http://fitnessapp.frantic.in/"+snapnew.data['data'][1]['image'],height: 140,width:MediaQuery.of(context).size.width,fit: BoxFit.cover),),*/

                                                Positioned(
                                                    bottom: 10,
                                                    left: 10,
                                                    child: Icon(
                                                      Icons.addchart_rounded,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            );
                                          }),
                                    ],
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                          FutureBuilder(
                              future: Provider.of<ApiManager>(context)
                                  .fetchTransFormationApi(data.clientKey),
                              builder: (context, snapnew) {
                                if (snapnew.hasData) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Transformation Pictures",
                                              style: TextStyle(
                                                  fontSize: 17 *
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                  color: Color(0XFF4E4E4E),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          ViewAllTransformation(
                                                              data: data
                                                                  .clientKey)));
                                            },
                                            child: Text(
                                              "View All",
                                              style: TextStyle(
                                                  fontSize: 17 *
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                  color: Color(0XFF4E4E4E),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Color(0XFFBDBDBD),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: 200,
                                            height: 3,
                                            color: Colors.redAccent,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5.0,
                                            mainAxisSpacing: 5.0,
                                            childAspectRatio:
                                                cardWidth / cardHeight,
                                          ),
                                          itemCount: snapnew
                                                      .data['data'].length ==
                                                  1
                                              ? 1
                                              : snapnew.data['data'].length == 2
                                                  ? 2
                                                  : 2,
                                          itemBuilder: (context, index) {
                                            print("length" +
                                                snapnew.data['data'].length
                                                    .toString());
                                            return Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: snapnew.data['data']
                                                                  [index]
                                                              ['image'] ==
                                                          null
                                                      ? Image.asset(
                                                          "assets/images/spalsh.jpg",
                                                          height: 140,
                                                          width:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .width,
                                                          fit: BoxFit.cover)
                                                      : Image.network(
                                                          "http://fitnessapp.frantic.in/" +
                                                              snapnew.data['data']
                                                                      [index]
                                                                  ['image'],
                                                          height: 140,
                                                          width:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .width,
                                                          fit: BoxFit.cover),
                                                ),
                                                /*else if(snapnew.data['data'].length == 2)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: snapnew.data['data'][1]['image'] == null ? Image.asset("assets/images/spalsh.jpg",height: 140,width:MediaQuery.of(context).size.width,fit: BoxFit.cover):Image.network("http://fitnessapp.frantic.in/"+snapnew.data['data'][1]['image'],height: 140,width:MediaQuery.of(context).size.width,fit: BoxFit.cover),),*/

                                                Positioned(
                                                    bottom: 10,
                                                    left: 10,
                                                    child: Icon(
                                                      Icons.addchart_rounded,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            );
                                          }),
                                    ],
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                          FutureBuilder(
                              future: Provider.of<ApiManager>(context)
                                  .fetchMemberTrainerApi(data.clientKey),
                              builder: (context, snapMember) {
                                if (snapMember.hasData) {
                                  return Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Team Members",
                                          style: TextStyle(
                                              fontSize: 17 *
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              color: Color(0XFF4E4E4E),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Color(0XFFBDBDBD),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: 80,
                                            height: 3,
                                            color: Colors.redAccent,
                                          )
                                        ],
                                      ),
                                      ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              snapMember.data['data'].length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/spalsh.jpg",
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                          Text(
                                                            "Member Name:",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0XFF959798),
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      )),
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/spalsh.jpg",
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                          Text(
                                                            "Member Experienced:",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0XFF959798),
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 30),
                                                            child: Text(
                                                              snapMember.data[
                                                                          'data']
                                                                      [index]
                                                                  ['name'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF262626),
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 30),
                                                            child: Text(
                                                              snapMember.data['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'experience'] +
                                                                  " Year",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF262626),
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/spalsh.jpg",
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                          Text(
                                                            "Member Designation:",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0XFF959798),
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 30),
                                                            child: Text(
                                                              snapMember.data[
                                                                          'data']
                                                                      [index][
                                                                  'designation'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF262626),
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0),
                                                    child: Divider(),
                                                  )),
                                    ],
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                          if (statusCode == "0")
                            FutureBuilder(
                                future: Provider.of<ApiManager>(context)
                                    .fetchMembershipPackageTrainerApi(
                                        data.clientKey),
                                builder: (context, snapPackage) {
                                  if (snapPackage.hasData) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Package",
                                            style: TextStyle(
                                                fontSize: 17 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                                color: Color(0XFF4E4E4E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              height: 1,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Color(0XFFBDBDBD),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              width: 80,
                                              height: 3,
                                              color: Colors.redAccent,
                                            )
                                          ],
                                        ),
                                        ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                snapPackage.data['data'].length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 31.0),
                                                  child: ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedIndex = index;
                                                        packageId = snapPackage
                                                            .data['data'][index]
                                                                ['id']
                                                            .toString();
                                                        packageCharges =
                                                            snapPackage.data[
                                                                        'data']
                                                                    [index]
                                                                ['price'];
                                                      });
                                                    },
                                                    leading: Container(
                                                      width: 22,
                                                      height: 22,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(11),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 3),
                                                        color: selectedIndex ==
                                                                index
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 9),
                                                    title: Text(
                                                      snapPackage.data['data']
                                                          [index]['plan'],
                                                      style: TextStyle(
                                                          fontSize: 14 *
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaleFactor,
                                                          color:
                                                              Color(0XFF4E4E4E),
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    trailing: Text(
                                                      snapPackage.data['data']
                                                              [index]['price'] +
                                                          "/-",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                              0XFF2CB3BF)),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0),
                                                      child: Divider(),
                                                    )),
                                      ],
                                    );
                                  } else {
                                    return Text("");
                                  }
                                }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (statusCode == "0")
                                if (_isLoad)
                                  CircularProgressIndicator()
                                else
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          _isLoad = true;
                                        });
                                        await Provider.of<ApiManager>(context,
                                                listen: false)
                                            .startSevenDaysTrial();
                                        setState(() {
                                          _isLoad = false;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 35),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Text(
                                          "Get 7 days trial",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                              if (statusCode == "0")
                                if (_isLoadPackage)
                                  CircularProgressIndicator()
                                else
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (packageId == "") {
                                          Fluttertoast.showToast(
                                              msg: "Please select package");
                                        } else {
                                          setState(() {
                                            _isLoadPackage = true;
                                          });
                                          print("dskjsdjkjkdsjk");
                                          openCheckout();

                                          setState(() {
                                            _isLoadPackage = false;
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 35),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Text(
                                          "Get Subscription",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: data.image == null
                                    ? Image.asset("assets/images/user.png",
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 170)
                                    : Image.network(
                                        "http://fitnessapp.frantic.in/" +
                                            data.image,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                  bottom: 10,
                                  right: 0,
                                  left: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            // CircleAvatar(
                                            //   radius: 20,
                                            //   backgroundColor: Colors.white,
                                            // ),

                                            SizedBox(
                                              width: 7,
                                            ),

                                            Text(
                                              data.name,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            data.bio == null ? "" : data.bio,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          FutureBuilder(
                              future: Provider.of<ApiManager>(context)
                                  .fetchCertificateTrainerApi(data.clientKey),
                              builder: (context, snapnew) {
                                if (snapnew.hasData) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Certificate/Achievements",
                                            style: TextStyle(
                                                fontSize: 17 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                                color: Color(0XFF4E4E4E),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          ViewAllCertificate(
                                                              data: data
                                                                  .clientKey)));
                                            },
                                            child: Text(
                                              "View All",
                                              style: TextStyle(
                                                  fontSize: 17 *
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                  color: Color(0XFF4E4E4E),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Color(0XFFBDBDBD),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: 200,
                                            height: 3,
                                            color: Colors.redAccent,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5.0,
                                            mainAxisSpacing: 5.0,
                                            childAspectRatio:
                                                cardWidth / cardHeight,
                                          ),
                                          itemCount: snapnew
                                                      .data['data'].length ==
                                                  1
                                              ? 1
                                              : snapnew.data['data'].length == 2
                                                  ? 2
                                                  : 2,
                                          itemBuilder: (context, index) {
                                            print("length" +
                                                snapnew.data['data'].length
                                                    .toString());
                                            return Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: snapnew.data['data']
                                                                  [index]
                                                              ['image'] ==
                                                          null
                                                      ? Image.asset(
                                                          "assets/images/spalsh.jpg",
                                                          height: 140,
                                                          width:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .width,
                                                          fit: BoxFit.cover)
                                                      : Image.network(
                                                          "http://fitnessapp.frantic.in/" +
                                                              snapnew.data['data']
                                                                      [index]
                                                                  ['image'],
                                                          height: 140,
                                                          width:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .width,
                                                          fit: BoxFit.cover),
                                                ),
                                                /*else if(snapnew.data['data'].length == 2)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: snapnew.data['data'][1]['image'] == null ? Image.asset("assets/images/spalsh.jpg",height: 140,width:MediaQuery.of(context).size.width,fit: BoxFit.cover):Image.network("http://fitnessapp.frantic.in/"+snapnew.data['data'][1]['image'],height: 140,width:MediaQuery.of(context).size.width,fit: BoxFit.cover),),*/

                                                Positioned(
                                                    bottom: 10,
                                                    left: 10,
                                                    child: Icon(
                                                      Icons.addchart_rounded,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            );
                                          }),
                                    ],
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                          SizedBox(
                            height: 25,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Transportation Pictures",
                              style: TextStyle(
                                  fontSize: 17 *
                                      MediaQuery.of(context).textScaleFactor,
                                  color: Color(0XFF4E4E4E),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                color: Color(0XFFBDBDBD),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 200,
                                height: 3,
                                color: Colors.redAccent,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.asset(
                                          "assets/images/spalsh.jpg",
                                          height: 140,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Icon(
                                          Icons.addchart_rounded,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.asset(
                                        "assets/images/spalsh.jpg",
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 140,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Icon(
                                          Icons.addchart_rounded,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                              future: Provider.of<ApiManager>(context)
                                  .fetchMemberTrainerApi(data.clientKey),
                              builder: (context, snapMember) {
                                if (snapMember.hasData) {
                                  return Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Team Members",
                                          style: TextStyle(
                                              fontSize: 17 *
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              color: Color(0XFF4E4E4E),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Color(0XFFBDBDBD),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: 80,
                                            height: 3,
                                            color: Colors.redAccent,
                                          )
                                        ],
                                      ),
                                      ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              snapMember.data['data'].length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/spalsh.jpg",
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                          Text(
                                                            "Member Name:",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0XFF959798),
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      )),
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/spalsh.jpg",
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                          Text(
                                                            "Member Experienced:",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0XFF959798),
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 30),
                                                            child: Text(
                                                              snapMember.data[
                                                                          'data']
                                                                      [index]
                                                                  ['name'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF262626),
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 30),
                                                            child: Text(
                                                              snapMember.data['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'experience'] +
                                                                  " Year",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF262626),
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/spalsh.jpg",
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                          Text(
                                                            "Member Designation:",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0XFF959798),
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 30),
                                                            child: Text(
                                                              snapMember.data[
                                                                          'data']
                                                                      [index][
                                                                  'designation'],
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF262626),
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0),
                                                    child: Divider(),
                                                  )),
                                    ],
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                          if (statusCode == "1")
                            if (subscribed == "NO")
                              FutureBuilder(
                                  future: Provider.of<ApiManager>(context)
                                      .fetchMembershipPackageTrainerApi(
                                          data.clientKey),
                                  builder: (context, snapPackage) {
                                    if (snapPackage.hasData) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Package",
                                              style: TextStyle(
                                                  fontSize: 17 *
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                  color: Color(0XFF4E4E4E),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                height: 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: Color(0XFFBDBDBD),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                width: 80,
                                                height: 3,
                                                color: Colors.redAccent,
                                              )
                                            ],
                                          ),
                                          ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: snapPackage
                                                  .data['data'].length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        31.0),
                                                            child: ListTile(
                                                              leading:
                                                                  Container(
                                                                width: 30,
                                                                child: Radio(
                                                                  value: "",
                                                                ),
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              9),
                                                              title: Text(
                                                                snapPackage.data[
                                                                            'data']
                                                                        [index]
                                                                    ['plan'],
                                                                style: TextStyle(
                                                                    fontSize: 14 *
                                                                        MediaQuery.of(context)
                                                                            .textScaleFactor,
                                                                    color: Color(
                                                                        0XFF4E4E4E),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                              trailing: Text(
                                                                snapPackage.data['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'price'] +
                                                                    "/-",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0XFF2CB3BF)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                              separatorBuilder: (BuildContext
                                                          context,
                                                      int index) =>
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0),
                                                    child: Divider(),
                                                  )),
                                        ],
                                      );
                                    } else {
                                      return Text("");
                                    }
                                  }),
                          SizedBox(
                            height: 10,
                          ),
                          if (statusCode == "1")
                            if (subscribed == "NO")
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (packageId == "") {
                                      Fluttertoast.showToast(
                                          msg: "Please select package");
                                    } else {
                                      setState(() {
                                        _isLoadPackage = true;
                                      });
                                      await Provider.of<ApiManager>(context,
                                              listen: false)
                                          .startSubscriptionApi(packageId);
                                      setState(() {
                                        _isLoadPackage = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 35),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      "Get Subscription",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      );
              } else {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(child: Text("No Trainer Preview available")));
              }
            },
          ),
        ),
      ),
    );
  }
}
