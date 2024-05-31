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
    public partial class SuaCNForm : Form
    {
        public SuaCNForm(string ten, string sdt, string sonha, string duong, string phuong, string quan, string tp, string thoigian)
        {
            InitializeComponent();
            textTen.Text = ten;
            textSDT.Text = sdt;
            textSonha.Text = sonha;
            textDuong.Text = duong;
            textPhuong.Text = phuong;
            textQuan.Text = quan;
            textThanhpho.Text = tp;
            textThoigian.Text = thoigian;
        }

        private void luuButton_Click(object sender, EventArgs e)
        {
            if (textTen.Text == "" || textSDT.Text == "" || textSonha.Text == "" || textDuong.Text == "" || textPhuong.Text == "" || textQuan.Text == "" || textThanhpho.Text == "" || textThoigian.Text == "")
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
            sqlHelper.ExecuteProcedure("up_ChiNhanh", parameters);
        }
    }
}
