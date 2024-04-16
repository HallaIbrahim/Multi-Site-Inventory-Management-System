using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace Finall
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        SqlConnection con = new SqlConnection("Data Source=HALLA-IBRAHIM\\MAIN;Initial Catalog=master;Persist Security Info=True;User ID=sa;Password=123456;Encrypt=False");
        String db="";

        private void button2_Click(object sender, EventArgs e)
        {
            if (radioButton1.Checked == true)
            {
                db = "AddInventoryA";
            }
            else if (radioButton2.Checked == true)
            {
                db = "AddInventoryB";
            }
            else
            {
                db = "AddInventoryAB";
            }
            con.Open();

            SqlCommand cmd = new SqlCommand(db,con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProductID", int.Parse(textBox1.Text));
            cmd.Parameters.AddWithValue("@BarCode", textBox2.Text);
            cmd.Parameters.AddWithValue("@ProductName", textBox3.Text);
            cmd.Parameters.AddWithValue("@Quantity", int.Parse(textBox4.Text));
            cmd.ExecuteNonQuery();
            con.Close();
            MessageBox.Show("successfully saved");

        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (radioButton1.Checked == true)
            {
                db = "UpdateInventoryA";
            }
            else if (radioButton2.Checked == true)
            {
                db = "UpdateInventoryB";
            }
            else
            {
                db = "UpdateInventoryAB";
            }
            con.Open();

            SqlCommand cmd = new SqlCommand(db, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProId", int.Parse(textBox1.Text));
            cmd.Parameters.AddWithValue("@BarCode", textBox2.Text);
            cmd.Parameters.AddWithValue("@PName", textBox3.Text);
            cmd.Parameters.AddWithValue("@Quantity", int.Parse(textBox4.Text));
            cmd.ExecuteNonQuery();
            con.Close();
            MessageBox.Show("successfully updated");
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (radioButton1.Checked == true)
            {
                db = "DeleteProduct";
            }
            else if (radioButton2.Checked == true)
            {
                db = "DeleteProductB";
            }
            else
            {
                db = "DeleteProductAB";
            }
            con.Open();

            SqlCommand cmd = new SqlCommand(db, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProId", int.Parse(textBox1.Text));
            cmd.ExecuteNonQuery();
            con.Close();
            MessageBox.Show("successfully deleted");
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }
    }
}
