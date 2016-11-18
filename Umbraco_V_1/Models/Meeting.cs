using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Umbraco_Vol_1.Models
{
    public class Meeting
    {
        [Key]
        public int MeetingId { get; set; }

        public string MeetingName { get; set; }
        
        public string Format { get; set; }
        
        public string Location { get; set; }

        public Meeting(int meetingId, string meetingName, string format, string location)
        {
            MeetingId = meetingId;
            MeetingName = meetingName;
            Format = format;
            Location = location;
        }
    }
}