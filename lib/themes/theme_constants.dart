
import 'package:checking_system/themes/normal/app_dimens.dart' as normal_dimen;
import 'dark/app_colors.dart' as normal_color;
import 'dark/app_colors.dart' as dark_color show appColors;

enum AppTheme { normal, dark }

class ThemeConstants {
  static Map<String, dynamic> _config = _Config.normalConstants;
  static var currentAppTheme = AppTheme.normal;

  static void setAppTheme(AppTheme theme) {
    currentAppTheme = theme;
    switch (theme) {
      case AppTheme.normal:
        _config = _Config.normalConstants;
        break;
      case AppTheme.dark:
        _config = _Config.darkConstants;
        break;
    }
  }

  static get appColors {
    return _config[_Config.colors];
  }

  static get appDimens {
    return _config[_Config.dimens];
  }
}

class _Config {
  static const colors = "COLORS";
  static const dimens = "DIMENS";

  static Map<String, dynamic> normalConstants = {
    colors: normal_color.appColors,
    dimens: normal_dimen.appDimens,
  };
  static Map<String, dynamic> darkConstants = {
    colors: dark_color.appColors,
    dimens: normal_dimen.appDimens,
  };
}

class ColorConstants {
  static const turquoise900 = 'turquoise900';
  static const turquoise800 = 'turquoise800';
  static const turquoise700 = 'turquoise700';
  static const turquoise600 = 'turquoise600';
  static const turquoise500 = 'turquoise500';
  static const turquoise400 = 'turquoise400';
  static const turquoise300 = 'turquoise300';
  static const turquoise200 = 'turquoise200';
  static const turquoise100 = 'turquoise100';
  static const turquoise50 = 'turquoise50';
  static const red900 = 'red900';
  static const red800 = 'red800';
  static const red700 = 'red700';
  static const red600 = 'red600';
  static const red500 = 'red500';
  static const red400 = 'red400';
  static const red300 = 'red300';
  static const red200 = 'red200';
  static const red100 = 'red100';
  static const red50 = 'red50';
  static const background = 'background';
  static const orange900 = 'orange900';
  static const orange800 = 'orange800';
  static const orange700 = 'orange700';
  static const orange600 = 'orange600';
  static const orange500 = 'orange500';
  static const orange400 = 'orange400';
  static const orange300 = 'orange300';
  static const orange200 = 'orange200';
  static const orange100 = 'orange100';
  static const orange50 = 'orange50';
  static const yellow900 = 'yellow900';
  static const yellow800 = 'yellow800';
  static const yellow700 = 'yellow700';
  static const yellow600 = 'yellow600';
  static const yellow500 = 'yellow500';
  static const yellow400 = 'yellow400';
  static const yellow300 = 'yellow300';
  static const yellow200 = 'yellow200';
  static const yellow100 = 'yellow100';
  static const yellow50 = 'yellow50';
  static const green900 = 'green900';
  static const green800 = 'green800';
  static const green700 = 'green700';
  static const green600 = 'green600';
  static const green500 = 'green500';
  static const green400 = 'green400';
  static const green300 = 'green300';
  static const green200 = 'green200';
  static const green100 = 'green100';
  static const green50 = 'green50';
  static const blue900 = 'blue900';
  static const blue800 = 'blue800';
  static const blue700 = 'blue700';
  static const blue600 = 'blue600';
  static const blue500 = 'blue500';
  static const blue400 = 'blue400';
  static const blue300 = 'blue300';
  static const blue200 = 'blue200';
  static const blue100 = 'blue100';
  static const blue50 = 'blue50';
  static const gray900 = 'gray900';
  static const gray800 = 'gray800';
  static const gray700 = 'gray700';
  static const gray600 = 'gray600';
  static const gray500 = 'gray500';
  static const gray400 = 'gray400';
  static const gray300 = 'gray300';
  static const gray200 = 'gray200';
  static const gray100 = 'gray100';
  static const gray50 = 'gray50';
  static const gray25 = 'gray25';
  static const gray10 = 'gray10';
  static const white = 'white';
  static const purple900 = 'purple900';
  static const purple800 = 'purple800';
  static const purple700 = 'purple700';
  static const purple600 = 'purple600';
  static const purple500 = 'purple500';
  static const purple400 = 'purple400';
  static const purple300 = 'purple300';
  static const purple200 = 'purple200';
  static const purple100 = 'purple100';
  static const purple50 = 'purple50';
  static const neutral800 = 'neutral800';
  static const neutral50 = 'neutral50';
  static const rose50 = 'rose50';

  static const textHighlight = 'textHighlight';
  static const textHeading = 'textHeading';
  static const textSubHeading = 'textSubHeading';
  static const textBody = 'textBody';
  static const textDisable = 'textDisable';
  static const textInvert = 'textInvert';
  static const textSubInvert = 'textSubInvert';
  static const textError = 'textError';
  static const textWarning = 'textWarning';
  static const textSuccess = 'textSuccess';
  static const textInfo = 'textInfo';
  static const textHyperLinkNormal = 'textHyperLinkNormal';
  static const textHyperLinkHover = 'textHyperLinkHover';
  static const textHyperLinkPressed = 'textHyperLinkPressed';
  static const textHyperLinkVisited = 'textHyperLinkVisited';

  static const gradientRed = 'gradientRed';
  static const gradientBlue = 'gradientBlue';
  static const gradientOrange = 'gradientOrange';
  static const gradientYellow = 'gradientYellow';
  static const gradientGreen = 'gradientGreen';
  static const gradientPurple = 'gradientPurple';
  static const gradientGray = 'gradientGray';
  // New color
  static const primary1 = 'primary1';
  static const primary2 = 'primary2';
  static const primary3 = 'primary3';

  static const textBlack = 'textBlack';
  static const textWhite = 'textWhite';
  static const textBlue = 'textBlue';
  static const hintText = 'hintText';
  static const gray = 'gray';
  static const colorLine = 'colorLine';
  static const colorUnActive = 'colorUnActive';
  static const colorSeeMore = 'colorSeeMore';
  static const colorHint = 'colorHint';
  static const colorRed = 'colorRed';
  static const colorInactive = 'colorInactive';
  static const bgComment = 'bgComment';
  static const colorGreen = 'colorGreen';
  static const colorNewGray = 'colorNewGray';
}

class DimensConstants {
  static const heading1 = 'heading1'; //48sp
  static const heading2 = 'heading2'; //32sp
  static const heading3 = 'heading3'; //24sp
  static const heading4 = 'heading4'; //20sp
  static const heading45 = 'heading45'; //18sp
  static const heading5 = 'heading5'; //16sp
  static const body1 = 'body1'; //14sp
  static const body2 = 'body2'; //12sp
  static const body3 = 'body3'; //11sp

  // Height Header Content
  static const heightHeaderContent = 'heightHeaderContent'; //11sp
}
