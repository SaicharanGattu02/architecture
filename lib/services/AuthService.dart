import 'package:architect/services/api_endpoint_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../app_routes/router.dart';
import '../utils/constants.dart';
import 'ApiClient.dart';
import 'api_endpoint_urls.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/widgets.dart';

class AuthService {
  static const String _accessTokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";
  static const String _tokenExpiryKey = "token_expiry";

  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Check if the user is a guest (no token or empty token)
  static Future<bool> get isGuest async {
    final token = await getAccessToken();
    return token == null || token.isEmpty;
  }

  /// Get stored access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Get stored refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Check if token is expired
  static Future<bool> isTokenExpired() async {
    final expiryTimestampStr = await _storage.read(key: _tokenExpiryKey);
    if (expiryTimestampStr == null) {
      debugPrint('No expiry timestamp found, considering token expired');
      return true;
    }
    final expiryTimestamp = int.tryParse(expiryTimestampStr);
    final now = DateTime.now().millisecondsSinceEpoch;
    final isExpired = expiryTimestamp == null || now >= expiryTimestamp;
    debugPrint('Token expiry check: now=$now, expiry=$expiryTimestamp, isExpired=$isExpired');
    return isExpired;
  }

  /// Save tokens and expiry time
  static Future<void> saveTokens(String accessToken, String refreshToken, int expiresIn) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    await _storage.write(key: _tokenExpiryKey, value: expiresIn.toString());
    debugPrint('Tokens saved: accessToken=$accessToken, expiryTime=$expiresIn');
  }

  /// Refresh token
  static Future<bool> refreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      debugPrint('❌ No refresh token available');
      return false;
    }

    try {
      final response = await ApiClient.post(
        APIEndpointUrls.refreshtoken,
        data: {"refresh": refreshToken},
      );

      if (response.statusCode == 200) {
        final tokenData = response.data["data"];
        final newAccessToken = tokenData["access"];
        final newRefreshToken = tokenData["refresh"];
        final expiryTime = tokenData["expiry_time"];

        if (newAccessToken == null || newRefreshToken == null || expiryTime == null) {
          debugPrint("❌ Missing token data in response: $tokenData");
          return false;
        }

        await saveTokens(newAccessToken, newRefreshToken, expiryTime);
        debugPrint("✅ Token refreshed and saved successfully");
        return true;
      } else {
        debugPrint("❌ Refresh token request failed with status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("❌ Token refresh failed: $e");
      return false;
    }
  }

  /// Logout and clear tokens, redirect to sign-in screen
  static Future<void> logout() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _tokenExpiryKey);
    debugPrint('Tokens cleared, user logged out');

    if (navigatorKey.currentContext != null) {
      navigatorKey.currentContext!.go('/onboarding');
    } else {
      debugPrint('⚠️ Navigator context is null, scheduling navigation...');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (navigatorKey.currentContext != null) {
          navigatorKey.currentContext!.go('/onboarding');
        }
      });
    }
  }
}

