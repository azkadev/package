/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

import "packagex_pubspec_platforms.dart";
import "packagex_pubspec_environment.dart";
import "packagex_pubspec_dependencies.dart";
import "packagex_pubspec_dev_dependencies.dart";
import "packagex_config.dart";
import "packagex_msix_config.dart";

class PackagexPubspec extends JsonScheme {
  PackagexPubspec(super.rawData);

  static Map get defaultData {
    return {
      "@type": "packagexPubspec",
      "name": "example",
      "description": "A sample command-line application.",
      "version": "0.0.0",
      "publish_to": "none",
      "homepage": "https://youtube.com/@azkadev",
      "repository": "https://github.com/azkadev/packagex.git",
      "platforms": {
        "@type": "packagexPubspecPlatforms",
        "android": null,
        "ios": null,
        "linux": null,
        "macos": null,
        "web": null,
        "windows": null
      },
      "environment": {
        "@type": "packagexPubspecEnvironment",
        "sdk": ">=2.18.5 <3.0.0"
      },
      "dependencies": {
        "@type": "packagexPubspecDependencies",
        "flutter": {
          "@type": "packagexPubspecDependenciesExtra",
          "sdk": "flutter"
        },
        "cupertino_icons": "^1.0.2"
      },
      "dev_dependencies": {
        "@type": "packagexPubspecDevDependencies",
        "lints": "^2.0.0",
        "test": "^1.16.0",
        "packagex": {
          "@type": "packagexPubspecDevDependenciesExtra",
          "path": "../"
        },
        "msix": "^1.0.6"
      },
      "packagex": {
        "@type": "packagexConfig",
        "name": "Pack",
        "dart_target": "",
        "flutter_target": "",
        "dart_name": "",
        "flutter_name": "",
        "is_without_platform_name": true,
        "flutter_commands": {
          "@type": "packagexConfigFlutterCommands",
          "obfuscate": true,
          "split-debug-info": "0.0.5",
          "build-name": "0.0.5",
          "build-number": 40,
          "split-per-abi": true,
          "no-tree-shake-icons": true
        },
        "project_id": "",
        "github_username": "",
        "github_is_org": true
      },
      "msix_config": {
        "@type": "packagexMsixConfig",
        "display_name": "example",
        "publisher_display_name": "Azkadev Packagex",
        "identity_name": "org.azkadev.example",
        "msix_version": "0.0.0.0",
        "logo_path": "example/bin/example.dart",
        "capabilities": "internetClient, location, microphone, webcam",
        "install_certificate": false
      }
    };
  }

  String? get special_type {
    try {
      if (rawData["@type"] is String == false) {
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  set special_type(String? value) {
    rawData["@type"] = value;
  }

  String? get name {
    try {
      if (rawData["name"] is String == false) {
        return null;
      }
      return rawData["name"] as String;
    } catch (e) {
      return null;
    }
  }

  set name(String? value) {
    rawData["name"] = value;
  }

  String? get description {
    try {
      if (rawData["description"] is String == false) {
        return null;
      }
      return rawData["description"] as String;
    } catch (e) {
      return null;
    }
  }

  set description(String? value) {
    rawData["description"] = value;
  }

  String? get version {
    try {
      if (rawData["version"] is String == false) {
        return null;
      }
      return rawData["version"] as String;
    } catch (e) {
      return null;
    }
  }

  set version(String? value) {
    rawData["version"] = value;
  }

  String? get publish_to {
    try {
      if (rawData["publish_to"] is String == false) {
        return null;
      }
      return rawData["publish_to"] as String;
    } catch (e) {
      return null;
    }
  }

  set publish_to(String? value) {
    rawData["publish_to"] = value;
  }

  String? get homepage {
    try {
      if (rawData["homepage"] is String == false) {
        return null;
      }
      return rawData["homepage"] as String;
    } catch (e) {
      return null;
    }
  }

  set homepage(String? value) {
    rawData["homepage"] = value;
  }

  String? get repository {
    try {
      if (rawData["repository"] is String == false) {
        return null;
      }
      return rawData["repository"] as String;
    } catch (e) {
      return null;
    }
  }

  set repository(String? value) {
    rawData["repository"] = value;
  }

  PackagexPubspecPlatforms get platforms {
    try {
      if (rawData["platforms"] is Map == false) {
        return PackagexPubspecPlatforms({});
      }
      return PackagexPubspecPlatforms(rawData["platforms"] as Map);
    } catch (e) {
      return PackagexPubspecPlatforms({});
    }
  }

  set platforms(PackagexPubspecPlatforms value) {
    rawData["platforms"] = value.toJson();
  }

  PackagexPubspecEnvironment get environment {
    try {
      if (rawData["environment"] is Map == false) {
        return PackagexPubspecEnvironment({});
      }
      return PackagexPubspecEnvironment(rawData["environment"] as Map);
    } catch (e) {
      return PackagexPubspecEnvironment({});
    }
  }

  set environment(PackagexPubspecEnvironment value) {
    rawData["environment"] = value.toJson();
  }

  PackagexPubspecDependencies get dependencies {
    try {
      if (rawData["dependencies"] is Map == false) {
        return PackagexPubspecDependencies({});
      }
      return PackagexPubspecDependencies(rawData["dependencies"] as Map);
    } catch (e) {
      return PackagexPubspecDependencies({});
    }
  }

  set dependencies(PackagexPubspecDependencies value) {
    rawData["dependencies"] = value.toJson();
  }

  PackagexPubspecDevDependencies get dev_dependencies {
    try {
      if (rawData["dev_dependencies"] is Map == false) {
        return PackagexPubspecDevDependencies({});
      }
      return PackagexPubspecDevDependencies(rawData["dev_dependencies"] as Map);
    } catch (e) {
      return PackagexPubspecDevDependencies({});
    }
  }

  set dev_dependencies(PackagexPubspecDevDependencies value) {
    rawData["dev_dependencies"] = value.toJson();
  }

  PackagexConfig get packagex {
    try {
      if (rawData["packagex"] is Map == false) {
        return PackagexConfig({});
      }
      return PackagexConfig(rawData["packagex"] as Map);
    } catch (e) {
      return PackagexConfig({});
    }
  }

  set packagex(PackagexConfig value) {
    rawData["packagex"] = value.toJson();
  }

  PackagexMsixConfig get msix_config {
    try {
      if (rawData["msix_config"] is Map == false) {
        return PackagexMsixConfig({});
      }
      return PackagexMsixConfig(rawData["msix_config"] as Map);
    } catch (e) {
      return PackagexMsixConfig({});
    }
  }

  set msix_config(PackagexMsixConfig value) {
    rawData["msix_config"] = value.toJson();
  }

  static PackagexPubspec create({
    String special_type = "packagexPubspec",
    String? name,
    String? description,
    String? version,
    String? publish_to,
    String? homepage,
    String? repository,
    PackagexPubspecPlatforms? platforms,
    PackagexPubspecEnvironment? environment,
    PackagexPubspecDependencies? dependencies,
    PackagexPubspecDevDependencies? dev_dependencies,
    PackagexConfig? packagex,
    PackagexMsixConfig? msix_config,
  }) {
    // PackagexPubspec packagexPubspec = PackagexPubspec({
    Map packagexPubspec_data_create_json = {
      "@type": special_type,
      "name": name,
      "description": description,
      "version": version,
      "publish_to": publish_to,
      "homepage": homepage,
      "repository": repository,
      "platforms": (platforms != null) ? platforms.toJson() : null,
      "environment": (environment != null) ? environment.toJson() : null,
      "dependencies": (dependencies != null) ? dependencies.toJson() : null,
      "dev_dependencies":
          (dev_dependencies != null) ? dev_dependencies.toJson() : null,
      "packagex": (packagex != null) ? packagex.toJson() : null,
      "msix_config": (msix_config != null) ? msix_config.toJson() : null,
    };

    packagexPubspec_data_create_json.removeWhere((key, value) => value == null);
    PackagexPubspec packagexPubspec_data_create =
        PackagexPubspec(packagexPubspec_data_create_json);

    return packagexPubspec_data_create;
  }
}
