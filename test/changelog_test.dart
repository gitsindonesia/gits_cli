import 'package:test/test.dart';

void main() {
  final changelog = '''## 0.29.2

- fix(selling_detail): make optional input customer in create order
- refactor(middleware_response): move to middleware response helper
- fix(receipt): hide section customer if response customer is null
- fix(receipt): hide address & phone if null or empty
- fix(core): hide text field label if readOnly and disable
- fix(core): condition middleware just call if unauthorized
- refactor(core): customer initial avatar and add trailing in gits item customer
- fix(manage): make optional for phone number and address to add customer
- fix(report): remove summary report for active customer

## 0.29.1

- adjust short description section detail product
- fix textoverflow at home item list
- fix textoverflow at customer item list
- implementation update product pertamina refill , tabung dan isi
- fix loading button login for wait fetch api user permission & user profile
- fix make optional input customer in create order

## 0.29.0

- adjust wording maximal and minimal range product pertamina
- implement flag active / nonactive for harga beli pertamina
- implementation widget test for manage customer page
- implementation widget test for list selected customer
- implementation widget test for list import customer section
- implementation widget test for import customer item
- implementation widget test for manage import customer page
- implementation widget test for access table row
- implementation widget test for access right page
- implementation widget test for section body detail employee
- implementation widget test for list group detail employee
- implementation widget test for manage detail employee
- fix ui for loading at manage detail employee
- fix ui text name overflow at manage detail employee
- change wording when successfully download report to gallery
- adjust employee item when text overflow
- add sentence for "Laporan Penjualan berhasil tersimpan di galeri"
- implementation widget test for section header detail employee
- implementation widget test for manage employee page
- implementation widget test for section form employee
- add refreshment pin for user checklist remember me
- add delete function product non pertamina

## 0.28.5

- set read only field email at forgot password page
- implementation widget test for merchant page
- implementation widget test for header item
- implementation widget test for logo and notification item
- implementation widget test for merchant info item
- implementation widget test for sales info item
- implementation widget test for section home background
- implementation widget test for section home header
- fix test string extension
- fix forgot password page
- implementation widget test for home page
- resolve issue email at forgot password before login
- resolve validation at login page
- implementation widget test for help category page
- implementation widget test help detail page
- handle not change qty onQuantityChanged when alert remove product anywhere tap
- implementation widget test for profile item
- implementation widget test section sales history
- implementation widget test for section home body
- implementation widget test for cancel transaction bottom sheet
- implementation widget test for sales item
- implementation widget test for arrow item
- implementation widget test for fab add order
- implementation widget test for chip product item
- update pubspec.yaml home
- implementation widget test for list faq section
- implementation widget test for list category faq section
- implementation widget test for item contact
- implementation widget test for faq section
- implementation widget test for contact section
- update pubspec.yaml help
- fix material app test with canpop & add widget test for gits app bar
- refactor(core): separate extension for custom routes to go_roter_extension

## 0.28.4

- ix import contact number to standard 62xxxxxxx

## 0.28.3

- fix refresh notification count in home & profile
- fix on delete notification until empty then show empty state

## 0.28.2

- refactor(notification): change implement api read notification from detail notification to notification list
- fix(notification): auto refresh notification count

## 0.28.1

- implement widget test reset pin page
- implement widget test dialog forgot password success
- implement widget test dialog pin success
- handle permission contact when request denied
- fix(edit_profile): auto update change address
- fix(verify_otp): auto clear after failed verify otp
- fix(help): add auto keep alive help in main page
- fix(manage): keep alive list customer & employee
- fix(main): auto refresh just navigate to current page
- fix(core): add validate phone number input formatter

## 0.28.0

- implement widget test for forgot password page
- implement api update profile
- fix issue register in owner data regencyId & districtId is same

## 0.27.0

- rerouting when successfully request forgot password
- set autofill email when forgot password
- set webview using completer at detail help page
- feat(notification): implement api notification count
- feat(notification): implement api notification
- feat(notification_detail): add extra data for notification detail
- feat(notification_read): implement api read notification
- feat(notification): implement api delete notification
- feat(receipt): add print struck this code modified from danone apollo
- feat upgrade dependency
- feat implement initial edit profile

## 0.26.0

- fix navigation for dialog success forgot password
- fix routing for help category and help detail page
- fix validation format phone number for import customer
- feat(edit_profile): implement api request otp
- feat(verify_otp): implement api validation otp email
- feat(verify_otp): add resend otp to old email
- feat(change_email): implement api request otp new email
- feat(verify_otp): implement api resend otp for new email

## 0.25.0

- fix(transaction): input decimal product qty by stock type
- fix(selling_detail): back from selling detail to selling page
- fix(main): unfocus keyboard after tap bottom bar
- fix(report): download and share report
- add loading layout help page
- implementation web view for handle html content
- resolve value item in sales by qty or liter
- fix(master): change postal code to dropdown
- feat(master): add auto fill postcode
- feat(change_email): add layouting change email
- feat(verify_otp): add layout verify otp

## 0.24.0

- config url_launcher for contact us
- handle action contact by email
- handle action contact by phone
- implementation api faq list at help page
- implementation api category help
- implementation api list category help
- handle search list category help
- adjust wording menu profile to akun
- implementation menu profile by permission
- add download & share report

## 0.23.0

- refactor gits bottom sheet to atomic widget
- add confirmation bottom sheet when back from register
- refactor move manage customer to master
- refactor move manage import customer to master
- implement add customer in select customer transaction

## 0.22.5

- fix default empty state for pagination
- fix empty state in selling page

## 0.22.4

- fix issue soft keyboard not show in release mode

## 0.22.3

- fix implement api order history sales
- set not mandatory for pin when update employee
- fix assets not show
- fix remove validate purchase price to minimum price
- fix enableFlutterDriverExtension

## 0.22.2

- fix implement api create product pertamina
- fix implement api create product non pertamina
- fix implement api update product non pertamina

## 0.22.1

- fix add refresh indicator each list page
- fix show report empty state
- fix show view all report
- fix section summary report customer
- fix overflow empty state
- fix duplicate date in report sales history
- fix auto refresh home, report & profile

## 0.22.0

- remove manage layout from manage
- clean up manage customer code
- clean up manage employee code
- implement api create product pertamina
- implement api update product pertamina
- implement api create product non pertamina
- implement api update product non pertamina
- fix layout empty state list history home
- fix spacing in select customer transacation

## 0.21.0

- refactor manage product
- add empty state search manage product
- implementation api access right
- add permissions crud in manage product
- add implement api update category product
- handle back to detail employee when tap history activity
- set validation calendar history activity 1 month
- fix error widget at manage employee
- add permission on manage employee
- add permission on manage customer
- fix layout add manage product non pertamina
- fix layout edit manage product non pertamina
- fix layout edit manage product pertamina
- feat validation form add manage product non pertamina
- feat validation form edit manage product non pertamina
- feat validation form edit manage product pertamina
- fix issue intermiten show back button in main page
- implement api detail product non pertamina
- implement api detail product pertamina

## 0.20.0

- add widget has permissions
- handle report page with permissions
- implement api user permissions
- fix remove widget info in view all report customer
- implement user permissions in manage
- add loading detail employee
- add empty list activity employee
- implementation api activity employee
- implementation filter date range employee

## 0.19.0

- add go or push with result gorouter
- add refresh report after add operational cost in view all
- add refresh home after add transaction
- add implement api total customer in view all customer
- add refresh page when create employee
- add refresh page when update employee
- add refresh page when delete employee

## 0.18.0

- add canceled status payment & refactor optimize status payment
- implement sorting in report sales history
- add new component gits status order
- fix total & total active in view all report customer
- implementation api select job pegawai
- implementation api create manage pegawai
- implementation api update manage pegawai
- implementation api delete manage pegawai
- validation form manage pegawai
- update dependency package
- fixing code after update major dependency
- refactor generate json2dart with gits_cli 2.7.0
- add implement api report create operational cost

## 0.17.0

- implementation api cancel order at home page
- implementation api create customer manualy
- implementation api create customer from contact
- implement api summary report best selling product
- implement api summary report total customer
- implement api summary report operational cost
- implement api view all report product
- implement api view all report customer
- implement api view all report operational cost
- implement api report sales history
- refactor separate feature receipt from transaction

## 0.16.0

- refactor all tab manage percubit
- implementation manage API list customer
- implementation search manage customer
- implementation manage API delete customer
- implementation manage API update customer
- add loading layout employee
- implementation manage API list employee
- implementation search manage employee

## 0.15.0

- implementation API sales dashboard today and yesterday
- handle api filter chip at home page
- implementation number phone and merchant name at home page
- add empty layout sales at home page
- add layout report financial
- add layout report sales history
- add layout report view all best selling product
- implementation API insert customer
- add layout report view all customer

## 0.14.0

- implementation validation insert manage customer
- implementation validation update manage customer
- add layout loading customer item
- add layout loading employee item
- add layout loading import customer contacts
- handle remove contact selected item
- add layouting empty report financial
- adjust ui & add validation component select calendar bottom sheet

## 0.13.0

- implement api page by slug (terms and conditions)
- handle reset pin error go to login
- replace api product master to manage
- refactor setting cubit to global cubit
- fix issue dispose paging controller

## 0.12.0

- implementation api transaction order
- handle state loading for transaction order
- fix page manage product with AutomaticKeepAliveClientMixin for handle dropdown
- adjust input formatter for thousands input
- adjust item customer
- adjust item employee
- implement api cancel order in payment
- add pagination in select bank register step 3
- implement api upload file in register upload npwp & ktp

## 0.11.2

- implement pagination in select customer

## 0.11.1

- add layout loading for manage product
- handle loading and empty state manage product
- adjust component gits search
- handle search and tap category manage product

## 0.11.0

- add api product category on master
- implementation api product category
- add api manage product on master
- implementation api manage product
- refactor file manage layout
- refactor manage tab as
- add terms and conditions page
- add connectivity page

## 0.10.0

- feat generate json2dart with gits cli 2.5.3
- add change connectivity listener for change page to no connection
- refactor gorouter move to locator
- fix receipt content
- fix user must cannot back from payment page

## 0.9.0

- fix wording in forgot password
- implementation api register
- implementation api check status payment
- implementation api detail order

## 0.8.0

- validasi step 3 registrasi
- validasi step 4 registrasi
- implementation api master bank
- adjust layouting transaction

## 0.7.0

- integrasi api user profile
- implementation of the access rights feature on the account page
- implementation of the access rights feature on the manage page
- implement api category products in selling page
- implement api products in selling page
- implement api create order in selling detail page
- implement api payment channel in selling detail page
- implement api get customer in select customer page
- handle search product
- change stock from int to double

## 0.6.0

- layout merchant
- integration get user profile by request token password
- fix flow auth user reset pin
- fix ui component home

## 0.5.1

- change wording in forgot password
- configuration deeplink
- add validate register step 1
- adjust layouting selling page
- adjust layouting selling detail page
- add busniness logic select customer in selling detial
- add busniness logic remove product in selling detail

## 0.5.0

- layout detail help
- layout category help
- validasi email 50 character
- add google maps place picker
- implement api business type in register step 1
- add validate merchant point, npwp, and business type section

## 0.4.0

- add assets icon for profile page
- add component gits dialog
- implementation ui profile page
- implementation ui edit profile page
- fix validasi email is required
- fix ui validasi forgot pin
- fix ui validasi reset pin
- fix save data forgot pin to flutter storage
- fix flow integration forgot pin
- fix flow integration reset pin
- implement api master location province, regency, district & village
- implement api master merchant type
- add validation merchant section & address section in register step 1

## 0.3.0

- fix ui reset pin
- integration auth request forgot pin
- integration auth reset pin
- refactor & fix component gits dropdown
- integration master location province
- change illustration fab home
- change illustration payment method
- change wording in payment method

## 0.2.2

- fix ui manage product
- add icon import and user contact
- refactor gits bottom sheet
- handle gits search have category
- refactor page manage

## 0.2.1

- fix implement api login with type
- fix smell code

## 0.2.0

- add assets calendar and reafactor prefix icon gits button date
- add gits button date
- add bottom sheet remove employee
- add library table calendar
- add download receipt
- add implement api login
- handle navigation in splash screen
- handle error message from api
- fix textfield label not show from initial set text

## 0.1.0

- add asset icon remix & iconsax
- add splash screen layout
- change assets from material icon to remix & iconsax
- add layout register for step 1, 2, 3 & 4.
- add layout manage
- refactor feature transaction
- refactor some component

## 0.0.2

- add bypas handshake httpoverride to environment is not prod
- fix generate qr code

## 0.0.1

- layout login
- layout register step 1 & step 3
- layout home
- layout manage
- layout transaction sell
- layout transaction sell detail / checkout
- layout payment generate QR link aja
- layout receipt
- layout help
- layout forgot pin
- layout reset pin
- layout manage product
- layout manage customer
- layout notification
- layout notification detail''';

  final changelog1 = '''## 0.29.2

- fix(selling_detail): make optional input customer in create order
- refactor(middleware_response): move to middleware response helper
- fix(receipt): hide section customer if response customer is null
- fix(receipt): hide address & phone if null or empty
- fix(core): hide text field label if readOnly and disable
- fix(core): condition middleware just call if unauthorized
- refactor(core): customer initial avatar and add trailing in gits item customer
- fix(manage): make optional for phone number and address to add customer
- fix(report): remove summary report for active customer''';

  String getLatestChangelog(String changelog) {
    final regex = RegExp(r'(#+)(\s+)?(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)');
    final match = regex.allMatches(changelog).take(2).toList();
    if (match.length == 2) {
      return changelog
          .substring(match[0].start, match[1].start)
          .replaceAll(regex, '')
          .trim();
    } else {
      return changelog.replaceAll(regex, '').trim();
    }
  }

  test('Take changelog first', () {
    print(getLatestChangelog(changelog));
    print(getLatestChangelog(changelog1));
  });
}
