// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, unused_element, non_constant_identifier_names, empty_catches

library packagex;

import 'dart:convert';
import "package:universal_io/io.dart";

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:path/path.dart' as p;
import "package:msix/msix.dart" as msix;
import "extension/directory.dart";
import "scheme/scheme.dart" as packagex_scheme;
import "package:yaml/yaml.dart" as yaml;
import "shell/shell.dart" as packagex_shell;

enum PackagexPlatform {
  current,
  android,
  ios,
  linux,
  macos,
  windows,
}

class PackageBuild {
  PackageBuild();

  Future create({
    required String name,
    String maintaner = "-",
    required String package,
    bool isForce = true,
    double version = 0.0,
    String architecture = "amd64",
    String essential = "no",
    String description = "A new Flutter project.",
    String homepage = "https://youtube.com/@azkadev",
  }) async {
    String package_name = "";
    if (package != ".") {
      package_name = package;
    } else {
      package_name = p.basename(Directory.current.path);
    }

    package_name = package_name.replaceAll(
        RegExp(
          r"([_])",
        ),
        "-");

    String scripts = """
Maintainer: "${maintaner}"
Package: ${package_name}
Version: ${version}
Priority: optional
Architecture: amd64
Essential: no
Description: "${description}"
Homepage: "${homepage}"
""";
    String app_desktop_linux = """
[Desktop Entry]
Type=Application
Version=0.0.0
Name=${package_name}
GenericName=General Application
Exec=${package_name} %U
Categories=Music;Media;
Keywords=Hello;World;Test;Application;
StartupNotify=true
""";
    Directory directory = Directory(p.join(Directory.current.path, name));
    Future<void> createFolders({
      required Directory directory,
      required List<List<String>> folders,
    }) async {
      // List<List<String>> folders = [
      //   ["DEBIAN"],
      //   ["usr", "lib"],
      //   ["usr", "local"],
      //   ["usr", "local", "bin"],
      //   ["usr", "local", "lib"],
      //   ["usr", "local", "share", package],
      // ];
      await directory.autoCreate();
      for (var i = 0; i < folders.length; i++) {
        List<String> res = folders[i];
        Directory dir = Directory(p.joinAll([directory.path, ...res]));
        await dir.autoCreate();
      }
      if (Platform.isLinux) {
        try {
          await File(p.join(directory.path, "DEBIAN", "control")).writeAsString(scripts);
        } catch (e) {}
        try {
          await File(p.join(directory.path, "usr", "local", "share", "applications", "${package_name}.desktop")).writeAsString(app_desktop_linux);
        } catch (e) {}
      }
      return;
    }

    Process shell = await Process.start(
      "dart",
      ["create", name, "--force", "--no-pub"],
    );
    // await stdout.addStream(shell.stdout);
    // await stderr.addStream(shell.stderr);
    shell.stdout.listen(
      (event) {
        stdout.write(utf8.decode(event));
      },
      onDone: () {
        shell.kill();
      },
      cancelOnError: true,
    );
    shell.stderr.listen(
      (event) {
        stderr.write(utf8.decode(event));
      },
      onDone: () {
        shell.kill();
      },
      cancelOnError: true,
    );
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    await createFolders(
      directory: Directory(p.join(directory.path, "android", "packaging")),
      folders: [],
    );
    await createFolders(
      directory: Directory(p.join(directory.path, "ios", "packaging")),
      folders: [],
    );

    await createFolders(
      directory: Directory(p.join(directory.path, "linux", "packaging")),
      folders: [
        ["DEBIAN"],
        ["usr", "lib"],
        ["usr", "local"],
        ["usr", "local", "bin"],
        ["usr", "local", "lib"],
        ["usr", "local", "share", "applications"],
        ["usr", "local", "share", package],
      ],
    );
    await createFolders(
      directory: Directory(p.join(directory.path, "macos", "packaging")),
      folders: [],
    );
    await createFolders(
      directory: Directory(p.join(directory.path, "windows", "packaging")),
      folders: [],
    );

    return;
  }

  Future<void> build({
    required String path,
    String? output,
    PackagexPlatform? packagexPlatform,
  }) async {
    packagexPlatform ??= PackagexPlatform.current;

    if (packagexPlatform == PackagexPlatform.current) {
      if (Platform.isLinux) {
        packagexPlatform = PackagexPlatform.linux;
      }
      if (Platform.isMacOS) {
        packagexPlatform = PackagexPlatform.macos;
      }
      if (Platform.isWindows) {
        packagexPlatform = PackagexPlatform.windows;
      }
    }
    String basename = p.basename(path);
    Directory directory_current = Directory.current;
    File file = File(p.join(directory_current.path, "pubspec.yaml"));
    Map yaml_code = (yaml.loadYaml(file.readAsStringSync(), recover: true) as Map);
    packagex_scheme.Pubspec pubspec = packagex_scheme.Pubspec(yaml_code);
    if (pubspec["name"] == null) {
      pubspec["name"] = basename;
    }
    File script_cli = File(p.join(directory_current.path, "bin", "${pubspec.name}.dart"));
    File script_app = File(p.join(directory_current.path, "lib", "main.dart"));
    bool is_app = false;
    bool is_cli = false;

    if (script_app.existsSync()) {
      is_app = true;
    }
    if (script_cli.existsSync()) {
      is_cli = true;
    }
    Directory directory = Directory(p.join(directory_current.path, "build", "packagex"));
    await directory.autoCreate();

    if (packagexPlatform == PackagexPlatform.linux) {
      output ??= p.join(directory.path, "${pubspec.name}-linux.deb");
      String path_linux_package = p.join(
        path,
        "linux",
        "packaging",
      );
      if (is_app) {
        await packagex_shell.shell(
          executable: "flutter",
          arguments: [
            "build",
            "linux",
            "--release",
          ],
          workingDirectory: directory_current.path,
        );
        String path_app = p.join(directory_current.path, "build", "linux", "x64", "release", "bundle");
        await packagex_shell.shell(
          executable: "cp",
          arguments: [
            "-rf",
            path_app,
            p.join(
              path_linux_package,
              "usr",
              "local",
              "share",
              pubspec.name!.replaceAll(RegExp(r"([_])"), "-"),
            ),
          ],
          workingDirectory: directory_current.path,
        );
        await packagex_shell.shell(
          executable: "dpkg-deb",
          arguments: [
            "--build",
            "--root-owner-group",
            path_linux_package,
            p.join(directory.path, "${pubspec.name}-app-linux.deb"),
          ],
          workingDirectory: directory_current.path,
        );
      }
      if (is_cli) {
        await packagex_shell.shell(
          executable: "dart",
          arguments: [
            "compile",
            "exe",
            script_cli.path,
            "-o",
            p.join(
              path_linux_package,
              "usr",
              "local",
              "bin",
              pubspec.name!.replaceAll(RegExp(r"([_])"), "-"),
            ),
          ],
          workingDirectory: directory_current.path,
        );

        await packagex_shell.shell(
          executable: "dpkg-deb",
          arguments: [
            "--build",
            "--root-owner-group",
            path_linux_package,
            p.join(directory.path, "${pubspec.name}-cli-linux.deb"),
          ],
          workingDirectory: directory_current.path,
        );
      }
    } else if (packagexPlatform == PackagexPlatform.windows) {
      await msix.Msix().createMsix([]);
    }
    return;
  }
}

class PackageX {
  PackageX();

  build() {}

  Future<void> installPackageFromUrl({
    required String url,
    FetchOption? options,
    Encoding? encoding,
    required void Function(String data) onData,
    required void Function() onDone,
  }) async {
    Response response = await fetch(
      url,
      options: options,
      encoding: encoding,
    );
    Directory directory = Directory(p.join(Directory.current.path, "package_temp"));
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    File file = File(p.join(directory.path, p.basename(url)));
    if (file.existsSync()) {
      await file.delete();
    }
    await file.writeAsBytes(response.bodyBytes);
    await installPackageFromFile(file: file, onData: onData, onDone: onDone);
  }

  Future<void> installPackage({
    required String name_package,
  }) async {
    String result_url_package = "";
  }

  Future<void> searchPackage({
    required String name_package,
  }) async {
    String result_url_package = "";
  }

  Future<void> listPackageByPublisher({
    required String username,
  }) async {
    String result_url_package = "";
  }

  Future<void> publishPackage({
    required String username,
  }) async {
    String result_url_package = "";
  }

  Future<Process> installPackageFromFile({
    required File file,
    required void Function(String data) onData,
    required void Function() onDone,
  }) async {
    Process shell = await Process.start(
      "dpkg",
      [
        "--force-all",
        "-i",
        file.path,
      ],
    );
    shell.stdout.listen(
      (event) {
        String data = utf8.decode(event);
        stdout.write(data);
        onData.call(data);
      },
      onDone: () {
        shell.kill();
        onDone.call();
      },
      cancelOnError: true,
    );
    shell.stderr.listen(
      (event) {
        String data = utf8.decode(event);
        stderr.write(data);
        onData.call(data);
      },
      onDone: () {
        shell.kill();
        onDone.call();
      },
      cancelOnError: true,
    );
    return shell;
  }
}
