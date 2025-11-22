part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {}

class SettingUrlSaved extends SettingState {}

class SettingError extends SettingState {
  final String error;
  SettingError(this.error);
}

// //Printers states

class PrinterScanning extends SettingState {}

class PrinterScanSuccess extends SettingState {
  final List<BluetoothInfo> devices;
  PrinterScanSuccess(this.devices);
}

class PrinterError extends SettingState {
  final String message;
  PrinterError(this.message);
}

class PrinterDeviceSelected extends SettingState {
  final BluetoothInfo device;
  PrinterDeviceSelected(this.device);
}

class PrinterConnected extends SettingState {
  final String? mac, name;

  PrinterConnected({required this.mac, required this.name});
}

class PrinterConnecting extends SettingState {}

class PrinterDisconnected extends SettingState {}

class PrinterPrinting extends SettingState {}

class PrinterPrintSuccess extends SettingState {}
