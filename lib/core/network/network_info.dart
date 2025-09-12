import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

///  pour vérifier la connectivité réseau
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<List<ConnectivityResult>> get connectionType;
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
  Future<bool> get hasInternetAccess;
}

/// Implémentation de NetworkInfo utilisant connectivity_plus et internet_connection_checker
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final InternetConnectionChecker internetConnectionChecker;
  
  NetworkInfoImpl({
    required this.connectivity,
    required this.internetConnectionChecker,
  });
  
  /// Vérifie si l'appareil est connecté à un réseau (WiFi, Mobile, Ethernet)
  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult.isNotEmpty && 
           connectivityResult.any((result) => result != ConnectivityResult.none);
  }
  
  /// Obtient le type de connexion actuel
  @override
  Future<List<ConnectivityResult>> get connectionType async {
    return await connectivity.checkConnectivity();
  }
  
  /// Stream des changements de connectivité
  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return connectivity.onConnectivityChanged;
  }
  
  /// Vérifie si l'appareil a réellement accès à Internet
  @override
  Future<bool> get hasInternetAccess async {
    try {
      // Vérifie d'abord la connectivité basique
      if (!await isConnected) {
        return false;
      }
      
      // Puis teste l'accès réel à Internet
      return await internetConnectionChecker.hasConnection;
    } catch (e) {
      return false;
    }
  }
  
  /// Méthode utilitaire pour obtenir le nom du type de connexion principal
  Future<String> getConnectionTypeName() async {
    final types = await connectionType;
    if (types.isEmpty) {
      return 'Aucune connexion';
    }
    
    // Retourne le type de connexion principal (priorité WiFi > Mobile > etc.)
    if (types.contains(ConnectivityResult.wifi)) {
      return 'WiFi';
    } else if (types.contains(ConnectivityResult.mobile)) {
      return 'Données mobiles';
    } else if (types.contains(ConnectivityResult.ethernet)) {
      return 'Ethernet';
    } else if (types.contains(ConnectivityResult.bluetooth)) {
      return 'Bluetooth';
    } else if (types.contains(ConnectivityResult.vpn)) {
      return 'VPN';
    } else if (types.contains(ConnectivityResult.other)) {
      return 'Autre';
    } else {
      return 'Aucune connexion';
    }
  }
  
  /// Méthode utilitaire pour obtenir tous les types de connexion actifs
  Future<List<String>> getAllConnectionTypes() async {
    final types = await connectionType;
    return types.map((type) {
      switch (type) {
        case ConnectivityResult.wifi:
          return 'WiFi';
        case ConnectivityResult.mobile:
          return 'Données mobiles';
        case ConnectivityResult.ethernet:
          return 'Ethernet';
        case ConnectivityResult.bluetooth:
          return 'Bluetooth';
        case ConnectivityResult.vpn:
          return 'VPN';
        case ConnectivityResult.other:
          return 'Autre';
        case ConnectivityResult.none:
          return 'Aucune connexion';
      }
    }).toList();
  }
  
  /// Attend qu'une connexion soit disponible
  Future<void> waitForConnection({Duration timeout = const Duration(seconds: 30)}) async {
    final completer = Completer<void>();
    Timer? timeoutTimer;
    StreamSubscription? subscription;
    
    // Vérifie immédiatement si on est déjà connecté
    if (await hasInternetAccess) {
      return;
    }
    
    // Configure le timeout
    timeoutTimer = Timer(timeout, () {
      if (!completer.isCompleted) {
        subscription?.cancel();
        completer.completeError(TimeoutException('Timeout en attente de connexion'));
      }
    });
    
    // Écoute les changements de connectivité
    subscription = onConnectivityChanged.listen((results) async {
      if (results.isNotEmpty && 
          results.any((result) => result != ConnectivityResult.none) && 
          await hasInternetAccess) {
        timeoutTimer?.cancel();
        subscription?.cancel();
        if (!completer.isCompleted) {
          completer.complete();
        }
      }
    });
    
    return completer.future;
  }
}

/// Extension pour des vérifications rapides
extension ConnectivityResultExtension on ConnectivityResult {
  bool get isConnected => this != ConnectivityResult.none;
  
  bool get isMobile => this == ConnectivityResult.mobile;
  
  bool get isWifi => this == ConnectivityResult.wifi;
  
  bool get isEthernet => this == ConnectivityResult.ethernet;
  
  String get displayName {
    switch (this) {
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return 'Mobile';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.vpn:
        return 'VPN';
      case ConnectivityResult.other:
        return 'Autre';
      case ConnectivityResult.none:
        return 'Aucune';
    }
  }
}

/// Extension 
extension ConnectivityListExtension on List<ConnectivityResult> {
  bool get isConnected => isNotEmpty && any((result) => result != ConnectivityResult.none);
  
  bool get hasWifi => contains(ConnectivityResult.wifi);
  
  bool get hasMobile => contains(ConnectivityResult.mobile);
  
  bool get hasEthernet => contains(ConnectivityResult.ethernet);
  
  bool get hasBluetooth => contains(ConnectivityResult.bluetooth);
  
  bool get hasVpn => contains(ConnectivityResult.vpn);
  
  String get primaryConnectionType {
    if (isEmpty) return 'Aucune';
    if (hasWifi) return 'WiFi';
    if (hasMobile) return 'Mobile';
    if (hasEthernet) return 'Ethernet';
    if (hasBluetooth) return 'Bluetooth';
    if (hasVpn) return 'VPN';
    return 'Autre';
  }
  
  List<String> get allConnectionTypes {
    return map((type) => type.displayName).toList();
  }
}