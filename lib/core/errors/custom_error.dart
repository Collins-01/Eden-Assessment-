import 'package:eden_demo/core/errors/errors.dart';

class CustomError implements Failure {
  final String _msg;
  final String _title;
  CustomError(this._title, this._msg);
  @override
  String get message => _msg;

  @override
  String get title => _title;
}
