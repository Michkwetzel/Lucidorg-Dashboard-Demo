import 'package:flutter/material.dart';

// Results Section Styles Poppins

const kH1PoppinsLight = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w600,
  fontSize: 32,
  color: Color(0xFF494949),
);
const kH1PoppingRegular = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w600,
  fontSize: 32,
  color: Color(0xFF494949),
);
const kH1PoppinsMedium = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w600,
  fontSize: 32,
  color: Color(0xFF494949),
);

const kH2PoppinsLight = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w300,
  fontSize: 27,
);
const kH2PoppinsRegular = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  fontSize: 27,
);
const kH2PoppinsMedium = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 27,
);

const kH3PoppinsLight = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w300,
  fontSize: 24,
);
const kH3PoppinsRegular = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  fontSize: 24,
);
const kH3PoppinsMedium = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 24,
);

const kH4PoppinsLight = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w300,
  fontSize: 20,
);
const kH4PoppinsRegular = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  fontSize: 20,
);
const kH4PoppinsMedium = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 20,
);

const kH5PoppinsLight = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w300,
  fontSize: 18,
);
const kH5PoppinsRegular = TextStyle(
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.w400,
  fontSize: 18,
);
const kH5PoppinsMedium = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 18,
);

const kH6PoppinsLight = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w300,
  fontSize: 14,
);
const kH6PoppinsRegular = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  fontSize: 14,
);
const kH6PoppinsMedium = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 14,
);

// ****************************************** Total Score***************************************
const kH1TotalScoreLight = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 27, color: Color(0xFF5478ED));
const kH1TotalScoreRegular = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 27, color: Color(0xFF5478ED));
const kH3TotalScoreLight = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 24, color: Color(0xFF5478ED));
const kH3TotalScoreRegular = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 24, color: Color(0xFF5478ED));
const kH2TotalScoreLight = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 15, color: Color(0xFF5478ED));
const kH2TotalScoreRegular = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xFF5478ED));

// ****************************************** Total diff***************************************

const kH1Diff = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 20, color: Color(0xFFF03535));
const kH2Diff = TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 15, color: Color(0xFFF03535));

// Button TextStyles
const kCallToActionButtonTextStyle = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: Colors.white,
);

const kPrimaryButtonTextStyle = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: Colors.white,
);

const kSecondaryButtonTextStyle = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: Colors.black,
);

const kSelectionButtonTexyStyle = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: Color.fromARGB(255, 0, 0, 0),
);

const kSidePanelButtonsTextStyle = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w400,
  fontSize: 18,
  color: Color.fromARGB(255, 0, 0, 0),
);

// Text Field TextStyles
const kTextFieldHeaderTextStyle = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: Color(0xFF323232),
);

const kErrorTextFieldTextStyle = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w400,
  fontSize: 12,
  color: Color.fromARGB(255, 213, 0, 0),
);

// Text Body Styles

const kH1TextStyle = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w600,
  fontSize: 32,
  color: Color(0xFF494949),
);

const kH2TextStyle = TextStyle(
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
  fontSize: 24,
  color: Color(0xFF323232),
);

const kH3TextStyle = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w400,
  fontSize: 18,
  color: Color(0xFF323232),
);

const kInfoTextTextStyle = TextStyle(
  fontFamily: "OpenSans",
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: Color(0xFF494949),
);

//Button dimensions
const double kButtonHeight = 40;
const double kSelectionButtonHeight = 80;

//Logo Scale
const double kLogoScale = 3.15;

// Google Function HTTP Paths
const String kVerifyAuthTokenPath = 'https://verifyauthtoken-rbyavkqn2a-uc.a.run.app';
// const String kVerifyAuthTokenPath = 'http://127.0.0.1:5001/efficiency-1st/us-central1/verifyAuthToken';

const String kCreateUserProfilePath = 'https://createuserprofile-rbyavkqn2a-uc.a.run.app';
// const String kCreateUserProfilePath = 'http://127.0.0.1:5001/efficiency-1st/us-central1/createUserProfile';

const String kCreateAssessmentPath = 'https://createassessment-rbyavkqn2a-uc.a.run.app';
// const String kCreateAssessmentPath =  'http://127.0.0.1:5001/efficiency-1st/us-central1/createAssessment';

// const String kCreateTokensPath = 'http://127.0.0.1:5001/efficiency-1st/us-central1/createTokens';

// ****************************************** Box Decorations ***************************************

BoxDecoration kboxShadowNormal = BoxDecoration(
  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
);

BoxDecoration kGrayBoxDecoration = BoxDecoration(
  color: Color(0xFFEBEBEB),
  borderRadius: BorderRadius.circular(6),
);
