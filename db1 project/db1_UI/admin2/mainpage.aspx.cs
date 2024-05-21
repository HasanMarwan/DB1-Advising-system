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
    public partial class mainpage : System.Web.UI.Page
    {
        
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["del"] == null)
                Session["del"] = "";
            if (Session["del1"] == null)
                Session["del1"] = "";
            if (Session["del2"] == null)
                Session["del2"] = "";
            if (Session["del3"] == null)
                Session["del3"] = "";
            if (Session["del4"] == null)
                Session["del4"] = "";
            if (Session["del5"] == null)
                Session["del5"] = "";
            if (Session["del6"] == null)
                Session["del6"] = "";
        }
        protected void All_Semesters(object sender, EventArgs e)
        {
            Response.Redirect("AllSemesters.aspx");


        }

        protected void Payment_Details(object sender, EventArgs e)
        {
            Response.Redirect("Payment_Details.aspx");
        }

        protected void Graduation_Plan(object sender, EventArgs e)
        {
            Response.Redirect("Graduation_Plan.aspx");

        }

        protected void Active_Students(object sender, EventArgs e)
        {
            Response.Redirect("Active_Students.aspx");
        }

        protected void Delete_Course(object sender, EventArgs e)
        {
          
                try
                {
                    string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);

                    int course_id = Int16.Parse(TextBox1.Text);
                if (!Session["del"].ToString().Contains(TextBox1.Text + ","))
                {
                    conn.Open();

                    SqlCommand loginFunc = new SqlCommand
                    {
                        Connection = conn,
                        CommandType = CommandType.StoredProcedure,
                        CommandText = "Procedures_AdminDeleteCourse"
                    };

                    loginFunc.Parameters.Add("@courseID", course_id);
                    loginFunc.ExecuteNonQuery();
                    conn.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('deletion successfull')", true);
                    Session["del"] += TextBox1.Text + ",";
                }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('wrong credentials:please enter a value and make sure that the course id should be an integer')", true);
                }
            
        }

        protected void Delete_Slots(object sender, EventArgs e)
        {
            
                try
                {
                    string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);

                    String semester_code = TextBox2.Text;

                if (semester_code.Length == 0)
                    throw new Exception();

                if (!Session["del1"].ToString().Contains(TextBox2.Text + ","))
                {
                    conn.Open();

                    SqlCommand loginFunc = new SqlCommand
                    {
                        Connection = conn,
                        CommandType = CommandType.StoredProcedure,
                        CommandText = "Procedures_AdminDeleteSlots"
                    };

                    loginFunc.Parameters.Add("@current_semester", semester_code);
                    loginFunc.ExecuteNonQuery();
                    conn.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('deletion successfull')", true);
                    Session["del1"] += TextBox2.Text + ",";
                }
                }
                catch (Exception ex)
                {
               
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('wrong credentials:please enter the semester code box (required)')", true);
                }
            
        }

        protected void Issue_Installment(object sender, EventArgs e)
        {
           
                try
                {
                    string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);

                    int payment_id = Int16.Parse(TextBox3.Text);
                if (!Session["del2"].ToString().Contains(TextBox3.Text + ","))
                {
                    conn.Open();

                    SqlCommand loginFunc = new SqlCommand
                    {
                        Connection = conn,
                        CommandType = CommandType.StoredProcedure,
                        CommandText = "Procedures_AdminIssueInstallment"
                    };

                    loginFunc.Parameters.Add("@payment_id", payment_id);
                    loginFunc.ExecuteNonQuery();
                    conn.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('deletion successfull')", true);
                    Session["del2"] += TextBox3.Text + ",";
                }
                }
                catch (Exception ex)
                {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('wrong credentials:please enter a value and make sure that the payment id should be an integer')", true);
            }

        }

        protected void UpdateStudentStatus(object sender, EventArgs e)
        {
            
                try
                {
                    string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                
                    int student_id = Int16.Parse(TextBox4.Text);
                if (!Session["del3"].ToString().Contains(TextBox4.Text + ","))
                {
                    conn.Open();

                    SqlCommand loginFunc = new SqlCommand
                    {
                        Connection = conn,
                        CommandType = CommandType.StoredProcedure,
                        CommandText = "Procedure_AdminUpdateStudentStatus"
                    };

                    loginFunc.Parameters.Add("@student_id", student_id);
                    loginFunc.ExecuteNonQuery();
                    conn.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('update successfull')", true);
                    Session["del3"] += TextBox4.Text + ",";
                }
                }
                catch (Exception ex)
                {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('wrong credentials:please enter a value and make sure that the student id should be an integer')", true);
            }

        }

        protected void Transcript_Details(object sender, EventArgs e)
        {
            Response.Redirect("Transcript_Details.aspx");
        }

        protected void add_exam(object sender, EventArgs e)
        {
            try
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                String type = Type.Text;
                String date = Date.Text;
                int course_id = Int16.Parse(Cid.Text);
                if (!Session["del4"].ToString().Contains(Type.Text + ",") && !Session["del5"].ToString().Contains(Date.Text + ",") && !Session["del6"].ToString().Contains(Cid.Text + ","))
                {
                    conn.Open();

                    SqlCommand loginFunc = new SqlCommand
                    {
                        Connection = conn,
                        CommandType = CommandType.StoredProcedure,
                        CommandText = "Procedures_AdminAddExam"
                    };

                    loginFunc.Parameters.Add("@Type", type);
                    loginFunc.Parameters.Add("@date", date);
                    loginFunc.Parameters.Add("@courseID", course_id);

                    loginFunc.ExecuteNonQuery();
                    conn.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('update successfull')", true);
                    Session["del4"] += Type.Text + ",";
                    Session["del5"] += Date.Text + ",";
                    Session["del4"] += Cid.Text + ",";
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('wrong credentials:please enter a value in exam type and date and course id boxes and make sure that the course id should be an integer')", true);
            }

        }
    }
}