import dream_http_client/client
import dream_http_client_test
import gleam/http
import gleeunit/should

fn redirect_request() -> client.ClientRequest {
  client.new()
  |> client.method(http.Get)
  |> client.scheme(http.Http)
  |> client.host("localhost")
  |> client.port(dream_http_client_test.get_test_port())
  |> client.path("/redirect")
}

pub fn redirects_are_followed_by_default_test() {
  let assert Ok(response) = client.send(redirect_request())
  response.status |> should.equal(200)
}

pub fn redirects_can_be_disabled_test() {
  let request = redirect_request() |> client.follow_redirects(False)
  let assert Ok(response) = client.send(request)
  response.status |> should.equal(302)
}
