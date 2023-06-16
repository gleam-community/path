import gleam_community/path_string
import gleeunit/should

pub fn normalize_test() {
  path_string.normalize("/hello/./there/../friend")
  |> should.equal("/hello/friend")

  path_string.normalize("hello/./there/../friend")
  |> should.equal("hello/friend")

  path_string.normalize("/hello/./there/../../../goodbye/forever")
  |> should.equal("/goodbye/forever")

  path_string.normalize("hello/./there/../../../goodbye/forever")
  |> should.equal("../goodbye/forever")

  path_string.normalize("/hello/./there/../../../goodbye/../../../hello/again")
  |> should.equal("/hello/again")

  path_string.normalize("hello/./there/../../../goodbye/../../../hello/again")
  |> should.equal("../../../hello/again")

  path_string.normalize("../../../hello/sailor")
  |> should.equal("../../../hello/sailor")
}
