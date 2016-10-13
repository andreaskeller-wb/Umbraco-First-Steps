using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
using Umbraco.Web.Mvc;
using Umbraco.Web.Models;
using Umbraco.Web.PublishedContentModels;
using Umbraco_Vol_1.Models;
using Umbraco_Vol_1.Constants;
using Workbooster.Common.Umbraco.Helpers;

namespace Umbraco_Vol_1.Controllers
{
    public class SignInSurfaceController : SurfaceController
    {
        public ActionResult ShowForm()
        {
            SignInModel signInInfo = new SignInModel();

            switch (Convert.ToInt32(Request.Params.Get(CoCon.Request.Error)))
            {
                case 1:
                    signInInfo.Message = CoCon.Errors.NotFound;
                    break;
                default:
                    signInInfo.Message = "";
                    break;
            }
            return PartialView(CoCon.Views.SignInForm, signInInfo);
        }

        public ActionResult HandleFormPost(SignInModel signInInfo)
        {
            bool customerfound=false;

            if (!String.IsNullOrWhiteSpace(signInInfo.MailAddress) &&
                !String.IsNullOrWhiteSpace(signInInfo.Password))
            {
                IPublishedContent addressCollection = WbUmbraco.GetContentByName(CurrentPage, CoCon.Address.CollexctionName);

                if (addressCollection != null)
                {
                    foreach (var address in addressCollection.Children)
                    {
                        if ((string)address.Properties.FirstOrDefault(
                            prp => prp.PropertyTypeAlias == CoCon.Address.Mail).Value == signInInfo.MailAddress &&
                           (string)address.Properties.FirstOrDefault(
                            prp => prp.PropertyTypeAlias == CoCon.Address.Password).Value == signInInfo.Password)
                        {
                            IContent addressContent = Services.ContentService.GetById(address.Id);

                            Session[CoCon.Customer.Id] = address.Id;
                            Session[CoCon.Customer.CustomerId] = addressContent.GetValue(CoCon.Address.CustomerId);
                            Session[CoCon.Customer.CustomerName] = address.Name;

                            customerfound = true;
                            break;
                        }
                    }
                }
                var caller = Request.Params.Get(CoCon.Request.Caller);

                if (customerfound)
                {
                    if (caller != null)
                    {
                        return RedirectToUmbracoPage(Convert.ToInt32(Request.Params.Get(CoCon.Request.Caller)));
                    }
                    else
                    {
                        return RedirectToUmbracoPage(CurrentPage.Parent.Id);
                    }
                }
                else
                {
                    Session.Remove(CoCon.Customer.CustomerId);
                    Session.Remove(CoCon.Customer.CustomerName);

                    return RedirectToCurrentUmbracoPage(String.Format("{0}={1}", CoCon.Request.Error, 1));
                }
            }
            return RedirectToUmbracoPage(CurrentPage.Parent.Id);
        }
    }
}