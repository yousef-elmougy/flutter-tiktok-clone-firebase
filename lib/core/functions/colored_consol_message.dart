
import '../../lib_exports.dart';

void printColoredText({
  required String text,
  required ConsoleColor color,
}) {
  final colorCode = ColoredPrint.colorCodes[color];
  if (colorCode != null) {
    debugPrint('$colorCode$text${ColoredPrint.colorCodes[ConsoleColor.reset]}');
  } else {
    debugPrint(text);
  }
}

enum ConsoleColor {
  reset,
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  brightBlack,
  brightRed,
  brightGreen,
  brightYellow,
  brightBlue,
  brightMagenta,
  brightCyan,
  brightWhite,
  blackBg,
  redBg,
  greenBg,
  yellowBg,
  blueBg,
  magentaBg,
  cyanBg,
  whiteBg,
  brightBlackBg,
  brightRedBg,
  brightGreenBg,
  brightYellowBg,
  brightBlueBg,
  brightMagentaBg,
  brightCyanBg,
  brightWhiteBg,
}

class ColoredPrint {


  static const Map<ConsoleColor, String> colorCodes = {
    ConsoleColor.reset: '\u001b[0m',
    ConsoleColor.black: '\u001b[30m',
    ConsoleColor.red: '\u001b[31m',
    ConsoleColor.green: '\u001b[32m',
    ConsoleColor.yellow: '\u001b[33m',
    ConsoleColor.blue: '\u001b[34m',
    ConsoleColor.magenta: '\u001b[35m',
    ConsoleColor.cyan: '\u001b[36m',
    ConsoleColor.white: '\u001b[37m',
    ConsoleColor.brightBlack: '\u001b[90m',
    ConsoleColor.brightRed: '\u001b[91m',
    ConsoleColor.brightGreen: '\u001b[92m',
    ConsoleColor.brightYellow: '\u001b[93m',
    ConsoleColor.brightBlue: '\u001b[94m',
    ConsoleColor.brightMagenta: '\u001b[95m',
    ConsoleColor.brightCyan: '\u001b[96m',
    ConsoleColor.brightWhite: '\u001b[97m',
    ConsoleColor.blackBg: '\u001b[40m',
    ConsoleColor.redBg: '\u001b[41m',
    ConsoleColor.greenBg: '\u001b[42m',
    ConsoleColor.yellowBg: '\u001b[43m',
    ConsoleColor.blueBg: '\u001b[44m',
    ConsoleColor.magentaBg: '\u001b[45m',
    ConsoleColor.cyanBg: '\u001b[46m',
    ConsoleColor.whiteBg: '\u001b[47m',
    ConsoleColor.brightBlackBg: '\u001b[100m',
    ConsoleColor.brightRedBg: '\u001b[101m',
    ConsoleColor.brightGreenBg: '\u001b[102m',
    ConsoleColor.brightYellowBg: '\u001b[103m',
    ConsoleColor.brightBlueBg: '\u001b[104m',
    ConsoleColor.brightMagentaBg: '\u001b[105m',
    ConsoleColor.brightCyanBg: '\u001b[106m',
    ConsoleColor.brightWhiteBg: '\u001b[107m',
  };
}
