import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateManager {
  static const String githubRepo = "kialambalarascol/maPremiereApp";

  static Future<void> checkForUpdate(BuildContext context) async {
    final info = await PackageInfo.fromPlatform();
    final currentVersion = info.version;

    // --- Récupération de la dernière release GitHub ---
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/$githubRepo/releases/latest'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final latestVersion = data['tag_name'].toString().replaceAll('v', '');
      final assets = data['assets'] as List;
      final apkAsset = assets.firstWhere(
          (a) => a['name'].toString().endsWith('.apk'),
          orElse: () => null);

      if (apkAsset == null) return;

      final apkUrl = apkAsset['browser_download_url'];

      if (latestVersion != currentVersion) {
        // --- Afficher le popup de mise à jour ---
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Mise à jour disponible 🚀"),
            content: Text(
              "Version actuelle : $currentVersion\n"
              "Nouvelle version : $latestVersion\n\n"
              "Souhaitez-vous télécharger et installer la nouvelle version ?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Plus tard"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _downloadAndInstall(apkUrl, context);
                },
                child: const Text("Mettre à jour"),
              ),
            ],
          ),
        );
      }
    }
  }

  static Future<void> _downloadAndInstall(
      String url, BuildContext context) async {
    // Vérifie la permission de stockage
    if (await Permission.storage.request().isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission refusée pour le téléchargement")),
      );
      return;
    }

    // Dossier de téléchargement
    final dir = await getExternalStorageDirectory();
    final path = "${dir!.path}/update.apk";

    // Supprime l'ancien fichier s’il existe
    final file = File(path);
    if (await file.exists()) await file.delete();

    // Téléchargement avec FlutterDownloader
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: dir.path,
      fileName: "update.apk",
      showNotification: true,
      openFileFromNotification: false,
    );

    FlutterDownloader.registerCallback((id, status, progress) async {
      if (id == taskId && status == DownloadTaskStatus.complete) {
        await InstallPlugin.installApk(path, "com.example.flutter_application_1");
      }
    });
  }
}
