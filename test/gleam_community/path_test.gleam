import gleam_community/path
import gleeunit/should

pub fn from_string_test() {
  path.from_string("/hello/friend")
  |> path.equals(["hello", "friend"], path.Absolute)
  |> should.be_true()

  path.from_string("/hello/friend/../buddy")
  |> path.equals(["hello", "buddy"], path.Absolute)
  |> should.be_true()

  path.from_string("hello/friend")
  |> path.equals(["hello", "friend"], path.Relative)
  |> should.be_true()

  path.from_string("./hello/./friend/../buddy")
  |> path.equals([".", "hello", "buddy"], path.Relative)
  |> should.be_true()
}

pub fn and_then_test() {
  path.from_string("/hello/there")
  |> path.and_then_string("./buddy/pal")
  |> path.equals(["hello", "there", "buddy", "pal"], path.Absolute)
  |> should.be_true()

  path.from_string("/hello/there")
  |> path.and_then_string("../sailor")
  |> path.equals(["hello", "sailor"], path.Absolute)
  |> should.be_true()

  path.from_string("/hello/there")
  |> path.and_then_string("/sailor")
  |> path.equals(["sailor"], path.Absolute)
  |> should.be_true()
}


pub fn append_test() {
  path.from_string("/hello/there")
  |> path.append_string("./buddy/pal")
  |> path.equals(["hello", "there", "buddy", "pal"], path.Absolute)
  |> should.be_true()

  path.from_string("/hello/there")
  |> path.append_string("../sailor")
  |> path.equals(["hello", "sailor"], path.Absolute)
  |> should.be_true()

  path.from_string("/hello/there")
  |> path.append_string("/sailor")
  |> path.equals(["hello", "there", "sailor"], path.Absolute)
  |> should.be_true()
}
