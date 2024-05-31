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

namespace btll
{
    public partial class DatHangControl : UserControl
    {
        public DatHangControl()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            listView1.Items.Clear();
            comboBox4.Text = string.Empty;
            textBox2.Text = string.Empty;

            if (comboBox1.SelectedIndex == -1 || comboBox2.SelectedIndex == -1 || comboBox3.SelectedIndex == -1)
            {
                MessageBox.Show("Chon du thong tin");
                return;
            }

            SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();

            SqlCommand sqlCmd1 = new SqlCommand();
            sqlCmd1.Connection = sqlCon;
            sqlCmd1.CommandType = CommandType.Text;
            string maDH = "DH" + DateTime.Now.ToString("ddHHmmss");
            sqlCmd1.CommandText = "INSERT INTO DonHang(MaDonHang, ThoiGianTao, MaKhuyenMai, MaKhachHang) VALUES (@MaDonHang, @ThoiGianTao, 'KM00000000', 'KH00000000');";
            sqlCmd1.Parameters.AddWithValue("@MaDonHang", maDH);
            sqlCmd1.Parameters.AddWithValue("@ThoiGianTao", DateTime.Now.ToString("yyyy - MM - dd HH:mm:ss"));
            sqlCmd1.ExecuteNonQuery();

            SqlCommand sqlCmd2 = new SqlCommand();
            sqlCmd2.Connection = sqlCon;
            sqlCmd2.CommandType = CommandType.Text;
            string maHD = "HD" + DateTime.Now.ToString("ddHHmmss");
            sqlCmd2.CommandText = "INSERT INTO HoaDon(MaHoaDon, ThoiGianXuat, TongSoLuongSanPham, TongTien, SoTienDuocGiam, TenChiNhanh, MaGiaoDich) VALUES (@MaHoaDon, @ThoiGianXuat, 0, 0, 0, @TenChiNhanh, 'GD00000000');";
            sqlCmd2.Parameters.AddWithValue("@MaHoaDon", maHD);
            sqlCmd2.Parameters.AddWithValue("@ThoiGianXuat", DateTime.Now.ToString("yyyy - MM - dd"));
            sqlCmd2.Parameters.AddWithValue("@TenChiNhanh", comboBox1.SelectedItem.ToString());
            sqlCmd2.ExecuteNonQuery();

            SqlCommand sqlCmd3 = new SqlCommand();
            sqlCmd3.Connection = sqlCon;
            sqlCmd3.CommandType = CommandType.Text;
            sqlCmd3.CommandText = "INSERT INTO XuatHoaDon VALUES (@MaHoaDon, @MaDonHang, @MaNhanVien);";
            sqlCmd3.Parameters.AddWithValue("@MaHoaDon", maHD);
            sqlCmd3.Parameters.AddWithValue("@MaDonHang", maDH);
            sqlCmd3.Parameters.AddWithValue("@MaNhanVien", comboBox2.SelectedItem.ToString().Split('.')[0]);
            sqlCmd3.ExecuteNonQuery();

            sqlCon.Close();

            textBox3.Text = maDH;
        }

        private void DatHangControl_Load(object sender, EventArgs e)
        {
            comboBox2.Items.Clear();
            comboBox3.Items.Clear();

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

            SqlCommand sqlCmd2 = new SqlCommand();
            sqlCmd2.CommandType = CommandType.Text;
            sqlCmd2.CommandText = "select TenSanPham, MaSanPham from SanPham;";
            sqlCmd2.Connection = sqlCon;
            SqlDataReader reader2 = sqlCmd2.ExecuteReader();
            comboBox4.Items.Clear();
            while (reader2.Read())
            {
                string tenSP = reader2.GetString(0);
                string maSP = reader2.GetString(1);

                comboBox4.Items.Add(maSP + ". " + tenSP);
            }
            reader2.Close();

            sqlCon.Close();
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex == -1) { return; }
            
            comboBox2.Items.Clear();
            comboBox3.Items.Clear();
            comboBox2.Text = "";
            comboBox3.Text = "";

            SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();

            SqlCommand sqlCmd1 = new SqlCommand();
            sqlCmd1.CommandType = CommandType.Text;
            sqlCmd1.CommandText = "select MaBan from BAN where TenChiNhanh = '" + comboBox1.SelectedItem.ToString() + "';";
            sqlCmd1.Connection = sqlCon;
            SqlDataReader reader1 = sqlCmd1.ExecuteReader();
            comboBox3.Items.Clear();
            while (reader1.Read())
            {
                string maBan = reader1.GetString(0);
                comboBox3.Items.Add(maBan);
            }
            reader1.Close();

            SqlCommand sqlCmd2 = new SqlCommand();
            sqlCmd2.CommandType = CommandType.Text;
            sqlCmd2.CommandText = "select HoVaTen, MaNhanVien from NhanVien where TenChiNhanh = '" + comboBox1.SelectedItem.ToString() + "';";
            sqlCmd2.Connection = sqlCon;
            SqlDataReader reader2 = sqlCmd2.ExecuteReader();
            comboBox2.Items.Clear();
            while (reader2.Read())
            {
                string tenNV = reader2.GetString(0);
                string maNV = reader2.GetString(1);
                comboBox2.Items.Add(maNV + ". " + tenNV);
            }
            reader2.Close();

            sqlCon.Close();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (textBox3.Text == "")
            {
                MessageBox.Show("Tao hoa don truoc khi them san pham");
                return;
            }

            if (comboBox4.SelectedIndex == -1)
            {
                MessageBox.Show("Chon san pham");
                return;
            }

            string selectedProduct = comboBox4.SelectedItem.ToString();
            bool productExists = false;

            foreach (ListViewItem item in listView1.Items)
            {
                if (item.Text == selectedProduct)
                {
                    // Product exists, update quantity
                    int currentQuantity = int.Parse(item.SubItems[1].Text);
                    item.SubItems[1].Text = (currentQuantity + numericUpDown1.Value).ToString();
                    productExists = true;

                    SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();

                    SqlCommand sqlCmd1 = new SqlCommand();
                    sqlCmd1.Connection = sqlCon;
                    sqlCmd1.CommandType = CommandType.Text;
                    sqlCmd1.CommandText = "DELETE FROM DonHang_SanPham WHERE MaDonHang = @MaDonHang AND MaSanPham = @MaSanPham;";
                    sqlCmd1.Parameters.AddWithValue("@MaDonHang", textBox3.Text);
                    sqlCmd1.Parameters.AddWithValue("@MaSanPham", comboBox4.SelectedItem.ToString().Split('.')[0]);
                    sqlCmd1.ExecuteNonQuery();

                    SqlCommand sqlCmd2 = new SqlCommand();
                    sqlCmd2.Connection = sqlCon;
                    sqlCmd2.CommandType = CommandType.Text;
                    sqlCmd2.CommandText = "insert into DonHang_SanPham values (@MaDonHang, @MaSanPham, @Soluong);";
                    sqlCmd2.Parameters.AddWithValue("@MaDonHang", textBox3.Text);
                    sqlCmd2.Parameters.AddWithValue("@MaSanPham", comboBox4.SelectedItem.ToString().Split('.')[0]);
                    sqlCmd2.Parameters.AddWithValue("@Soluong", item.SubItems[1].Text);
                    sqlCmd2.ExecuteNonQuery();

                    sqlCon.Close();
                    break;
                }
            }

            if (!productExists)
            {
                // Product does not exist, add new item
                ListViewItem listViewItem = new ListViewItem(selectedProduct);
                listViewItem.SubItems.Add(numericUpDown1.Value.ToString());
                listView1.Items.Add(listViewItem);

                SqlConnection sqlCon = DatabaseConnection.Instance.GetConnection();

                SqlCommand sqlCmd2 = new SqlCommand();
                sqlCmd2.Connection = sqlCon;
                sqlCmd2.CommandType = CommandType.Text;
                sqlCmd2.CommandText = "insert into DonHang_SanPham values (@MaDonHang, @MaSanPham, @Soluong);";
                sqlCmd2.Parameters.AddWithValue("@MaDonHang", textBox3.Text);
                sqlCmd2.Parameters.AddWithValue("@MaSanPham", comboBox4.SelectedItem.ToString().Split('.')[0]);
                sqlCmd2.Parameters.AddWithValue("@Soluong", numericUpDown1.Value);
                sqlCmd2.ExecuteNonQuery();

                sqlCon.Close();
            }

            string str = textBox3.Text;
            string lastEight = str.Length >= 8 ? str.Substring(str.Length - 8) : str;

            SqlConnection sqlCon1 = DatabaseConnection.Instance.GetConnection();
            SqlCommand sqlCmd3 = new SqlCommand();
            sqlCmd3.CommandType = CommandType.Text;
            sqlCmd3.CommandText = "select TongTien from HoaDon where MaHoaDon = @MaHoaDon;";
            sqlCmd3.Parameters.AddWithValue("@MaHoaDon", "HD" + lastEight); // Corrected here
            sqlCmd3.Connection = sqlCon1;
            SqlDataReader reader2 = sqlCmd3.ExecuteReader();

            while (reader2.Read())
            {
                string tongtien = reader2.GetDecimal(0).ToString();

                textBox2.Text = tongtien;
            }


        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            DatHangControl_Load(sender, e);
        }
    }
}
