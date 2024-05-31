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
    public partial class Mainform : Form
    {
        SqlConnection sqlCon = null;

        public Mainform()
        {
            InitializeComponent();

            sqlCon = DatabaseConnection.Instance.GetConnection();
            try
            {
                MessageBox.Show("Ket noi voi CSDL thanh cong");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            sqlCon.Close();

            trangChuControl1.DathangButtonTCC_Clicked += DatHangButton_Click;
            trangChuControl1.ChinhanhButtonTCC_Clicked += ChiNhanhButton_Click;
            trangChuControl1.KhachhangButtonTCC_Clicked += KhachHangButton_Click;
            trangChuControl1.NhanvienButtonTCC_Clicked += NhanVienButton_Click;
            trangChuControl1.SanphamButtonTCC_Clicked += SanPhamButton_Click;
            trangChuControl1.KhuyenmaiButtonTCC_Clicked += KhuyenMaiButton_Click;

            chiNhanhControl1.DSButtonCNC_Clicked += DSButtonCNC_Click;
            chiNhanhControl1.HDButtonCNC_Clicked += HDButtonCNC_Click;
            chiNhanh_DanhsachControl1.delButton_Clicked += DSButtonCNC_Click;

            trangChuControl1.BringToFront();

        }

        private void ChiNhanh_DanhsachControl1_inButton_Clicked(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        private void TrangChuButton_Click(object sender, EventArgs e)
        {
            SidePanel.Height = TrangChuButton.Height;
            SidePanel.Top = TrangChuButton.Top;
            trangChuControl1.BringToFront();
        }

        private void DatHangButton_Click(object sender, EventArgs e)
        {
            SidePanel.Height = DatHangButton.Height;
            SidePanel.Top = DatHangButton.Top;
            datHangControl1.BringToFront();
        }

        private void ChiNhanhButton_Click(object sender, EventArgs e)
        {
            SidePanel.Height = ChiNhanhButton.Height;
            SidePanel.Top = ChiNhanhButton.Top;
            chiNhanhControl1.BringToFront();
        }

        private void NhanVienButton_Click(object sender, EventArgs e)
        {
            SidePanel.Height = NhanVienButton.Height;
            SidePanel.Top = NhanVienButton.Top;
            nhanVienControl1.BringToFront();
        }

        private void KhachHangButton_Click(object sender, EventArgs e)
        {
            SidePanel.Height = KhachHangButton.Height;
            SidePanel.Top = KhachHangButton.Top;
            khachHangControl1.BringToFront();
        }

        private void SanPhamButton_Click(object sender, EventArgs e)
        {
            SidePanel.Height = SanPhamButton.Height;
            SidePanel.Top = SanPhamButton.Top;
            sanPhamControl1.BringToFront();
        }

        private void KhuyenMaiButton_Click(object sender, EventArgs e)
        {
            SidePanel.Height = KhuyenMaiButton.Height;
            SidePanel.Top = KhuyenMaiButton.Top;
            khuyenMaiControl1.BringToFront();
        }

        private void DSButtonCNC_Click(object sender, EventArgs e)
        {
            chiNhanh_DanhsachControl1.ChiNhanh_DanhsachControl_Load();
            chiNhanh_DanhsachControl1.BringToFront();
        }

        private void HDButtonCNC_Click(object sender, EventArgs e)
        {
            cN_HDControl1.CN_HDControl_Load(sender, e);
            cN_HDControl1.BringToFront();
        }

    }
}
