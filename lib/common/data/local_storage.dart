import 'prefrences_key.dart';
import 'shared_prefrences_utils.dart';

class LocalStorage {
  Future<bool> doSetCacheLoggedIn(String status) async =>
      await SharedPreferencesUtils.setString(preferencesLoggedIn, status);

  Future<void> doClearCacheUser() async =>
      await SharedPreferencesUtils.clear(key: preferencesLoggedIn);

  Future<bool> doSetCacheListMediaPath(String imagePath) async =>
      await SharedPreferencesUtils.setString(preferencesListMedia, imagePath);
  Future<String?> doGetCacheListMediaPath() async =>
      await SharedPreferencesUtils.getString(preferencesListMedia);

  Future<void> doClearListMediaPath() async =>
      await SharedPreferencesUtils.clear(key: preferencesListMedia);
  Future<bool> doSetCacheJWK(String jwk) async =>
      await SharedPreferencesUtils.setString(preferencesjwk, jwk);

  Future<String?> doGetCacheJWK() async =>
      await SharedPreferencesUtils.getString(preferencesjwk);

  Future<bool> doSetCacheSWAT(String jwk) async =>
      await SharedPreferencesUtils.setString(preferencesSWAT, jwk);

  Future<String?> doGetCacheSWAT() async =>
      await SharedPreferencesUtils.getString(preferencesSWAT);

  Future<void> doClearCacheSWAT() async =>
      await SharedPreferencesUtils.clear(key: preferencesSWAT);

  Future<bool> doSetCacheSwirfer(String jwk) async =>
      await SharedPreferencesUtils.setString(preferencesSwirfer, jwk);

  Future<String?> doGetCacheSwirfer() async =>
      await SharedPreferencesUtils.getString(preferencesSwirfer);

  Future<void> doClearCacheSwirfer() async =>
      await SharedPreferencesUtils.clear(key: preferencesSwirfer);

  Future<bool> doSetCacheDeviceID(String value) async =>
      await SharedPreferencesUtils.setString(preferencesDeviceID, value);

  Future<String?> doGetCacheDeviceID() async =>
      await SharedPreferencesUtils.getString(preferencesDeviceID);

  Future<void> doClearCacheDeviceID() async =>
      await SharedPreferencesUtils.clear(key: preferencesDeviceID);

  Future<bool> doSetCacheMyProfileChoice(String value) async =>
      await SharedPreferencesUtils.setString(preferencesProfile, value);

  Future<String?> doGetCacheMyProfileChoice() async =>
      await SharedPreferencesUtils.getString(preferencesProfile);

  Future<void> doClearCacheMyProfileChoice() async =>
      await SharedPreferencesUtils.clear(key: preferencesProfile);

  Future<bool> doSetCacheMyClientChoice(String value) async =>
      await SharedPreferencesUtils.setString(preferencesClients, value);

  Future<String?> doGetCacheMyClientChoice() async =>
      await SharedPreferencesUtils.getString(preferencesClients);

  Future<void> doClearCacheMyClientChoice() async =>
      await SharedPreferencesUtils.clear(key: preferencesClients);

  Future<bool> doSetCacheMyEventChoice(String value) async =>
      await SharedPreferencesUtils.setString(preferencesEvents, value);

  Future<String?> doGetCacheMyEventChoice() async =>
      await SharedPreferencesUtils.getString(preferencesEvents);

  Future<void> doClearCacheMyEventChoice() async =>
      await SharedPreferencesUtils.clear(key: preferencesEvents);

   Future<bool> doSetIntroductioChat(String value) async =>
      await SharedPreferencesUtils.setString(preferencesIntroductioChat, value);

   Future<String?> doGetIntroductioChat() async =>
      await SharedPreferencesUtils.getString(preferencesIntroductioChat);

   Future<bool> doSetTrack(String value) async =>
      await SharedPreferencesUtils.setString(preferencesTrack, value);

   Future<String?> doGetTrack() async =>
      await SharedPreferencesUtils.getString(preferencesTrack);

   Future<bool> doSetUnicus(String value) async =>
      await SharedPreferencesUtils.setString(preferencesUnicus, value);

   Future<String?> doGetUnicus() async =>
      await SharedPreferencesUtils.getString(preferencesUnicus);

   Future<bool> doSetCacheSWATValidUntil(String swat) async =>
      await SharedPreferencesUtils.setString(preferencesSWATValidUntil, swat);

   Future<String?> doGetCacheSWATValidUntil() async =>
      await SharedPreferencesUtils.getString(preferencesSWATValidUntil);

   Future<void> doClearCacheSWATValidUntil() async =>
      await SharedPreferencesUtils.clear(key: preferencesSWATValidUntil);

   Future<bool> doSetCacheRefreshToken(String refreshTokenModel) async =>
      await SharedPreferencesUtils.setString(
          preferencesRefreshToken, refreshTokenModel);

  Future<String?> doGetCacheRefreshToken() async =>
      await SharedPreferencesUtils.getString(preferencesRefreshToken);

   Future<bool> doSetCacheIsRememberMe(String isRememberMeModel) async =>
      await SharedPreferencesUtils.setString(
          preferencesIsRememberMe, isRememberMeModel);

   Future<String?> doGetCacheIsRememberMe() async =>
      await SharedPreferencesUtils.getString(preferencesIsRememberMe);

  Future<void> doClearCacheIsRememberMe() async =>
      await SharedPreferencesUtils.clear(
          key: preferencesIsRememberMe);

   Future<bool> doSetCacheCustomerEventData(String customerEventDataModel) async =>
      await SharedPreferencesUtils.setString(
          preferencesCustomerEventData, customerEventDataModel);

   Future<String?> doGetCacheCustomerEventData() async =>
      await SharedPreferencesUtils.getString(preferencesCustomerEventData);

  Future<void> doClearCacheCustomerEventData() async =>
      await SharedPreferencesUtils.clear(
          key: preferencesCustomerEventData);


  Future<bool> doSetCache16DigitsTrack(
          String value) async =>
      await SharedPreferencesUtils.setString(
          preferences16DigitsTrack, value);

  Future<String?> doGetCache16DigitsTrack() async =>
      await SharedPreferencesUtils.getString(preferences16DigitsTrack);

  Future<void> doClearCache16DigitsTrack() async =>
      await SharedPreferencesUtils.clear(
          key: preferences16DigitsTrack);


  Future<bool> doSetNotification(
          String value) async =>
      await SharedPreferencesUtils.setString(
          preferencesNotification, value);

  Future<String?> doGetNotification() async =>
      await SharedPreferencesUtils.getString(preferencesNotification);

  Future<void> doClearNotification() async =>
      await SharedPreferencesUtils.clear(
          key: preferencesNotification);

  Future<bool> doSetIsVerified(
          String value) async =>
      await SharedPreferencesUtils.setString(
          preferencesIsVerified, value);

  Future<String?> doGetIsVerified() async =>
      await SharedPreferencesUtils.getString(preferencesIsVerified);

  Future<void> doClearIsVerified() async =>
      await SharedPreferencesUtils.clear(
          key: preferencesIsVerified);


  Future<bool> doSetPEMPublicKey(
          String value) async =>
      await SharedPreferencesUtils.setString(
          preferencesPEMPublicKey, value);

  Future<String?> doGetPEMPublicKey() async =>
      await SharedPreferencesUtils.getString(preferencesPEMPublicKey);

  Future<void> doClearPEMPublicKey() async =>
      await SharedPreferencesUtils.clear(
          key: preferencesPEMPublicKey);

  Future<bool> doSetPEMPrivateKey(
          String value) async =>
      await SharedPreferencesUtils.setString(
          preferencesPEMPrivateKey, value);

  Future<String?> doGetPEMPrivateKey() async =>
      await SharedPreferencesUtils.getString(preferencesPEMPrivateKey);

  Future<void> doClearPEMPrivateKey() async =>
      await SharedPreferencesUtils.clear(
          key: preferencesPEMPrivateKey);



Future<bool> doSetCachedestinario(String destinario) async =>
      await SharedPreferencesUtils.setString(preferencesDestinario, destinario);

  Future<String?> doGetCachedestinario() async =>
      await SharedPreferencesUtils.getString(preferencesDestinario);
      
Future<bool> doSetCacheJWKRegister(String jwk) async =>
      await SharedPreferencesUtils.setString(preferencesjwkRegister, jwk);

  Future<String?> doGetCacheJWKRegister() async =>
      await SharedPreferencesUtils.getString(preferencesjwkRegister);

Future<bool> doSetCacheAppearance(String destinario) async =>
      await SharedPreferencesUtils.setString(preferencesAppearance, destinario);

  Future<String?> doGetCacheAppearances() async =>
      await SharedPreferencesUtils.getString(preferencesAppearance);
}