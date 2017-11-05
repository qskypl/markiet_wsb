package generators;

import org.junit.Test;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class AccountTest {

    @Test
    public void generateAccount() {
        Map<String,String> account = new HashMap<String, String>();



        String username = generateText(10);
        String password = generateText(8);
        String firstName = generateText(6);
        String lastName = generateText(10);
        String phone = generateNumberToString(9);
        String dateOfBirth = generateDate();
        String city = generateText(15);

        account.put("username", username);
        account.put("password", password);




    }

    private String generateText(int length) {
        return UUID.randomUUID().toString().substring(0, length);
    }

    private String generateNumberToString(int length) {
        Random randomGenerator = new Random();
        randomGenerator.nextInt(length);
        return randomGenerator.toString();
    }

    private String generateDate() {
        Random random = new Random();
        int minDay = (int) LocalDate.of(1900, 1, 1).toEpochDay();
        int maxDay = (int) LocalDate.of(2015, 1, 1).toEpochDay();
        long randomDay = minDay + random.nextInt(maxDay - minDay);

        LocalDate randomBirthDate = LocalDate.ofEpochDay(randomDay);
        DateTimeFormatter format = DateTimeFormatter.ISO_LOCAL_DATE;
        String formattedString = randomBirthDate.format(format);

        return formattedString;
    }



}
