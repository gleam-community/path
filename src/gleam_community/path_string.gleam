import gleam_community/path

pub fn normalize(path_string: String) -> String {
  path_string
  |> path.from_string()
  |> path.to_string()
}
