/// Navigation paths for the app
enum NavPath {
  examination._(
    path: '/exam',
    name: 'Examination',
  ),
  examinationDetail._(
    path: '/exam/:commandmentId',
    name: 'Examination Detail',
  ),
  confession._(
    path: '/confession',
    name: 'Confession',
  ),
  guide._(
    path: '/guide',
    name: 'Guide',
  ),
  guideDetailList._(
    path: '/guide/:guideId',
    name: 'Guide Detail List',
  ),
  guideDetails._(
    path: '/guide/:guideId/details',
    name: 'Guide Details',
  ),
  prayers._(
    path: '/prayers',
    name: 'Prayers',
  ),
  prayerDetails._(
    path: '/prayers/:prayerId',
    name: 'Prayer Details',
  ),
  settings._(
    path: '/settings',
    name: 'Settings',
  );

  const NavPath._({required this.path, required this.name});
  final String path;
  final String name;

  static String examinationDetailPath(int commandmentId) =>
      '/exam/$commandmentId';

  static String guideDetailListPath(int guideId) => '/guide/$guideId';

  static String guideDetailsPath(int guideId) => '/guide/$guideId/details';
  
  static String prayerDetailsPath(int prayerId) => '/prayers/$prayerId';
}
