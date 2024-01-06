//// Provides many utilities for dealing with paths.

import gleam/iterator.{type Iterator}
import gleam/option.{type Option}

pub type Path =
  String

/// `is_absolute` will tell you if a given path unambiguously refers to a single location. For
/// example, an absolute path won't depend on the working directory.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// path.is_absolute("/")
/// |> should.equal(True)
/// ```
///
/// ```gleam
/// path.is_absolute("/wibble/wobble")
/// |> should.equal(True)
/// ```
///
/// ```gleam
/// path.is_absolute("~")
/// |> should.equal(True)
/// ```
///
///
/// </details>
///
pub fn is_absolute(self: Path) -> Bool {
  todo
}

/// `is_relative` will tell you if a given path is context dependent. For example, if it depends
/// on the working directory.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// path.is_directory("/")
/// |> should.equal(False)
/// ```
///
/// </details>
///
pub fn is_relative(self: Path) -> Bool {
  todo
}

/// `is_directory` can be used to guess if the path references a directory. This does not check
/// the filesystem, and only reflects whether or not other functions will treat it as a directory.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// path.is_directory("/")
/// |> should.equal(True)
/// ```
///
/// ```gleam
/// path.is_directory(".")
/// |> should.equal(True)
/// ```
///
/// ```gleam
/// path.is_directory("../..")
/// |> should.equal(True)
/// ```
///
/// ```gleam
/// path.is_directory("/usr/local/gleam/bin/")
/// |> should.equal(True)
/// ```
///
/// ```gleam
/// path.is_directory("/usr/local/gleam/bin/gleam")
/// |> should.equal(False)
/// ```
///
/// </details>
///
pub fn is_directory(self: Path) -> Bool {
  todo
}

/// `is_file` can be used to guess if the path references a file. This does not check
/// the filesystem, and only reflects whether other functions will treat it as a file or not.
/// This function will always return the opposite of [`is_directory`](#is_directory).
pub fn is_file(self: Path) -> Bool {
  todo
}

/// ```gleam
/// path.components("/wibble/wobble")
/// // => ["wibble", "wobble"]
/// ```
pub fn components(self: Path) -> List(String) {
  todo
}

/// `parent` will return the parent path of the given path. ie. the directory which contains
/// the file that the original path references.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// path.parent("gleam_community/path")
/// |> should.equal(Some("gleam_community"))
/// ```
///
/// ```gleam
/// path.parent("gleam_community")
/// |> should.equal(Some("."))
/// ```
///
/// ```gleam
/// path.parent("/gleam_community")
/// |> should.equal(Some("/"))
/// ```
///
/// ```gleam
/// path.parent("/")
/// |> should.equal(None)
/// ```
///
/// ```gleam
/// "."
/// |> path.parent()
/// |> path.parent()
/// |> path.parent()
/// |> should.equal(Some("../../.."))
/// ```
///
/// </details>
///
pub fn parent(self: Path) -> Option(Path) {
  todo
}

/// ```gleam
/// path.ancestors("/wibble/wobble/wooble/weeble")
/// // => ["/wibble/wobble/wooble", "/wibble/wobble", "/wibble"]
/// ```
pub fn ancestors(self: Path) -> Iterator(Path) {
  todo
}

pub fn directory(self: Path) -> String {
  todo
}

pub fn file_name(self: Path) -> String {
  todo
}

pub fn base_name(self: Path) -> String {
  todo
}

pub fn extension(self: Path) -> Option(String) {
  todo
}

/// `and_then` will follow directions from one path to reach another. It can be thought of as
/// an equivalent of the `cd` shell command. Whether you tell it to follow a relative path, or
/// an absolute one, it will listen.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// "/Users/Bandit"
/// |> path.and_then("Documents/secrets")
/// |> should.equal("/Users/Bandit/Documents/secrets")
/// ```
///
/// ```gleam
/// "/Users/Bandit"
/// |> path.and_then("/Users/August")
/// |> should.equal("/Users/August")
/// ```
///
/// ```gleam
/// "/Users/Bandit"
/// |> path.and_then("../Penelope/Pictures/")
/// |> should.equal("/Users/Penelope/Pictures")
/// ```
///
/// </details>
///
pub fn and_then(self: Path, to: Path) -> Path {
  todo
}

/// `join` will concatenate both paths and normalize the result. This function is useful if you
/// want to allow relative paths to traverse up, but you don't want an absolute path to overwrite everything.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// path.join("/Users/Bandit", "Documents/secrets")
/// |> should.equal("/Users/Bandit/Documents/secrets")
/// ```
///
/// ```gleam
/// path.join("/Users/Bandit", "/Documents/secrets")
/// |> should.equal("/Users/Bandit/Documents/secrets")
/// ```
///
/// ```gleam
/// path.join("/Users/Bandit", "../Penelope/Pictures/")
/// |> should.equal("/Users/Penelope/Pictures")
/// ```
///
/// </details>
///
pub fn join(self: Path, to: Path) -> Path {
  todo
}

/// `inside` is like [`join`](#join), but guaranteed to return a path that exists within
/// `base`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// "/content/banner.webp"
/// |> path.inside("/Source/wwwroot")
/// |> should.equal("/Source/wwwroot/content/banner.webp")
/// ```
///
/// ```gleam
/// "/content/../../banner.webp"
/// |> path.inside("/Source/wwwroot")
/// |> should.equal("/Source/wwwroot/banner.webp")
/// ```
///
/// </details>
///
pub fn inside(self: Path, base of: Path) -> Path {
  todo
}

/// `set_filename` will change the path to point to a file with the provided name in the same
/// directory. A path ending in "/" will be treated as a directory, not a file.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// path.set_filename("/public/index.html", "favicon.ico")
/// |> should.equal("/public/favicon.ico")
/// ```
///
/// ```gleam
/// path.set_filename("/public/", "favicon.ico")
/// |> should.equal("/public/favicon.ico")
/// ```
///
/// ```gleam
/// path.set_filename("/public", "favicon.ico")
/// |> should.equal("/favicon.ico")
/// ```
///
/// </details>
///
pub fn set_file_name(self: Path, filename: String) -> Path {
  todo
}

/// `set_basename` will change the path to point to a file with the provided basename in the
/// same directory, with the same extension (or lack of). A path ending in "/" will be treated
/// as a directory, not a file.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// path.set_basename("/gleam.toml", "manifest")
/// |> should.equal("/manifest.toml")
/// ```
///
/// ```gleam
/// path.set_basename("/LICENSE", "LICENCE")
/// |> should.equal("/LICENCE")
/// ```
///
/// ```gleam
/// path.set_basename("/LICENSE.MIT", "LICENCE")
/// |> should.equal("/LICENCE.MIT")
/// ```
///
/// ```gleam
/// path.set_basename("/my-project/", "LICENCE")
/// |> should.equal("/my-project/LICENCE")
/// ```
///
/// </details>
///
pub fn set_file_base_name(self: Path, basename: String) -> Path {
  todo
}

/// `set_extension` will change the path to point to a file with the provided extension in the
/// same directory, with the same basename. A path ending in "/" will be treated as a
/// directory, not a file.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// path.set_extension("/favicon.ico", "svg")
/// |> should.equal("/manifest.toml")
/// ```
///
/// ```gleam
/// path.set_extension("/favicon.ico", ".svg")
/// |> should.equal("/favicon.svg")
/// ```
///
/// ```gleam
/// path.set_extension("/LICENSE.MIT", "LICENCE")
/// |> should.equal("/LICENCE.MIT")
/// ```
///
/// </details>
///
pub fn set_file_extension(self: Path, extension: String) -> Path {
  todo
}
