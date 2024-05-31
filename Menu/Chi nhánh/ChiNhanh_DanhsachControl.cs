using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using btll.Menu.Chi_nhánh;

namespace btll
{
    public partial class ChiNhanh_DanhsachControl : UserControl
    {
        public ThemCNForm themCNForm = null;
        public SuaCNForm suaCNForm = null;
        public ChiNhanh_DanhsachControl()
        {
            InitializeComponent();
        }

        public void ChiNhanh_DanhsachControl_Load()
        {
            SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.Text;
            sqlCmd.CommandText = "SELECT Ten FROM ChiNhanh";

            sqlCmd.Connection = sqlCon;

            SqlDataReader reader = sqlCmd.ExecuteReader();

            listTenCN.Items.Clear();
            textTen.Text = string.Empty;
            textSDT.Text = string.Empty;
            textThoigianhoatdong.Text = string.Empty;
            textQuanly.Text = string.Empty;
            textDiachi.Text = string.Empty;

            while (reader.Read())
            {
                string tenChiNhanh = reader.GetString(0);

                listTenCN.Items.Add(tenChiNhanh);
            }

            sqlCon.Close();
        }

        private void listTenCN_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listTenCN.SelectedIndex == -1) { return; }

            string line = listTenCN.SelectedItem.ToString();
            string cmd = "SELECT * FROM ChiNhanh WHERE Ten = @ten;";

            SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.Text;
            sqlCmd.CommandText = cmd;
            sqlCmd.Parameters.AddWithValue("@ten", line);
            sqlCmd.Connection = sqlCon;
            SqlDataReader reader = sqlCmd.ExecuteReader();

            if (reader.Read())
            {
                textTen.Text = reader.GetString(0);
                textSDT.Text = reader.GetString(1);
                textDiachi.Text = reader.GetString(2) + "- " + reader.GetString(3) + "- " + reader.GetString(4) + "- " + reader.GetString(5) + "- " + reader.GetString(6);
                textThoigianhoatdong.Text = reader.GetString(7);
            }

            reader.Close();

            string anotherCmd = "SELECT NhanVien.HoVaTen FROM ChiNhanh LEFT JOIN ChiNhanh_QuanLy ON ChiNhanh.Ten = ChiNhanh_QuanLy.TenChiNhanh LEFT JOIN NhanVien ON ChiNhanh_QuanLy.MaNhanVien = NhanVien.MaNhanVien WHERE ChiNhanh.Ten = @tenChiNhanh;";
            SqlCommand anotherSqlCmd = new SqlCommand();
            anotherSqlCmd.CommandType = CommandType.Text;
            anotherSqlCmd.CommandText = anotherCmd;
            anotherSqlCmd.Parameters.AddWithValue("@tenChiNhanh", line);
            anotherSqlCmd.Connection = sqlCon;
            SqlDataReader anotherReader = anotherSqlCmd.ExecuteReader();

            if (anotherReader.Read())
            {
                textQuanly.Text = anotherReader.IsDBNull(0) ? "Chua co" : anotherReader.GetString(0);
            }

            anotherReader.Close();
            sqlCon.Close();
        }

        public event EventHandler delButton_Clicked;
        public void delButton_Click(object sender, EventArgs e)
        {
            if (listTenCN.SelectedIndex == -1)
            {
                MessageBox.Show("Chon chi nhanh can xoa!");
                return;
            }

            SqlHelper sqlHelper = new SqlHelper();
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Ten", listTenCN.SelectedItem.ToString()),
            };

            sqlHelper.ExecuteProcedure("de_ChiNhanh", parameters);
            delButton_Clicked?.Invoke(this, e);

        }

        private void inButton_Click(object sender, EventArgs e)
        {
            themCNForm = new ThemCNForm();
            themCNForm.FormClosed += ThemCNForm_FormClosed;
            themCNForm.ShowDialog();
        }

        private void ThemCNForm_FormClosed(object sender, FormClosedEventArgs e)
        {
            ChiNhanh_DanhsachControl_Load();
        }


        private void resetButton_Click(object sender, EventArgs e)
        {
            ChiNhanh_DanhsachControl_Load();
        }

        private void upButton_Click(object sender, EventArgs e)
        {
            if (listTenCN.SelectedIndex == -1)
            {
                MessageBox.Show("Chon chi nhanh can sua!");
                return;
            }

            string Ten = listTenCN.SelectedItem.ToString();
            string SDT;
            string Sonha;
            string Duong;
            string Phuong;
            string Quan;
            string Thanhpho;
            string Thoigianhoatdong;
            string cmd = "SELECT * FROM ChiNhanh WHERE Ten = @ten;";

            SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.Text;
            sqlCmd.CommandText = cmd;
            sqlCmd.Parameters.AddWithValue("@ten", Ten);
            sqlCmd.Connection = sqlCon;
            SqlDataReader reader = sqlCmd.ExecuteReader();

            if (reader.Read())
            {
                Ten = reader.GetString(0);
                SDT = reader.GetString(1);
                Sonha = reader.GetString(2);
                Duong = reader.GetString(3);
                Phuong = reader.GetString(4);
                Quan = reader.GetString(5);
                Thanhpho = reader.GetString(6);
                Thoigianhoatdong = reader.GetString(7);

                suaCNForm = new SuaCNForm(Ten, SDT, Sonha, Duong, Phuong, Quan, Thanhpho, Thoigianhoatdong);
                suaCNForm.FormClosed += suaCNForm_FormClosed;

                suaCNForm.ShowDialog();
            }

            reader.Close();
        }

        private void suaCNForm_FormClosed(object sender, FormClosedEventArgs e)
        {
            ChiNhanh_DanhsachControl_Load();
        }
}
}
