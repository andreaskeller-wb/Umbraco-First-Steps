using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco_Vol_1.Models
{
    public class ContactModel
    {
        public int id { get; set; }

        public string Email { get; set; }

        public string Name { get; set; }

        public string Message { get; set; }
    }
}