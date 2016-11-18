using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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
    public class MeetingSurfaceController : SurfaceController
    {
        public ActionResult ShowForm()
        {
            MeetingViewModel meetingContext = new MeetingViewModel();

            meetingContext.Meetings.Add(new Meeting(1, "Operational", "Audit", "Mumbai"));
            meetingContext.Meetings.Add(new Meeting(2, "HR", "Audit", "Mumbai"));
            meetingContext.Meetings.Add(new Meeting(3, "ITRetails", "Functional", "Dehradun"));
            meetingContext.Meetings.Add(new Meeting(4, "Marketing", "Business", "Bangalore"));
            meetingContext.Meetings.Add(new Meeting(5, "SAP", "Audit", "Dehradun"));

            return PartialView("MeetingForm", meetingContext);
        }

        [ChildActionOnly]
        public ActionResult APostBack(MeetingViewModel meetingContext)
        {
            return PartialView(meetingContext); 
        }

        public ActionResult HandleFormPost(MeetingViewModel meetingContext)
        {
            return RedirectToUmbracoPage(CurrentPage.Parent.Id);
        }
    }
}