package utitlity;

import java.util.regex.Pattern;

public class PhoneValidator {
    private static final String regexPattern = "^(?:\\+254)(\\d{9})$";
    public static boolean patternMatches(String phoneNumber) throws IllegalArgumentException{
        boolean isValid = Pattern.compile(regexPattern)
                .matcher(phoneNumber)
                .matches();
        if(!isValid){
            throw new IllegalArgumentException("Phone provided does not meet set standards");
        }
        return isValid;
    }
}
