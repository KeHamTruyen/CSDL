using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace btll
{
    public class SqlHelper
    {
        private DatabaseConnection databaseConnection = DatabaseConnection.Instance;
        public SqlHelper()
        {
        }

        public void ExecuteProcedure(string procedureName, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = databaseConnection.GetConnection())
            {
                conn.InfoMessage += delegate (object sender, SqlInfoMessageEventArgs e)
                {
                    MessageBox.Show(e.Message);
                };

                using (SqlCommand cmd = new SqlCommand(procedureName, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    cmd.ExecuteNonQuery();
                }
            }
        }

    }
}
