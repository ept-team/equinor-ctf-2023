using System;
using System.Data;
using System.Data.Common;
using Microsoft.Data.Sqlite;
using System.Text;
using Microsoft.EntityFrameworkCore.ValueGeneration.Internal;
using Microsoft.EntityFrameworkCore;
using S = System;
using WebSite.Models;
using System.Collections;
using System.Collections.Generic;

namespace WebSite.Models
{
    class ReportTableModelData
    {
        public ReportDataModel CreateModel(string conection)
        {
            var flag = S.IO.File.ReadAllText("appsettings.json");
            var data = new ReportDataModel();
            data.Headers.Add("Shit");

            var row = new List<string>();
            row.Add(flag);
            data.Data.Add(row);

            return data;
        }
    }
}
