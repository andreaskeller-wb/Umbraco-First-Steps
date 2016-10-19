using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;
using Umbraco_Vol_1.Models;

namespace Umbraco_Vol_1.Controllers
{
    public class ContactSurfaceController : SurfaceController
    {
        public ActionResult ShowForm()
        {
            ContactModel myModel = new ContactModel();

            return PartialView("ContactForm", myModel);
        }

        public ActionResult HandleFormPost(ContactModel model)
        {
            var newContent = 
                Services.ContentService.CreateContent(model.Name + " - " + DateTime.Now.ToString("dd.MM.yyyy/HH:mm"), CurrentPage.Id, "ContactFormula");

            newContent.SetValue("emailFrom", model.Email);
            newContent.SetValue("contactName", model.Name);
            newContent.SetValue("contactMessage", model.Message);

            Services.ContentService.SaveAndPublishWithStatus(newContent);

            return RedirectToCurrentUmbracoPage();
        }
    }
}