import org.junit.Test;

import static com.jayway.restassured.RestAssured.given;

public class ExampleTest extends FunctionalTest {

    @Test
    public void smokeTest() {
        given().when().get("/accounts").then().statusCode(200);
    }

}
