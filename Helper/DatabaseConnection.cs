using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace btll
{
    public class DatabaseConnection
    {
        private static DatabaseConnection _instance;
        private static SqlConnection _connection;
        private static readonly object padlock = new object();

        DatabaseConnection()
        {
            _connection = new SqlConnection(@"Data Source=DESKTOP-TH1P604\PIHUSERVER;Initial Catalog=BT6;Integrated Security=True");
        }

        public static DatabaseConnection Instance
        {
            get
            {
                lock (padlock)
                {
                    if (_instance == null)
                    {
                        _instance = new DatabaseConnection();
                    }
                    return _instance;
                }
            }
        }

        public SqlConnection GetConnection()
        {
            _connection = new SqlConnection();
            _connection.ConnectionString = @"Data Source=DESKTOP-TH1P604\PIHUSERVER;Initial Catalog=BT6;Integrated Security=True";

            if (_connection.State == ConnectionState.Closed)
            {
                _connection.Open();
            }
            return _connection;
        }

    }

}
