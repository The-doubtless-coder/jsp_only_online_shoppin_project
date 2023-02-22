package utitlity;

import java.util.regex.Pattern;

public class EmailValidator {
    private static final String regexPattern = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@"
            + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
    public static boolean patternMatches(String emailAddress) throws IllegalArgumentException{
        boolean isValid = Pattern.compile(regexPattern)
                .matcher(emailAddress)
                .matches();
        if(!isValid){
            throw new IllegalArgumentException("Email provided does not meet set standards");
        }
        return isValid;
    }
}
