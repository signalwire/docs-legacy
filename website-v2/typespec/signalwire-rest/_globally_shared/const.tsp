// Spec Info Area

const SERVER_URL = "signalwire.com/api";

const SERVER_URL_DESCRIPTION = "The domain of the users SignalWire space.";

const TERMS_OF_SERVICE = "https://signalwire.com/legal/signalwire-cloud-agreement";

const CONTACT_NAME = "SignalWire";

const CONTACT_URL = "https://support.signalwire.com/portal/en/newticket?departmentId=1029313000000006907&layoutId=1029313000000074011";

const CONTACT_EMAIL = "support@signalwire.com";

const LICENSE_URL = "https://github.com/signalwire/docs/blob/main/LICENSE";

const LICENSE_NAME = "MIT";

const CONTACT_INFO = #{
  name: CONTACT_NAME,
  url: CONTACT_URL,
  email: CONTACT_EMAIL,
};

const LICENSE_INFO = #{ name: LICENSE_NAME, url: LICENSE_URL };

// Commonly shared Const

const UTC_TIME_EXAMPLE = utcDateTime.fromISO("""
  2024-05-06T12:20:00Z
  """);
