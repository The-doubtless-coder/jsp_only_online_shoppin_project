package DbConnect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {
private static Connection conn = null;
public static Connection getConnObject() throws SQLException, ClassNotFoundException{
    try {
        //using type 4 driver, no need for loading the class
        if (conn == null) {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/online_shopping_project","postgres","root");
        }
        System.out.println("Connected...");
        return conn;
    }catch (Exception e){
        if(e instanceof ClassNotFoundException){
            throw new ClassNotFoundException();
        }
        if(e instanceof SQLException){
            throw new SQLException();
        }
        System.exit(0);
        return null;
    }
}
}
