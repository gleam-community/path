import gleam/list
import gleam/result
import gleam/string

// The order of `segments` is reversed, because adding and removing from
// the front of lists is much faster.
pub opaque type Path {
  Path(segments: List(String), kind: PathKind)
}

pub type PathKind {
  Absolute
  Relative
}

fn normalize_segments(kind: PathKind) {
  fn(segments: List(String), segment: String) -> List(String) {
    case segment {
      ".." -> {
        // If the path is relative, and only consists of segments traveling up (".."),
        // then we can continue to go up. Otherwise, remove the last segment.
        let only_up_from_here =
          list.all(segments, fn(segment) { segment == ".." })
        case kind, only_up_from_here {
          Relative, True -> [segment, ..segments]
          _, _ -> result.unwrap(list.rest(segments), [])
        }
      }
      "" | "." ->
        // Allow for a single leading "." on relative paths
        case kind, segments {
          Relative, [] -> ["."]
          _, _ -> segments
        }
      _ -> [segment, ..segments]
    }
  }
}

pub fn from_string(path_string: String) -> Path {
  let kind = case string.starts_with(path_string, "/") {
    True -> Absolute
    False -> Relative
  }

  path_string
  |> string.split("/")
  |> list.fold([], normalize_segments(kind))
  |> Path(kind)
}

pub fn append_string(self: Path, piece: String) -> Path {
  let segments =
    piece
    |> string.split("/")
    |> list.fold(self.segments, normalize_segments(self.kind))

  Path(..self, segments: segments)
}

pub fn to_string(self: Path) -> String {
  let joined_segments =
    self.segments
    |> list.reverse()
    |> string.join("/")

  case self.kind {
    Absolute -> "/" <> joined_segments
    Relative -> joined_segments
  }
}

pub fn equals(self: Path, segments: List(String), kind: PathKind) -> Bool {
  list.reverse(self.segments) == segments && self.kind == kind
}
