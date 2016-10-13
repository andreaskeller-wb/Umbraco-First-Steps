using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text.RegularExpressions;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
using Umbraco.Core.Publishing;
using Umbraco.Web.Mvc;
using Umbraco.Web.Models;
using Umbraco.Web.PublishedContentModels;
using Umbraco_Vol_1.Models;
using Umbraco_Vol_1.Constants;
using Workbooster.Common.Umbraco.Helpers;

namespace Umbraco_Vol_1.Controllers
{
    public class CustomerProfileSurfaceController : SurfaceController
    {
        public ActionResult ShowForm()
        {
            IContent addressContent = Services.ContentService.GetById((int)Session[CoCon.Customer.Id]);
            CustomerProfileModel profileInfo = new CustomerProfileModel();

            profileInfo.WorkboosterNewsletter = addressContent.GetValue<bool>(CoCon.Address.WorkboosterNewsletter);
            profileInfo.ProffixNewsletter = addressContent.GetValue<bool>(CoCon.Address.ProffixNewsletter);
            profileInfo.TopalNewsletter = addressContent.GetValue<bool>(CoCon.Address.TopalNewsletter);
            profileInfo.MailAddress = addressContent.GetValue<string>(CoCon.Address.Mail);
            profileInfo.Phone = addressContent.GetValue<string>(CoCon.Address.Phone);
            profileInfo.DateOfBirth = addressContent.GetValue<DateTime>(CoCon.Address.DateOfBirth);

            profileInfo.Message = Request.Params.Get(CoCon.Request.Message);
            if (Request.Params.Get(CoCon.Request.MsgMail) != null)
                profileInfo.MessageMailAddress =   
                    String.Format(ComCon.SaveErrorsDict[Request.Params.Get(CoCon.Request.MsgMail)], 
                    addressContent.Properties["Mail"].PropertyType.ValidationRegExp);
            if (Request.Params.Get(CoCon.Request.MsgPhone) != null)
                profileInfo.MessagePhone = ComCon.SaveErrorsDict[Request.Params.Get(CoCon.Request.MsgPhone)];
            if (Request.Params.Get(CoCon.Request.MsgBirth) != null)
                profileInfo.MessageDateOfBirth = ComCon.SaveErrorsDict[Request.Params.Get(CoCon.Request.MsgBirth)];

            return PartialView(CoCon.Views.CustomerProfileForm, profileInfo);
        }

        public ActionResult HandleFormPost(CustomerProfileModel profileInfo)
        {
            string message = "";
            bool success = false;

            IContent addressContent = Services.ContentService.GetById((int)Session[CoCon.Customer.Id]);

            addressContent.SetValue(CoCon.Address.WorkboosterNewsletter, profileInfo.WorkboosterNewsletter);
            addressContent.SetValue(CoCon.Address.ProffixNewsletter, profileInfo.ProffixNewsletter);
            addressContent.SetValue(CoCon.Address.TopalNewsletter, profileInfo.TopalNewsletter);
            addressContent.SetValue(CoCon.Address.Mail, profileInfo.MailAddress);
            addressContent.SetValue(CoCon.Address.Phone, profileInfo.Phone);
            addressContent.SetValue(CoCon.Address.DateOfBirth, profileInfo.DateOfBirth);

            if (profileInfo.ChangePassword)
            {
                if (!String.IsNullOrWhiteSpace(profileInfo.OldPassword))
                {
                    if (profileInfo.OldPassword == addressContent.GetValue<string>(CoCon.Address.Password))
                    {
                        if (!String.IsNullOrWhiteSpace(profileInfo.NewPassword1))
                        {
                            if (profileInfo.NewPassword1 == profileInfo.NewPassword2)
                            {
                                addressContent.SetValue(CoCon.Address.Password, profileInfo.NewPassword1);

                                success = true;
                                message = CoCon.ProfilrMessages.PasswordSuccess;
                            }
                            else
                                message = CoCon.ProfilrMessages.NewPasswordFail;
                        }
                        else
                            message = CoCon.ProfilrMessages.EmptyPasswordFail;
                    }
                    else
                        message = CoCon.ProfilrMessages.OldPasswordFail;
                }
                else
                    message = CoCon.ProfilrMessages.NoPassword;
            }
            else
            {
                success = true;
                message = CoCon.ProfilrMessages.UpdateSuccess;
            }
            message = String.Format("message={0}", message);

            var publishResult = Services.ContentService.SaveAndPublishWithStatus(addressContent, raiseEvents: true);

            if (!publishResult.Success)
            {
                if (success)
                    message = "";
                success = false;

                foreach (SaveError error in PublishErrors(publishResult.Result))
                {
                    if (error.Alias == CoCon.Address.Mail)
                        message = String.Format("{0}?{1}={2}", message, CoCon.Request.MsgMail, error.ErrorKey);
                    else if (error.Alias == CoCon.Address.Phone)
                        message = String.Format("{0}?{1}={2}", message, CoCon.Request.MsgPhone, error.ErrorKey);
                    else if (error.Alias == CoCon.Address.DateOfBirth)
                        message = String.Format("{0}?{1}={2}", message, CoCon.Request.MsgBirth, error.ErrorKey);
                }
                message = message.TrimStart(new char[] {'?'});
            }

            if (success)
                return RedirectToUmbracoPage(CurrentPage.Parent.Id, String.Format(message));
            else
                return RedirectToUmbracoPage(CurrentPage, String.Format(message));
        }

        private List<SaveError> PublishErrors(PublishStatus resultingStatus)
        {
            List<SaveError> errors = new List<SaveError>();

            foreach (Property property in resultingStatus.InvalidProperties)
            {
                bool done = false;

                if (property.PropertyType.Mandatory && property.Value == null)
                {
                    errors.Add(new SaveError { Alias = property.Alias, ErrorKey = "mand" });

                    done = true;
                }
                if (!done && property.PropertyType.ValidationRegExp != null)
                {
                    Regex regularExpression = new Regex(property.PropertyType.ValidationRegExp);

                    if (!regularExpression.IsMatch((string)property.Value))
                    {
                        errors.Add(new SaveError { Alias = property.Alias, ErrorKey = "regex" });

                        done = true;
                    }
                }
                if (!done)
                {
                    errors.Add(new SaveError { Alias = property.Alias, ErrorKey = "unknwn" });
                }
            }
            return errors;
        }
    }

    public class SaveError
    {
        public string Alias { get; set; }

        public string ErrorKey { get; set; }
    }

    public static class ComCon
    {
        public struct Errors
        {
            public static string IsMandatory = "This field is mandatory.";

            public static string HasRegExp = "This value requires a specific format ({0}).";

            public static string Unknown = "Something is wrong";
        }

        public static Dictionary<string, string> SaveErrorsDict = new Dictionary<string, string> 
        {   {"mand", "This field is mandatory."} ,
            {"regex","This value requires a specific format ({0})." },
            {"unknwn", "Something is wrong"}
        };
    }
}