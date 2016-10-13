using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco_Vol_1.Models
{
    public class SignInModel
    {
        public int Id { get; set; }

        public string MailAddress { get; set; }

        public string Password { get; set; }

        public string Message { get; set; }
    }
}
