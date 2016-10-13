using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco_Vol_1.Constants
{
    public static class CoCon
    {
        public struct Views
        {
            public static string SignInForm = "SignInForm";
            public static string CustomerProfileForm = "CustomerProfileForm";
        }

        public struct Customer
        {
            public static string Id = "Id";
            public static string CustomerId = "CustomerId";
            public static string CustomerName = "CustomerName";
        }

        public struct Request
        {
            public static string Caller = "caller";
            public static string Message = "message";
            public static string MsgMail = "msgMail";
            public static string MsgPhone = "msgPhone";
            public static string MsgBirth = "msgBirth";
            public static string Error = "error";
        }

        public struct Address
        {
            public static string CollexctionName = "Addresses";

            public static string CustomerId = "customerId";
            public static string CompanyName = "companyName";
            public static string FirstName = "firstName";
            public static string Password = "password";
            public static string Mail = "mail";
            public static string Phone = "phone";
            public static string DateOfBirth = "dateOfBirth";
            public static string WorkboosterNewsletter = "workboosterNewsletter";
            public static string ProffixNewsletter = "proffixNewsletter";
            public static string TopalNewsletter = "topalNewsletter";
        }

        public struct ProfilrMessages
        {
            public static string UpdateSuccess =
                "Ihr Profil wurde erfolgreich aktualisiert";

            public static string PasswordSuccess =
                "Ihr Profil und Ihr Passwort wurden erfolgreich aktualisiert";

            public static string NoPassword =
                "Sie wissen, dass Sie ein Passwort haben - wird wissen, dass Sie ein Passwort haben ...";

            public static String OldPasswordFail =
                "Das vom Ihnen eingegebene aktuelle Passwort stimmt nicht mit unseren Daten überein.";

            public static String EmptyPasswordFail =
                "Wir wissen ja, dass es manchmal lästig ist, müssen aber auf einem Passwort bestehen.";

            public static String NewPasswordFail =
                "Die Eingaben für das neue Passwort stimmen nicht überein.";
        }

        public struct Errors
        {
            public static string NotFound =
                "Nehmen Sie es uns nicht übel, aber wir konnten sie nicht identifizieren. Bitte versuchen Sie es noch einaml.";
        }
    }
}