// IMPORTS --------------------------------------------------------------------

import gleam/list
import gleam/result
import gleam/string

// TYPES ----------------------------------------------------------------------

///
pub type Path {
  Absolute(segments: List(String))
  Relative(segments: List(String))
}

///
pub type PathFilter {
  Up
  Skip
  Include
}

// CONSTRUCTORS ---------------------------------------------------------------

///
pub fn from_string(base: String) -> Path {
  let constructor = case string.starts_with(base, "/") {
    True -> Absolute
    False -> Relative
  }

  base
  |> string.split("/")
  |> constructor
  |> filter_segment_list
}

///
pub fn join(path: Path, piece: String) -> Path {
  let constructor = case path {
    Absolute(_) -> Absolute
    Relative(_) -> Relative
  }

  let segments = path.segments

  piece
  |> string.split("/")
  |> list.append(segments, _)
  |> constructor
  |> filter_segment_list
}

/// CONVERSIONS ---------------------------------------------------------------
pub fn to_string(path: Path) -> String {
  let joined_segments = string.join(path.segments, "/")

  case path {
    Absolute(_) -> string.concat(["/", joined_segments])

    Relative(_) -> joined_segments
  }
}

/// 
pub fn extname(path: Path) -> String {
  let file_name =
    path.segments
    |> list.last()
    |> result.unwrap("")

  case string.split(file_name, ".") {
    [_] -> ""
    file_name_parts ->
      file_name_parts
      |> list.last()
      |> result.unwrap("")
      |> string.append(".", _)
  }
}

// MANIPULATIONS --------------------------------------------------------------

///
pub fn relative(from from: Path, to to: Path) -> Path {
  todo
}

///
pub fn normalize(messy: String) -> String {
  messy
  |> from_string
  |> to_string
}

///
pub fn common(between path_a: Path, and path_b: Path) -> Result(Path, Nil) {
  case path_a, path_b {
    Absolute(_), Relative(_) -> Error(Nil)
    Relative(_), Absolute(_) -> Error(Nil)
    _, _ -> {
      let constructor = case path_a {
        Absolute(_) -> Absolute
        Relative(_) -> Relative
      }

      let segments =
        list.zip(path_a.segments, path_b.segments)
        |> common_between([])

      case segments {
        [] if constructor == Absolute -> Ok(constructor([]))

        [] if constructor == Relative -> Error(Nil)

        _ -> Ok(constructor(segments))
      }
    }
  }
}

// QUERIES --------------------------------------------------------------------

///
pub fn dirname(path: Path) -> String {
  case path {
    Absolute(segments) ->
      case segments {
        [] | [_] -> sep()
        path_parts ->
          path_parts
          |> list.take(list.length(path_parts) - 1)
          |> string.join(sep())
          |> string.append(sep(), _)
      }

    Relative(segments) ->
      case segments {
        [] | [_] -> "."
        path_parts ->
          path_parts
          |> list.take(list.length(path_parts) - 1)
          |> string.join(sep())
          |> string.append("." <> sep(), _)
      }
  }
}

///
pub fn basename(path: Path) -> String {
  case result.unwrap(list.last(path.segments), "") {
    "" ->
      case path {
        Absolute(_) -> ""
        Relative(_) -> "."
      }
    base -> base
  }
}

///
pub fn delimiter() -> String {
  case get_os_type() {
    "win32" -> ";"
    "unix" -> ":"
  }
}

///
pub fn sep() -> String {
  case get_os_type() {
    "win32" -> "\\"
    "unix" -> "/"
  }
}

// UTILS ----------------------------------------------------------------------

fn filter_segment_list(path: Path) -> Path {
  let constructor = case path {
    Absolute(_) -> Absolute
    Relative(_) -> Relative
  }

  let segments = path.segments

  segments
  |> list.fold(
    [],
    fn(segments, segment) {
      case filter_segment(segment) {
        Up ->
          case path, list.all(segments, fn(segment) { segment == ".." }) {
            Relative(_), True -> list.append(segments, [".."])
            _, _ -> list.take(segments, list.length(segments) - 1)
          }
        Skip -> segments
        Include -> list.append(segments, [segment])
      }
    },
  )
  |> constructor
}

fn filter_segment(segment: String) -> PathFilter {
  case segment {
    "" | "." -> Skip
    ".." -> Up
    _ -> Include
  }
}

fn common_between(paths: List(#(String, String)), common: List(String)) -> List(String) {
  case paths {
    [] -> list.reverse(common)
    
    [#(part_a, part_b), ..tl] if part_a == part_b -> {
      common_between(tl, [part_a, ..common])
    }

    _ -> list.reverse(common)
  }
}

if erlang {
  external fn get_os_type() -> String =
    "ffi" "get_os_type"
}

if javascript {
  external fn get_os_type() -> String =
    "../ffi.mjs" "getOsType"
}
