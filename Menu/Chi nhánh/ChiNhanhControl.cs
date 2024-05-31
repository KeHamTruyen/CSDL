using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace btll
{
    public partial class ChiNhanhControl : UserControl
    {
        public ChiNhanhControl()
        {
            InitializeComponent();
        }
        public event EventHandler DSButtonCNC_Clicked;

        public void DSButtonCNC_Click(object sender, EventArgs e)
        {
            DSButtonCNC_Clicked?.Invoke(this, e);
        }

        public event EventHandler HDButtonCNC_Clicked;
        private void HDButtonCNC_Click(object sender, EventArgs e)
        {
            HDButtonCNC_Clicked?.Invoke(this, e);
        }
    }
}
