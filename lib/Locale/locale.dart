import 'package:doctoworld_doctor/Locale/Languages/italian.dart';
import 'package:doctoworld_doctor/Locale/Languages/turkish.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Languages/arabic.dart';
import 'Languages/english.dart';
import 'Languages/french.dart';
import 'Languages/indonesian.dart';
import 'Languages/portuguese.dart';
import 'Languages/spanish.dart';
import 'Languages/swahili.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': english(),
    'ar': arabic(),
    'pt': portuguese(),
    'fr': french(),
    'id': indonesian(),
    'es': spanish(),
    'it': italian(),
    'tr': turkish(),
    'sw': swahili(),
  };

  String? get myOrders {
    return _localizedValues[locale.languageCode]!['myOrders'];
  }

  String? get companyPolicies {
    return _localizedValues[locale.languageCode]!['companyPolicies'];
  }

  String? get storeProfile {
    return _localizedValues[locale.languageCode]!['storeProfile'];
  }

  String? get letUsHelpYou {
    return _localizedValues[locale.languageCode]!['letUsHelpYou'];
  }

  String? get wallet {
    return _localizedValues[locale.languageCode]!['wallet'];
  }

  String? get quickPayments {
    return _localizedValues[locale.languageCode]!['quickPayments'];
  }

  String? get insight {
    return _localizedValues[locale.languageCode]!['insight'];
  }

  String? get seeTheProgress {
    return _localizedValues[locale.languageCode]!['seeTheProgress'];
  }

  String? get earnings {
    return _localizedValues[locale.languageCode]!['earnings'];
  }

  String? get sellOverview {
    return _localizedValues[locale.languageCode]!['sellOverview'];
  }

  String? get myItems {
    return _localizedValues[locale.languageCode]!['myItems'];
  }

  String? get manageItems {
    return _localizedValues[locale.languageCode]!['manageItems'];
  }

  String? get tnC {
    return _localizedValues[locale.languageCode]!['tnC'];
  }

  String? get contactUs {
    return _localizedValues[locale.languageCode]!['contactUs'];
  }

  String? get faqs {
    return _localizedValues[locale.languageCode]!['faqs'];
  }

  String? get quickAnswers {
    return _localizedValues[locale.languageCode]!['quickAnswers'];
  }

  String? get logout {
    return _localizedValues[locale.languageCode]!['logout'];
  }

  String? get seeYouSoon {
    return _localizedValues[locale.languageCode]!['seeYouSoon'];
  }

  String? get account {
    return _localizedValues[locale.languageCode]!['account'];
  }

  String? get wellLifeStore {
    return _localizedValues[locale.languageCode]!['wellLifeStore'];
  }

  String? get myProfile {
    return _localizedValues[locale.languageCode]!['myProfile'];
  }

  String? get changeImage {
    return _localizedValues[locale.languageCode]!['changeImage'];
  }

  String? get wellLifeStoree {
    return _localizedValues[locale.languageCode]!['wellLifeStoree'];
  }

  String? get selectAddressOnMap {
    return _localizedValues[locale.languageCode]!['selectAddressOnMap'];
  }

  String? get update {
    return _localizedValues[locale.languageCode]!['update'];
  }

  String? get enterMobileNumber {
    return _localizedValues[locale.languageCode]!['enterMobileNumber'];
  }

  String? get continuee {
    return _localizedValues[locale.languageCode]!['continuee'];
  }

  String? get orQuickContinueWith {
    return _localizedValues[locale.languageCode]!['orQuickContinueWith'];
  }

  String? get facebook {
    return _localizedValues[locale.languageCode]!['facebook'];
  }

  String? get gmail {
    return _localizedValues[locale.languageCode]!['gmail'];
  }

  String? get registerNow {
    return _localizedValues[locale.languageCode]!['registerNow'];
  }

  String? get phoneNumberNotRegistered {
    return _localizedValues[locale.languageCode]!['phoneNumberNotRegistered'];
  }

  String? get mobileNumber {
    return _localizedValues[locale.languageCode]!['mobileNumber'];
  }

  String? get fullName {
    return _localizedValues[locale.languageCode]!['fullName'];
  }

  String? get emailAddress {
    return _localizedValues[locale.languageCode]!['emailAddress'];
  }

  String? get backToSignIn {
    return _localizedValues[locale.languageCode]!['backToSignIn'];
  }

  String? get wellSendAnOTP {
    return _localizedValues[locale.languageCode]!['wellSendAnOTP'];
  }

  String? get phoneVerification {
    return _localizedValues[locale.languageCode]!['phoneVerification'];
  }

  String? get weveSentAnOTP {
    return _localizedValues[locale.languageCode]!['weveSentAnOTP'];
  }

  String? get enter4digitOTP {
    return _localizedValues[locale.languageCode]!['enter4digitOTP'];
  }

  String? get submit {
    return _localizedValues[locale.languageCode]!['submit'];
  }

  String? get secLeft {
    return _localizedValues[locale.languageCode]!['secLeft'];
  }

  String? get resend {
    return _localizedValues[locale.languageCode]!['resend'];
  }

  String? get orderNum {
    return _localizedValues[locale.languageCode]!['orderNum'];
  }

  String? get pending {
    return _localizedValues[locale.languageCode]!['pending'];
  }

  String? get orderedItems {
    return _localizedValues[locale.languageCode]!['orderedItems'];
  }

  String? get packs {
    return _localizedValues[locale.languageCode]!['packs'];
  }

  String? get prescUploaded {
    return _localizedValues[locale.languageCode]!['prescUploaded'];
  }

  String? get subTotal {
    return _localizedValues[locale.languageCode]!['subTotal'];
  }

  String? get promoCodeApplied {
    return _localizedValues[locale.languageCode]!['promoCodeApplied'];
  }

  String? get serviceCharge {
    return _localizedValues[locale.languageCode]!['serviceCharge'];
  }

  String? get amountVia {
    return _localizedValues[locale.languageCode]!['amountVia'];
  }

  String? get deliveryPartnerAssign {
    return _localizedValues[locale.languageCode]!['deliveryPartnerAssign'];
  }

  String? get markAsReady {
    return _localizedValues[locale.languageCode]!['markAsReady'];
  }

  String? get today {
    return _localizedValues[locale.languageCode]!['today'];
  }

  String? get totalEarnings {
    return _localizedValues[locale.languageCode]!['totalEarnings'];
  }

  String? get payouts {
    return _localizedValues[locale.languageCode]!['payouts'];
  }

  String? get faq1 {
    return _localizedValues[locale.languageCode]!['faq1'];
  }

  String? get faq2 {
    return _localizedValues[locale.languageCode]!['faq2'];
  }

  String? get faq3 {
    return _localizedValues[locale.languageCode]!['faq3'];
  }

  String? get faq4 {
    return _localizedValues[locale.languageCode]!['faq4'];
  }

  String? get faq5 {
    return _localizedValues[locale.languageCode]!['faq5'];
  }

  String? get faq6 {
    return _localizedValues[locale.languageCode]!['faq6'];
  }

  String? get faq7 {
    return _localizedValues[locale.languageCode]!['faq7'];
  }

  String? get faq8 {
    return _localizedValues[locale.languageCode]!['faq8'];
  }

  String? get faq9 {
    return _localizedValues[locale.languageCode]!['faq9'];
  }

  String? get faq {
    return _localizedValues[locale.languageCode]!['faq'];
  }

  String? get orders {
    return _localizedValues[locale.languageCode]!['orders'];
  }

  String? get viewAllTransactions {
    return _localizedValues[locale.languageCode]!['viewAllTransactions'];
  }

  String? get topSellingItems {
    return _localizedValues[locale.languageCode]!['topSellingItems'];
  }

  String? get revenue {
    return _localizedValues[locale.languageCode]!['revenue'];
  }

  String? get apparel {
    return _localizedValues[locale.languageCode]!['apparel'];
  }

  String? get sold {
    return _localizedValues[locale.languageCode]!['sold'];
  }

  String? get recentOrders {
    return _localizedValues[locale.languageCode]!['recentOrders'];
  }

  String? get newOrders {
    return _localizedValues[locale.languageCode]!['newOrders'];
  }

  String? get pastOrders {
    return _localizedValues[locale.languageCode]!['pastOrders'];
  }

  String? get support {
    return _localizedValues[locale.languageCode]!['support'];
  }

  String? get howMayWeHelpYou {
    return _localizedValues[locale.languageCode]!['howMayWeHelpYou'];
  }

  String? get letUsKnowUrQueriesFeedbacks {
    return _localizedValues[locale.languageCode]!['letUsKnowUrQueriesFeedbacks'];
  }

  String? get writeYourMsg {
    return _localizedValues[locale.languageCode]!['writeYourMsg'];
  }

  String? get termsNConditions {
    return _localizedValues[locale.languageCode]!['termsNConditions'];
  }

  String? get recent {
    return _localizedValues[locale.languageCode]!['recent'];
  }

  String? get online {
    return _localizedValues[locale.languageCode]!['online'];
  }

  String? get availableBalance {
    return _localizedValues[locale.languageCode]!['availableBalance'];
  }

  String? get sendToBank {
    return _localizedValues[locale.languageCode]!['sendToBank'];
  }

  String? get addAddress {
    return _localizedValues[locale.languageCode]!['addAddress'];
  }

  String? get saveAddress {
    return _localizedValues[locale.languageCode]!['saveAddress'];
  }

  String? get deliveryPartner {
    return _localizedValues[locale.languageCode]!['deliveryPartner'];
  }

  String? get msg1 {
    return _localizedValues[locale.languageCode]!['msg1'];
  }

  String? get msg2 {
    return _localizedValues[locale.languageCode]!['msg2'];
  }

  String? get editItem {
    return _localizedValues[locale.languageCode]!['editItem'];
  }

  String? get productID {
    return _localizedValues[locale.languageCode]!['productID'];
  }

  String? get productName {
    return _localizedValues[locale.languageCode]!['productName'];
  }

  String? get itemCategory {
    return _localizedValues[locale.languageCode]!['itemCategory'];
  }

  String? get subCategory {
    return _localizedValues[locale.languageCode]!['subCategory'];
  }

  String? get medicines {
    return _localizedValues[locale.languageCode]!['medicines'];
  }

  String? get healthCareProducts {
    return _localizedValues[locale.languageCode]!['healthCareProducts'];
  }

  String? get description {
    return _localizedValues[locale.languageCode]!['description'];
  }

  String? get prescriptionUploaded {
    return _localizedValues[locale.languageCode]!['prescriptionUploaded'];
  }

  String? get setPricing {
    return _localizedValues[locale.languageCode]!['setPricing'];
  }

  String? get pricing {
    return _localizedValues[locale.languageCode]!['pricing'];
  }

  String? get quantity {
    return _localizedValues[locale.languageCode]!['quantity'];
  }

  String? get packOf {
    return _localizedValues[locale.languageCode]!['packOf'];
  }

  String? get updateItem {
    return _localizedValues[locale.languageCode]!['updateItem'];
  }

  String? get coldFever {
    return _localizedValues[locale.languageCode]!['coldFever'];
  }

  String? get headache {
    return _localizedValues[locale.languageCode]!['headache'];
  }

  String? get reviews {
    return _localizedValues[locale.languageCode]!['reviews'];
  }

  String? get averageReviews {
    return _localizedValues[locale.languageCode]!['averageReviews'];
  }

  String? get avgReview {
    return _localizedValues[locale.languageCode]!['avgReview'];
  }

  String? get forr {
    return _localizedValues[locale.languageCode]!['forr'];
  }

  String? get bankInfo {
    return _localizedValues[locale.languageCode]!['bankInfo'];
  }

  String? get accountHolderName {
    return _localizedValues[locale.languageCode]!['accountHolderName'];
  }

  String? get bankName {
    return _localizedValues[locale.languageCode]!['bankName'];
  }

  String? get branchCode {
    return _localizedValues[locale.languageCode]!['branchCode'];
  }

  String? get changeLanguage {
    return _localizedValues[locale.languageCode]!['changeLanguage'];
  }

  String? get accountNumber {
    return _localizedValues[locale.languageCode]!['accountNumber'];
  }

  String? get amountToTransfer {
    return _localizedValues[locale.languageCode]!['amountToTransfer'];
  }

  String? get call {
    return _localizedValues[locale.languageCode]!['call'];
  }

  String? get chat {
    return _localizedValues[locale.languageCode]!['chat'];
  }

  String? get myAppointments {
    return _localizedValues[locale.languageCode]!['myAppointments'];
  }

  String? get addHospital {
    return _localizedValues[locale.languageCode]!['addHospital'];
  }

  String? get searchHospital {
    return _localizedValues[locale.languageCode]!['searchHospital'];
  }

  String? get selectHospitalsToAdd {
    return _localizedValues[locale.languageCode]!['selectHospitalsToAdd'];
  }

  String? get save {
    return _localizedValues[locale.languageCode]!['save'];
  }

  String? get ser1 {
    return _localizedValues[locale.languageCode]!['ser1'];
  }

  String? get ser2 {
    return _localizedValues[locale.languageCode]!['ser2'];
  }

  String? get ser3 {
    return _localizedValues[locale.languageCode]!['ser3'];
  }

  String? get ser4 {
    return _localizedValues[locale.languageCode]!['ser4'];
  }

  String? get ser5 {
    return _localizedValues[locale.languageCode]!['ser5'];
  }

  String? get ser6 {
    return _localizedValues[locale.languageCode]!['ser6'];
  }

  String? get ser7 {
    return _localizedValues[locale.languageCode]!['ser7'];
  }

  String? get ser8 {
    return _localizedValues[locale.languageCode]!['ser8'];
  }

  String? get ser9 {
    return _localizedValues[locale.languageCode]!['ser9'];
  }

  String? get addService {
    return _localizedValues[locale.languageCode]!['addService'];
  }

  String? get searchService {
    return _localizedValues[locale.languageCode]!['searchService'];
  }

  String? get selectServiceToAdd {
    return _localizedValues[locale.languageCode]!['selectServiceToAdd'];
  }

  String? get addSpecialization {
    return _localizedValues[locale.languageCode]!['addSpecialization'];
  }

  String? get searchSpecialization {
    return _localizedValues[locale.languageCode]!['searchSpecialization'];
  }

  String? get selectSpecializationToAdd {
    return _localizedValues[locale.languageCode]!['selectSpecializationToAdd'];
  }

  String? get generalPhysician {
    return _localizedValues[locale.languageCode]!['generalPhysician'];
  }

  String? get familyPhysician {
    return _localizedValues[locale.languageCode]!['familyPhysician'];
  }

  String? get cardiologist {
    return _localizedValues[locale.languageCode]!['cardiologist'];
  }

  String? get consultant {
    return _localizedValues[locale.languageCode]!['consultant'];
  }

  String? get diabetologist {
    return _localizedValues[locale.languageCode]!['diabetologist'];
  }

  String? get servicesAt {
    return _localizedValues[locale.languageCode]!['servicesAt'];
  }

  String? get expFees {
    return _localizedValues[locale.languageCode]!['expFees'];
  }

  String? get years {
    return _localizedValues[locale.languageCode]!['years'];
  }

  String? get services {
    return _localizedValues[locale.languageCode]!['services'];
  }

  String? get edit {
    return _localizedValues[locale.languageCode]!['edit'];
  }

  String? get more {
    return _localizedValues[locale.languageCode]!['more'];
  }

  String? get specifications {
    return _localizedValues[locale.languageCode]!['specifications'];
  }

  String? get availability {
    return _localizedValues[locale.languageCode]!['availability'];
  }

  String? get to {
    return _localizedValues[locale.languageCode]!['to'];
  }

  String? get chestPain {
    return _localizedValues[locale.languageCode]!['chestPain'];
  }

  String? get tomorrow {
    return _localizedValues[locale.languageCode]!['tomorrow'];
  }

  String? get totalPeopleRated {
    return _localizedValues[locale.languageCode]!['totalPeopleRated'];
  }

  String? get appointmentsBooked {
    return _localizedValues[locale.languageCode]!['appointmentsBooked'];
  }

  String? get appointments {
    return _localizedValues[locale.languageCode]!['appointments'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'ar',
        'id',
        'pt',
        'fr',
        'es',
        'it',
        'tr',
        'sw'
      ].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
