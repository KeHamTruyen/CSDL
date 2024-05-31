namespace btll
{
    partial class ChiNhanhControl
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ChiNhanhControl));
            this.DSButtonCNC = new System.Windows.Forms.Button();
            this.HDButtonCNC = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // DSButtonCNC
            // 
            this.DSButtonCNC.FlatAppearance.BorderSize = 0;
            this.DSButtonCNC.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.DSButtonCNC.Font = new System.Drawing.Font("Century Gothic", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.DSButtonCNC.ForeColor = System.Drawing.Color.Black;
            this.DSButtonCNC.Image = ((System.Drawing.Image)(resources.GetObject("DSButtonCNC.Image")));
            this.DSButtonCNC.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.DSButtonCNC.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.DSButtonCNC.Location = new System.Drawing.Point(29, 29);
            this.DSButtonCNC.Name = "DSButtonCNC";
            this.DSButtonCNC.Size = new System.Drawing.Size(296, 115);
            this.DSButtonCNC.TabIndex = 3;
            this.DSButtonCNC.Text = "      Danh Sach";
            this.DSButtonCNC.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.DSButtonCNC.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.DSButtonCNC.UseVisualStyleBackColor = true;
            this.DSButtonCNC.Click += new System.EventHandler(this.DSButtonCNC_Click);
            // 
            // HDButtonCNC
            // 
            this.HDButtonCNC.FlatAppearance.BorderSize = 0;
            this.HDButtonCNC.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.HDButtonCNC.Font = new System.Drawing.Font("Century Gothic", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.HDButtonCNC.ForeColor = System.Drawing.Color.Black;
            this.HDButtonCNC.Image = ((System.Drawing.Image)(resources.GetObject("HDButtonCNC.Image")));
            this.HDButtonCNC.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.HDButtonCNC.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.HDButtonCNC.Location = new System.Drawing.Point(331, 29);
            this.HDButtonCNC.Name = "HDButtonCNC";
            this.HDButtonCNC.Size = new System.Drawing.Size(296, 115);
            this.HDButtonCNC.TabIndex = 5;
            this.HDButtonCNC.Text = "      Hoa don";
            this.HDButtonCNC.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.HDButtonCNC.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.HDButtonCNC.UseVisualStyleBackColor = true;
            this.HDButtonCNC.Click += new System.EventHandler(this.HDButtonCNC_Click);
            // 
            // ChiNhanhControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.HDButtonCNC);
            this.Controls.Add(this.DSButtonCNC);
            this.Name = "ChiNhanhControl";
            this.Size = new System.Drawing.Size(1117, 624);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button DSButtonCNC;
        private System.Windows.Forms.Button HDButtonCNC;
    }
}
