using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Umbraco.Core.Models;

namespace Workbooster.Common.Umbraco.Helpers
{
    public static class WbUmbraco
    {
        public static IPublishedContent GetContentByName(IPublishedContent currentContent, string requetedContent)
        {
            foreach (IPublishedContent content in GetGodfather(currentContent).ContentSet)
            {
                if (content.Name == requetedContent)
                {
                    return content;
                }
            }
            return null;
        }

        public static IPublishedContent GetGodfather(IPublishedContent currentContent)
        {
            while (currentContent.Parent != null)
            {
                currentContent = currentContent.Parent;
            }
            return currentContent;
        }

        public static T GetValue<T>(IPublishedContent umbarcoContent, string propertyTypeAlias)
        {
            object rawValue = umbarcoContent.Properties.FirstOrDefault(prp => prp.PropertyTypeAlias == propertyTypeAlias).Value;

            if (rawValue != null)
            {
                return (T)rawValue;
            }
            return default(T);
        }

        public static void SetValue<T>(IPublishedContent umbarcoContent, string propertyTypeAlias, T value)
        {
            // umbarcoContent.Properties.FirstOrDefault(prp => prp.PropertyTypeAlias == propertyTypeAlias).;
        }
    }
}
