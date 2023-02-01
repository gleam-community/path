import gleam_community/path
import gleeunit/should
import gleeunit

pub fn main() {
  gleeunit.main()
}

pub fn from_string_test() {
  path.from_string("/hello/friend")
  |> should.equal(path.Absolute(["hello", "friend"]))
  path.from_string("/hello/friend/../buddy")
  |> should.equal(path.Absolute(["hello", "buddy"]))
  path.from_string("hello/friend")
  |> should.equal(path.Relative(["hello", "friend"]))
  path.from_string("./hello/./friend/../buddy")
  |> should.equal(path.Relative(["hello", "buddy"]))
}

pub fn join_test() {
  path.join(path.Absolute(["hello", "there"]), "buddy/pal")
  |> should.equal(path.Absolute(["hello", "there", "buddy", "pal"]))
  path.join(path.Absolute(["hello", "there"]), "../sailor")
  |> should.equal(path.Absolute(["hello", "sailor"]))
}

pub fn normalize_test() {
  path.normalize("/hello/./there/../friend")
  |> should.equal("/hello/friend")
  path.normalize("hello/./there/../friend")
  |> should.equal("hello/friend")
  path.normalize("/hello/./there/../../../goodbye/forever")
  |> should.equal("/goodbye/forever")
  path.normalize("hello/./there/../../../goodbye/forever")
  |> should.equal("../goodbye/forever")
  path.normalize("/hello/./there/../../../goodbye/forever/../../../hello/again")
  |> should.equal("/hello/again")
  path.normalize("hello/./there/../../../goodbye/forever/../../../hello/again")
  |> should.equal("../../hello/again")
  path.normalize("../../../hello/sailor")
  |> should.equal("../../../hello/sailor")
}

pub fn extname_test() {
  path.from_string("/hello/there/lucy.png")
  |> path.extname()
  |> should.equal(".png")

  path.from_string("/hello/there/.lucy.image.pink.png")
  |> path.extname()
  |> should.equal(".png")

  path.from_string("/hello/there")
  |> path.extname()
  |> should.equal("")

  path.from_string("")
  |> path.extname()
  |> should.equal("")
}

pub fn delimiter_test() {
  path.delimiter()
  |> should.equal(":")
}

pub fn sep_test() {
  path.sep()
  |> should.equal("/")
}

pub fn dirname_test() {
  path.from_string("/hello")
  |> path.dirname()
  |> should.equal("/")

  path.from_string("./hello")
  |> path.dirname()
  |> should.equal(".")

  path.from_string("./hello/there/lucy.gleam")
  |> path.dirname()
  |> should.equal("./hello/there")

  path.from_string("/hello/there/lucy.gleam")
  |> path.dirname()
  |> should.equal("/hello/there")

  path.from_string("")
  |> path.dirname()
  |> should.equal(".")

  path.from_string("/")
  |> path.dirname()
  |> should.equal("/")

  path.from_string(".")
  |> path.dirname()
  |> should.equal(".")

  path.from_string("./")
  |> path.dirname()
  |> should.equal(".")
}

pub fn basename_test() {
  path.from_string("/hello")
  |> path.basename()
  |> should.equal("hello")

  path.from_string("/")
  |> path.basename()
  |> should.equal("")

  path.from_string(".")
  |> path.basename()
  |> should.equal(".")
}

pub fn common_test() {
  let path_a = path.from_string("/hello/there/friend/lucy.gleam")
  let path_b = path.from_string("/hello/there/yak.gleam")

  path.common(between: path_a, and: path_b)
  |> should.equal(Ok(path.Absolute(["hello", "there"])))

  let path_a = path.from_string("./hello/there/friend/lucy.gleam")
  let path_b = path.from_string("./hello/there/yak.gleam")

  path.common(between: path_a, and: path_b)
  |> should.equal(Ok(path.Relative(["hello", "there"])))

  let path_a = path.from_string("./hello/there/./friend/lucy.gleam")
  let path_b = path.from_string("./hello/./there/yak.gleam")

  path.common(between: path_a, and: path_b)
  |> should.equal(Ok(path.Relative(["hello", "there"])))

  let path_a = path.from_string("./hello/there/friend/lucy.gleam")
  let path_b = path.from_string("/hello/there/yak.gleam")

  path.common(between: path_a, and: path_b)
  |> should.equal(Error(Nil))

  let path_a = path.from_string("/hi/there/friend/lucy.gleam")
  let path_b = path.from_string("/hello/there/yak.gleam")

  path.common(between: path_a, and: path_b)
  |> should.equal(Ok(path.Absolute([])))

  let path_a = path.from_string("/")
  let path_b = path.from_string("/")

  path.common(between: path_a, and: path_b)
  |> should.equal(Ok(path.Absolute([])))
}
