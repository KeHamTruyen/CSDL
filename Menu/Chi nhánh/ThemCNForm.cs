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
    public partial class ThemCNForm : Form
    {
        public ThemCNForm()
        {
            InitializeComponent();
        }

        private void themButton_Click(object sender, EventArgs e)
        {
            if (textTen.Text == "" || textSDT.Text == "" || textSonha.Text =="" || textDuong.Text == "" || textPhuong.Text == "" || textQuan.Text == "" || textThanhpho.Text == "" || textThoigian.Text == "")
            {
                MessageBox.Show("Nhap thieu thong tin");
                return;
            }
            SqlHelper sqlHelper = new SqlHelper();
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Ten", textTen.Text),
                new SqlParameter("@SDT", textSDT.Text),
                new SqlParameter("@SoNha", textSonha.Text),
                new SqlParameter("@Duong", textDuong.Text),
                new SqlParameter("@Phuong", textPhuong.Text),
                new SqlParameter("@Quan", textQuan.Text),
                new SqlParameter("@ThanhPho", textThanhpho.Text),
                new SqlParameter("@ThoiGianHoatDong", textThoigian.Text),
            };
            sqlHelper.ExecuteProcedure("in_ChiNhanh", parameters);
        }
    }
}
