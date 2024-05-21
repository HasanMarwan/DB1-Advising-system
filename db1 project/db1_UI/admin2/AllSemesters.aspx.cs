using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace admin2
{
    public partial class AllSemesters : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (var cmd = new SqlCommand("select * from Semster_offered_Courses", conn))
                {
                    try
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            GridView1.DataSource = reader;
                            GridView1.DataBind();
                        }
                        else
                        {
                            Response.Write("no records");
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                    }
                }
            }
        }
    }
}
    
