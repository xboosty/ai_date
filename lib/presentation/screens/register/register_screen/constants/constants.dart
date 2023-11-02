import '../../../../../config/config.dart' show Genders, Sexuality;

class RegisterConstants {
  static const List<Genders> genders = [
    Genders(id: 1, name: 'Female'),
    Genders(id: 0, name: 'Male'),
    Genders(id: 2, name: 'Non Binary'),
  ];

  static const List<Sexuality> sexualities = [
    Sexuality(id: 4, name: 'Prefer not to say'),
    Sexuality(id: 0, name: 'Hetero'),
    Sexuality(id: 1, name: 'Bisexual'),
    Sexuality(id: 2, name: 'Homosexual'),
    Sexuality(id: 3, name: 'Transexual'),
  ];

  static const List<String> countriesISO = [
    'US', // Estados Unidos
    'IN', // India
    'CN', // China
    'ID', // Indonesia
    'PK', // Pakistán
    'BR', // Brasil
    'NG', // Nigeria
    'BD', // Bangladesh
    'RU', // Rusia
    'MX', // México
    'JP', // Japón
    'ET', // Etiopía
    'PH', // Filipinas
    'EG', // Egipto
    'VN', // Vietnam
    'CD', // República Democrática del Congo
    'TR', // Turquía
    'IR', // Irán
    'DE', // Alemania
    'TH', // Tailandia
    'GB', // Reino Unido
    'FR', // Francia
    'TZ', // Tanzania
    'IT', // Italia
    'ZA', // Sudáfrica
    'MM', // Myanmar (Birmania)
    'KR', // Corea del Sur
    'CO', // Colombia
    'ES', // España
    'UG', // Uganda
    'AR', // Argentina
    'UA', // Ucrania
    'AL', // Albania
    'KE', // Kenia
    'SD', // Sudán
    'PL', // Polonia
    'CA', // Canadá
    'MA', // Marruecos
    'UZ', // Uzbekistán
    'MY', // Malasia
    'PE', // Perú
    'BE', // Bélgica
    'CU', // Cuba
  ];
}
