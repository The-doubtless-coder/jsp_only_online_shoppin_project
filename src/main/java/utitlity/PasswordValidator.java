package utitlity;

import java.util.regex.Pattern;

public class PasswordValidator {
    private static final String regexPattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$";
    public static boolean patternMatches(String password) throws IllegalArgumentException{
        boolean isValid = Pattern.compile(regexPattern)
                .matcher(password)
                .matches();
        if(!isValid){
            throw new IllegalArgumentException("Password provided does not meet set standards");
        }
        return isValid;
    }
}
