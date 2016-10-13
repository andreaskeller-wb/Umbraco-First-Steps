using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco_Vol_1.Models
{
    public class CustomerProfileModel
    {
        public int CustomerId { get; set; }

        public bool WorkboosterNewsletter { get; set; }

        public bool ProffixNewsletter { get; set; }

        public bool TopalNewsletter { get; set; }

        public string MailAddress { get; set; }

        public string Phone { get; set; }

        public DateTime DateOfBirth { get; set; }

        public bool ChangePassword { get; set; }

        public string OldPassword { get; set; }

        public string NewPassword1 { get; set; }

        public string NewPassword2 { get; set; }

        public string Message { get; set; }

        public string MessageMailAddress { get; set; }

        public string MessagePhone { get; set; }

        public string MessageDateOfBirth { get; set; }
    }
}