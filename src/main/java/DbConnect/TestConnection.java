package DbConnect;

public class TestConnection {
    public static void main(String[] args) {
        try {
            ConnectionProvider.getConnObject();
        }catch (Exception f){
            System.err.println(f.getClass().getName() + " " + f.getMessage());
            f.printStackTrace();
        }
    }
}
