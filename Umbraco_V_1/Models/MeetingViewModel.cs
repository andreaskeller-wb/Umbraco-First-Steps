using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco_Vol_1.Models
{
    public class MeetingViewModel
    {
        public Meeting SingleMeeting { get; set; }

        public List<Meeting> Meetings { get; set; }

        public MeetingViewModel()
        {
            Meetings = new List<Meeting>();
        }
    }
}