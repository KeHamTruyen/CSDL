using System.Drawing;
using System.Windows.Forms;

namespace btll
{
    partial class Mainform
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Mainform));
            this.panel1 = new System.Windows.Forms.Panel();
            this.SidePanel = new System.Windows.Forms.Panel();
            this.KhuyenMaiButton = new System.Windows.Forms.Button();
            this.SanPhamButton = new System.Windows.Forms.Button();
            this.KhachHangButton = new System.Windows.Forms.Button();
            this.NhanVienButton = new System.Windows.Forms.Button();
            this.ChiNhanhButton = new System.Windows.Forms.Button();
            this.DatHangButton = new System.Windows.Forms.Button();
            this.TrangChuButton = new System.Windows.Forms.Button();
            this.TopPanel = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.sqlCeCommandBuilder1 = new System.Data.SqlServerCe.SqlCeCommandBuilder();
            this.khuyenMaiControl1 = new btll.KhuyenMaiControl();
            this.khachHangControl1 = new btll.Menu.KhachHangControl();
            this.sanPhamControl1 = new btll.SanPhamControl();
            this.chiNhanh_DanhsachControl1 = new btll.ChiNhanh_DanhsachControl();
            this.chiNhanhControl1 = new btll.ChiNhanhControl();
            this.datHangControl1 = new btll.DatHangControl();
            this.trangChuControl1 = new btll.TrangChuControl();
            this.nhanVienControl1 = new btll.NhanVienControl();
            this.cN_HDControl1 = new btll.Menu.Chi_nhánh.CN_HDControl();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.SystemColors.MenuText;
            this.panel1.Controls.Add(this.SidePanel);
            this.panel1.Controls.Add(this.KhuyenMaiButton);
            this.panel1.Controls.Add(this.SanPhamButton);
            this.panel1.Controls.Add(this.KhachHangButton);
            this.panel1.Controls.Add(this.NhanVienButton);
            this.panel1.Controls.Add(this.ChiNhanhButton);
            this.panel1.Controls.Add(this.DatHangButton);
            this.panel1.Controls.Add(this.TrangChuButton);
            resources.ApplyResources(this.panel1, "panel1");
            this.panel1.Name = "panel1";
            // 
            // SidePanel
            // 
            this.SidePanel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(85)))), ((int)(((byte)(192)))));
            resources.ApplyResources(this.SidePanel, "SidePanel");
            this.SidePanel.Name = "SidePanel";
            // 
            // KhuyenMaiButton
            // 
            this.KhuyenMaiButton.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.KhuyenMaiButton, "KhuyenMaiButton");
            this.KhuyenMaiButton.ForeColor = System.Drawing.Color.White;
            this.KhuyenMaiButton.Name = "KhuyenMaiButton";
            this.KhuyenMaiButton.UseVisualStyleBackColor = true;
            this.KhuyenMaiButton.Click += new System.EventHandler(this.KhuyenMaiButton_Click);
            // 
            // SanPhamButton
            // 
            this.SanPhamButton.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.SanPhamButton, "SanPhamButton");
            this.SanPhamButton.ForeColor = System.Drawing.Color.White;
            this.SanPhamButton.Name = "SanPhamButton";
            this.SanPhamButton.UseVisualStyleBackColor = true;
            this.SanPhamButton.Click += new System.EventHandler(this.SanPhamButton_Click);
            // 
            // KhachHangButton
            // 
            this.KhachHangButton.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.KhachHangButton, "KhachHangButton");
            this.KhachHangButton.ForeColor = System.Drawing.Color.White;
            this.KhachHangButton.Name = "KhachHangButton";
            this.KhachHangButton.UseVisualStyleBackColor = true;
            this.KhachHangButton.Click += new System.EventHandler(this.KhachHangButton_Click);
            // 
            // NhanVienButton
            // 
            this.NhanVienButton.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.NhanVienButton, "NhanVienButton");
            this.NhanVienButton.ForeColor = System.Drawing.Color.White;
            this.NhanVienButton.Name = "NhanVienButton";
            this.NhanVienButton.UseVisualStyleBackColor = true;
            this.NhanVienButton.Click += new System.EventHandler(this.NhanVienButton_Click);
            // 
            // ChiNhanhButton
            // 
            this.ChiNhanhButton.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.ChiNhanhButton, "ChiNhanhButton");
            this.ChiNhanhButton.ForeColor = System.Drawing.Color.White;
            this.ChiNhanhButton.Name = "ChiNhanhButton";
            this.ChiNhanhButton.UseVisualStyleBackColor = true;
            this.ChiNhanhButton.Click += new System.EventHandler(this.ChiNhanhButton_Click);
            // 
            // DatHangButton
            // 
            this.DatHangButton.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.DatHangButton, "DatHangButton");
            this.DatHangButton.ForeColor = System.Drawing.Color.White;
            this.DatHangButton.Name = "DatHangButton";
            this.DatHangButton.UseVisualStyleBackColor = true;
            this.DatHangButton.Click += new System.EventHandler(this.DatHangButton_Click);
            // 
            // TrangChuButton
            // 
            this.TrangChuButton.FlatAppearance.BorderSize = 0;
            resources.ApplyResources(this.TrangChuButton, "TrangChuButton");
            this.TrangChuButton.ForeColor = System.Drawing.Color.White;
            this.TrangChuButton.Name = "TrangChuButton";
            this.TrangChuButton.UseVisualStyleBackColor = true;
            this.TrangChuButton.Click += new System.EventHandler(this.TrangChuButton_Click);
            // 
            // TopPanel
            // 
            this.TopPanel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(85)))), ((int)(((byte)(192)))));
            resources.ApplyResources(this.TopPanel, "TopPanel");
            this.TopPanel.Name = "TopPanel";
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.label1);
            resources.ApplyResources(this.panel2, "panel2");
            this.panel2.Name = "panel2";
            // 
            // sqlCeCommandBuilder1
            // 
            this.sqlCeCommandBuilder1.DataAdapter = null;
            this.sqlCeCommandBuilder1.QuotePrefix = "[";
            this.sqlCeCommandBuilder1.QuoteSuffix = "]";
            // 
            // khuyenMaiControl1
            // 
            resources.ApplyResources(this.khuyenMaiControl1, "khuyenMaiControl1");
            this.khuyenMaiControl1.Name = "khuyenMaiControl1";
            // 
            // khachHangControl1
            // 
            resources.ApplyResources(this.khachHangControl1, "khachHangControl1");
            this.khachHangControl1.Name = "khachHangControl1";
            // 
            // sanPhamControl1
            // 
            resources.ApplyResources(this.sanPhamControl1, "sanPhamControl1");
            this.sanPhamControl1.Name = "sanPhamControl1";
            // 
            // chiNhanh_DanhsachControl1
            // 
            resources.ApplyResources(this.chiNhanh_DanhsachControl1, "chiNhanh_DanhsachControl1");
            this.chiNhanh_DanhsachControl1.Name = "chiNhanh_DanhsachControl1";
            // 
            // chiNhanhControl1
            // 
            resources.ApplyResources(this.chiNhanhControl1, "chiNhanhControl1");
            this.chiNhanhControl1.Name = "chiNhanhControl1";
            // 
            // datHangControl1
            // 
            resources.ApplyResources(this.datHangControl1, "datHangControl1");
            this.datHangControl1.Name = "datHangControl1";
            // 
            // trangChuControl1
            // 
            resources.ApplyResources(this.trangChuControl1, "trangChuControl1");
            this.trangChuControl1.Name = "trangChuControl1";
            // 
            // nhanVienControl1
            // 
            resources.ApplyResources(this.nhanVienControl1, "nhanVienControl1");
            this.nhanVienControl1.Name = "nhanVienControl1";
            // 
            // cN_HDControl1
            // 
            resources.ApplyResources(this.cN_HDControl1, "cN_HDControl1");
            this.cN_HDControl1.Name = "cN_HDControl1";
            // 
            // Mainform
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.Controls.Add(this.cN_HDControl1);
            this.Controls.Add(this.nhanVienControl1);
            this.Controls.Add(this.khuyenMaiControl1);
            this.Controls.Add(this.khachHangControl1);
            this.Controls.Add(this.sanPhamControl1);
            this.Controls.Add(this.chiNhanh_DanhsachControl1);
            this.Controls.Add(this.chiNhanhControl1);
            this.Controls.Add(this.datHangControl1);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.trangChuControl1);
            this.Controls.Add(this.TopPanel);
            this.Controls.Add(this.panel1);
            this.Name = "Mainform";
            this.panel1.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel TopPanel;
        private System.Windows.Forms.Button TrangChuButton;
        private System.Windows.Forms.Button KhuyenMaiButton;
        private System.Windows.Forms.Button SanPhamButton;
        private System.Windows.Forms.Button KhachHangButton;
        private System.Windows.Forms.Button NhanVienButton;
        private System.Windows.Forms.Button ChiNhanhButton;
        private System.Windows.Forms.Button DatHangButton;
        private System.Windows.Forms.Panel SidePanel;
        private TrangChuControl trangChuControl1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Panel panel2;
        private DatHangControl datHangControl1;
        private ChiNhanhControl chiNhanhControl1;
        private ChiNhanh_DanhsachControl chiNhanh_DanhsachControl1;
        private SanPhamControl sanPhamControl1;
        private System.Data.SqlServerCe.SqlCeCommandBuilder sqlCeCommandBuilder1;
        private Menu.KhachHangControl khachHangControl1;
        private KhuyenMaiControl khuyenMaiControl1;
        private NhanVienControl nhanVienControl1;
        private Menu.Chi_nhánh.CN_HDControl cN_HDControl1;
    }
}

