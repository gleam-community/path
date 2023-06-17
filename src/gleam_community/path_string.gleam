import gleam_community/path

pub fn normalize(path_string: String) -> String {
  path_string
  |> path.from_string()
  |> path.to_string()
}

pub fn append(self: String, path_string: String) -> String {
  self
  |> path.from_string()
  |> path.append_string(path_string)
  |> path.to_string()
}
