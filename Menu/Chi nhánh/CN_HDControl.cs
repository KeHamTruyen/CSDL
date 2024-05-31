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

namespace btll.Menu.Chi_nhánh
{
    public partial class CN_HDControl : UserControl
    {
        public CN_HDControl()
        {
            InitializeComponent();
        }

        public void CN_HDControl_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;
            dataGridView1.Columns.Clear();
            dataGridView2.DataSource = null;
            dataGridView2.Columns.Clear();
            comboBox1.Items.Clear();
            comboBox1.Text = "";
            SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();

            SqlCommand sqlCmd1 = new SqlCommand();
            sqlCmd1.CommandType = CommandType.Text;
            sqlCmd1.CommandText = "select Ten from ChiNhanh;";
            sqlCmd1.Connection = sqlCon;
            SqlDataReader reader1 = sqlCmd1.ExecuteReader();
            comboBox1.Items.Clear();
            while (reader1.Read())
            {
                string tenCN = reader1.GetString(0);
                comboBox1.Items.Add(tenCN);
            }
            reader1.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex == -1)
            {
                MessageBox.Show("Chon chi nhanh");
                return;
            }
            SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();

            SqlCommand command = new SqlCommand("sp_XuatHoaDonTheoChiNhanhVaNgay", sqlCon);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@TenChiNhanh", comboBox1.SelectedItem.ToString());
            command.Parameters.AddWithValue("@NgayBatDau", dateTimePicker1.Value.ToString("yyyyMMdd"));
            command.Parameters.AddWithValue("@NgayKetThuc", dateTimePicker2.Value.ToString("yyyyMMdd"));

            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);

            sqlCon.Close();

            // Hiển thị dữ liệu trong DataGridView
            dataGridView1.DataSource = dataSet.Tables[0];
            dataGridView2.DataSource = dataSet.Tables[1];
        }

        private void button2_Click(object sender, EventArgs e)
        {
            CN_HDControl_Load(sender, e);
        }
    }
}
