using System;
using WebSite.Models;
using System.Reflection;

namespace WebSite.Models
{
    class ReportTableModelData
    {
        public ReportDataModel CreateModel(string conection)
        {
            var data = new ReportDataModel();

            Type type = typeof(FlagModel);
            var flagmodel = Activator.CreateInstance(type);
            MethodInfo method = type.GetMethod("GetFlag", BindingFlags.NonPublic | BindingFlags.Instance);
            var flag = (string) method.Invoke(flagmodel, null);
            
            data.Title = flag;
            return data;
        }
    }
}