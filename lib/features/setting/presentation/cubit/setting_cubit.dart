import 'package:bloc/bloc.dart';
import 'package:easacc_task/core/constants/app_cached.dart';
import 'package:easacc_task/core/local/shared_preferences/shared_pref_services.dart';
import 'package:easacc_task/core/util/extensions/navigation.dart';
import 'package:easacc_task/core/util/routing/routes.dart';
import 'package:easacc_task/core/widgets/custom_toast.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

part 'setting_state.dart';

@injectable
class SettingCubit extends Cubit<SettingState> {
  final SharedPrefServices appPref;
  SettingCubit(this.appPref) : super(SettingInitial());

  final urlCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String getWebsiteURL() {
    String url = urlCtrl.text.trim();
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    return url;
  }

  Future<void> getSavedURL() async {
    final savedUrl = await appPref.getData(key: AppCached.url);
    if (savedUrl != null) {
      urlCtrl.text = savedUrl;
    }
  }

  Future<void> saveWebsiteURL() async {
    try {
      emit(SettingLoading());

      String url = getWebsiteURL();

      await appPref.saveData(AppCached.url, url);

      emit(SettingUrlSaved());
    } catch (e) {
      emit(SettingError(e.toString()));
    }
  }

  void openWebsite(BuildContext context) {
    context.pushWithNamed(Routes.webView, arguments: getWebsiteURL());
  }

  //Printers

  List<BluetoothInfo> devices = [];

  Future<bool> requestBluetoothPermission() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted &&
        await Permission.location.request().isGranted) {
      return true;
    }
    return false;
  }

  Future<void> scanPrinters() async {
    emit(PrinterScanning());
    try {
      bool granted = await requestBluetoothPermission();
      if (!granted) {
        emit(PrinterError("Bluetooth permission denied"));
        return;
      }

      devices = await PrintBluetoothThermal.pairedBluetooths;
      emit(PrinterScanSuccess(devices));
    } catch (e) {
      emit(PrinterError("Scan Error: $e"));
    }
  }

  String? selectedMac;
  String? selectedName;

  void selectDevice(BluetoothInfo device) {
    selectedMac = device.macAdress;
    selectedName = device.name;
    emit(PrinterDeviceSelected(device));
    print("Selected printer: ${device.name} - ${device.macAdress}");
  }

  Future<void> connectPrinter(String mac, {String? name}) async {
    emit(PrinterConnecting());
    try {
      bool connected = await PrintBluetoothThermal.connect(
        macPrinterAddress: mac,
      );
      if (connected) {
        selectedMac = mac;
        selectedName = name;
        emit(PrinterConnected(mac: mac, name: name));
        showToast(
          text: "Connected to printer: $name - $mac",
          state: ToastStates.success,
        );
        print("Connected to printer: $name - $mac");
      } else {
        emit(PrinterDisconnected());
        showToast(
          text: "Failed to connect to printer: $name - $mac",
          state: ToastStates.error,
        );
        print("Failed to connect to printer: $name - $mac");
      }
    } catch (e) {
      emit(PrinterError("Connection Error: $e"));
    }
  }

  Future<void> printReceipt() async {
    if (selectedMac == null) {
      emit(PrinterError("No printer connected"));
      return;
    }

    emit(PrinterPrinting());
    try {
      bool isConnected = await PrintBluetoothThermal.connectionStatus;
      if (!isConnected) {
        emit(PrinterDisconnected());
        return;
      }

      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);

      List<int> bytes = [];
      bytes += generator.reset();
      bytes += generator.text(
        'Sales Receipt',
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      );
      bytes += generator.hr();
      bytes += generator.text(
        'Customer: John Doe',
        styles: const PosStyles(align: PosAlign.left),
      );
      bytes += generator.text(
        'Invoice: #12345',
        styles: const PosStyles(align: PosAlign.left),
      );
      bytes += generator.text(
        'Amount: \$100.00',
        styles: const PosStyles(align: PosAlign.left),
      );
      bytes += generator.hr();
      bytes += generator.text(
        'Thank you for your purchase!',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );
      bytes += generator.feed(2);
      bytes += generator.cut();

      bool result = await PrintBluetoothThermal.writeBytes(bytes);

      if (result) {
        emit(PrinterPrintSuccess());
        showToast(text: "Printer Print Successful", state: ToastStates.success);
        print("Print Successful");
      } else {
        showToast(text: "Print Failed", state: ToastStates.error);
        emit(PrinterError("Print Failed"));
      }
    } catch (e) {
      emit(PrinterError("Printing Error: $e"));
    }
  }

  @override
  Future<void> close() {
    urlCtrl.dispose();
    return super.close();
  }
}
