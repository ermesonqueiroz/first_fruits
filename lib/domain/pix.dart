class Pix {
  static const ID_PAYLOAD_FORMAT_INDICATOR = '00';
  static const ID_POINT_OF_INITIATION_METHOD = '01';
  static const ID_MERCHANT_ACCOUNT_INFORMATION = '26';
  static const ID_MERCHANT_ACCOUNT_INFORMATION_GUI = '00';
  static const ID_MERCHANT_ACCOUNT_INFORMATION_KEY = '01';
  static const ID_MERCHANT_CATEGORY_CODE = '52';
  static const ID_TRANSACTION_CURRENCY = '53';
  static const ID_TRANSACTION_AMOUNT = '54';
  static const ID_COUNTRY_CODE = '58';
  static const ID_MERCHANT_NAME = '59';
  static const ID_MERCHANT_CITY = '60';
  static const ID_ADDITIONAL_DATA_FIELD_TEMPLATE = '62';
  static const ID_ADDITIONAL_DATA_FIELD_TEMPLATE_REFERENCE_LABEL = '05';
  static const ID_CRC16 = '63';

  final String key;
  final double amount;
  final String merchantName;
  final String merchantCity;
  final String referenceLabel;

  Pix({
    required this.key,
    required this.amount,
    required this.merchantName,
    required this.merchantCity,
    required this.referenceLabel,
  });

  String _retrieveItemValue(String id, String value) {
    final size = value.length.toString().padLeft(2, '0');
    return '$id$size$value';
  }

  String _getMerchantAccountInformation() {
    final gui = _retrieveItemValue(
      ID_MERCHANT_ACCOUNT_INFORMATION_GUI,
      'br.gov.bcb.pix',
    );
    final accountKey = _retrieveItemValue(
      ID_MERCHANT_ACCOUNT_INFORMATION_KEY,
      key,
    );
    final merchantAccountInformation = '$gui$accountKey';
    return _retrieveItemValue(
      ID_MERCHANT_ACCOUNT_INFORMATION,
      merchantAccountInformation,
    );
  }

  String _getAdditionalDataFieldTemplate() {
    final referenceLabelValue = _retrieveItemValue(
      ID_ADDITIONAL_DATA_FIELD_TEMPLATE_REFERENCE_LABEL,
      referenceLabel,
    );
    return _retrieveItemValue(
      ID_ADDITIONAL_DATA_FIELD_TEMPLATE,
      referenceLabelValue,
    );
  }

  String _getCRC16(String payload) {
    String localPayload = payload + ID_CRC16 + '04';

    const int polynomial = 0x1021;
    int crc = 0xFFFF;

    for (int i = 0; i < localPayload.length; i++) {
      crc ^= localPayload.codeUnitAt(i) << 8;

      for (int j = 0; j < 8; j++) {
        if ((crc & 0x8000) != 0) {
          crc = (crc << 1) ^ polynomial;
        } else {
          crc = crc << 1;
        }
      }
    }

    crc &= 0xFFFF;

    return '${ID_CRC16}04${crc.toRadixString(16).toUpperCase().padLeft(4, '0')}';
  }

  String getPayload() {
    final payload =
        _retrieveItemValue(ID_PAYLOAD_FORMAT_INDICATOR, '01') +
        _retrieveItemValue(ID_POINT_OF_INITIATION_METHOD, '12') +
        _getMerchantAccountInformation() +
        _retrieveItemValue(ID_MERCHANT_CATEGORY_CODE, '0000') +
        _retrieveItemValue(ID_TRANSACTION_CURRENCY, '986') +
        _retrieveItemValue(ID_TRANSACTION_AMOUNT, amount.toStringAsFixed(2)) +
        _retrieveItemValue(ID_COUNTRY_CODE, 'BR') +
        _retrieveItemValue(ID_MERCHANT_NAME, merchantName) +
        _retrieveItemValue(ID_MERCHANT_CITY, merchantCity) +
        _getAdditionalDataFieldTemplate();

    return payload + _getCRC16(payload);
  }
}
