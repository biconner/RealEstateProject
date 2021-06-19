
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DataSource {

        private static DataSource obj;
        private Connection conn;

        private DataSource() throws SQLException {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            conn = DriverManager.getConnection("jdbc:oracle:thin:@Worf.radford.edu:1521:itec3", "biconner", " ");
        }

        static DataSource getInstance() {
            if (obj == null)
                try {
                    obj = new DataSource();
                } catch (SQLException e) {
                    System.out.println("Error connecting to database " + e.getLocalizedMessage());
                }
            return obj;
        }

        public String[][] executeQuery(String query) throws SQLException {
            Statement statement = conn.createStatement( ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet results = statement.executeQuery(query);
            ResultSetMetaData metaData = results.getMetaData();
            // DAO dao = new DAO(results, metaData);

            String[][] dataset = new String[metaData.getColumnCount()][];

            for (int i = 1; i <= metaData.getColumnCount(); i++) {
                int count = getRowCount(results);
                String[] columnDataset = new String[count + 1];
                String columnName = metaData.getColumnName(i);
                columnDataset[0] = columnName;

                while (results.next()) {
                    int row = results.getRow();
                    String value = results.getString(columnName);
                    columnDataset[row] = value;
                }

                dataset[i - 1] = columnDataset;
            }
            return dataset;
        }


    public List executeDAO(String query) throws SQLException {

        List<DAO> list = new ArrayList<DAO>();
        Statement statement = conn.createStatement( ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet results = statement.executeQuery(query);
        //ResultSetMetaData metaData = results.getMetaData();

        while(results.next()) {
            DAO dao = new DAO();
            dao.setState(results.getString(1));
            dao.setMinPrice(results.getInt(2));
            dao.setMaxPrice(results.getInt(3));
            dao.setAvgPrice(results.getInt(4));

            list.add(dao);
        }

        return list;
    }

        private int getRowCount(ResultSet results) throws SQLException {
            results.last();
            int count = results.getRow();
            results.beforeFirst();
            return count;
        }

        public void close() {
            try {
                conn.close();
            } catch (SQLException e) {
                System.out.println("Error closing connection " + e.getLocalizedMessage());
            }
        }
}
