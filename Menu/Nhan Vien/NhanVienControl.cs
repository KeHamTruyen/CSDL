using btll.Menu;
using btll.Menu.Nhan_Vien;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace btll
{
    public partial class NhanVienControl : UserControl
    {
        public NhanVienControl()
        {
            InitializeComponent();
        }

        private void NhanVienControl_Load(object sender, EventArgs e)
        {
            SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();

            SqlCommand sqlCmd1 = new SqlCommand();
            sqlCmd1.CommandType = CommandType.Text;
            sqlCmd1.CommandText = "EXEC sp_GetEmployeeAndBranch;";
            sqlCmd1.Connection = sqlCon;

            SqlDataReader reader1 = sqlCmd1.ExecuteReader();

            listNV.Items.Clear();
            textTen.Text = string.Empty;
            textNgaysinh.Text = string.Empty;
            textCCCD.Text = string.Empty;
            textDiachi.Text = string.Empty;
            textEmail.Text = string.Empty;
            textSTK.Text = string.Empty;

            while (reader1.Read())
            {
                string hoten = reader1.GetString(0);
                string maNV = reader1.GetString(1);
                string chinhanh = reader1.GetString(3);
                string thanhpho = reader1.GetString(4);
                listNV.Items.Add(maNV + ". " + hoten + "-" + chinhanh + "-" + thanhpho);
            }

            reader1.Close();

            SqlCommand sqlCmd2 = new SqlCommand();
            sqlCmd2.CommandType = CommandType.Text;
            sqlCmd2.CommandText = "select Ten from ChiNhanh;";
            sqlCmd2.Connection = sqlCon;

            SqlDataReader reader2 = sqlCmd2.ExecuteReader();

            comboCN.SelectedIndex = -1;
            comboCN.Items.Clear();
            while (reader2.Read())
            {
                string tenCN = reader2.GetString(0);
                comboCN.Items.Add(tenCN);
            }

            reader2.Close();

            sqlCon.Close();
        }

        private void comboCN_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboCN.SelectedIndex == -1) { return; }

            listNV.Items.Clear();
            string tenCN = comboCN.SelectedItem.ToString();

            SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();

            SqlCommand sqlCmd1 = new SqlCommand();
            sqlCmd1.CommandType = CommandType.Text;
            sqlCmd1.CommandText = "EXEC sp_GetEmployeeAndBranch @TenChiNhanh = '" + tenCN +"';";
            sqlCmd1.Connection = sqlCon;

            SqlDataReader reader1 = sqlCmd1.ExecuteReader();

            listNV.Items.Clear();
            textTen.Text = string.Empty;
            textNgaysinh.Text = string.Empty;
            textCCCD.Text = string.Empty;
            textDiachi.Text = string.Empty;
            textEmail.Text = string.Empty;
            textSTK.Text = string.Empty;

            while (reader1.Read())
            {
                string hoten = reader1.GetString(0);
                string maNV = reader1.GetString(1);
                string chinhanh = reader1.GetString(3);
                string thanhpho = reader1.GetString(4);
                listNV.Items.Add(maNV + ". " + hoten + "-" + chinhanh + "-" + thanhpho);
            }

            reader1.Close();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            string searchText = textBox1.Text.Trim().ToLower();
            NhanVienControl_Load(sender, e);
            // Create a temporary list of items to keep
            List<string> itemsToKeep = new List<string>();

            // Loop through the items in the ListView and check the name
            foreach (string item in listNV.Items)
            {
                // Check if the item's text contains the search text
                if (item.ToLower().Contains(searchText))
                {
                    // If a match is found, add the item to the temporary list
                    itemsToKeep.Add(item);
                }
            }

            // Clear all items in the ListView
            listNV.Items.Clear();

            // Add the items from the temporary list back to the ListView
            foreach (string item in itemsToKeep)
            {
                listNV.Items.Add(item);
            }
        }

        private void resetButton_Click(object sender, EventArgs e)
        {
            NhanVienControl_Load(sender, e);
        }

        private void listNV_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listNV.SelectedIndex == -1) { return; }
            string line = listNV.SelectedItem.ToString().Split('.')[0];
            string cmd = "SELECT * FROM NhanVien WHERE MaNhanVien = @maNV;";

            SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.Text;
            sqlCmd.CommandText = cmd;
            sqlCmd.Parameters.AddWithValue("@maNV", line);
            sqlCmd.Connection = sqlCon;
            SqlDataReader reader = sqlCmd.ExecuteReader();

            if (reader.Read())
            {
                textTen.Text = reader.GetString(0);
                textCCCD.Text = reader.GetString(2);
                textNgaysinh.Text = reader.GetDateTime(3).ToString();
                textEmail.Text = reader.GetString(6);
                textDiachi.Text = reader.GetString(4);
                textSTK.Text = reader.GetString(7);
            }
            reader.Close();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ThemNVForm themNVForm = new ThemNVForm();
            themNVForm.ShowDialog();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (listNV.SelectedIndex == -1)
            {
                MessageBox.Show("Chọn nhân viên cần sửa");
                return;
            }
            string manv = listNV.SelectedItem.ToString().Split('.')[0];
            SuaNVForm suaNVForm = new SuaNVForm(manv, textTen.Text, textCCCD.Text, textDiachi.Text, textEmail.Text, textSTK.Text);
            suaNVForm.ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if(listNV.SelectedIndex == -1)
            {
                MessageBox.Show("Chon nhan vien can xoa!");
                return;
            }

            SqlHelper sqlHelper = new SqlHelper();
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@MaNhanVien", listNV.SelectedItem.ToString().Split('.')[0]),
            };

            sqlHelper.ExecuteProcedure("sp_DeleteNhanVien", parameters);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            TinhLuongNVForm tinhLuongNVForm = new TinhLuongNVForm();
            tinhLuongNVForm.ShowDialog();
        }
    }
}
