import org.junit.Test;

import static com.jayway.restassured.RestAssured.given;

public class ExampleTest extends FunctionalTest {

    @Test
    public void smokeTest() {
        given().when().get("/accounts").then().statusCode(200);
    }

    @Test
    public void smokeTestGetAccount() {
        given().when().get("/accounts/raav88@interia.pl").then().statusCode(200);
    }



}
