# Rust Fuzzy Search | [Documentation](https://enricoch.gitlab.io/rust-fuzzy-search/rust_fuzzy_search/index.html)

[<img src="https://img.shields.io/badge/Repository-GitLab-success?style=plastic&logo=gitlab">](https://gitlab.com/EnricoCh/rust-fuzzy-search)
[<img src="https://img.shields.io/badge/Documentation-Doc-success?style=plastic">](https://enricoch.gitlab.io/rust-fuzzy-search/rust_fuzzy_search/index.html)
[<img src="https://img.shields.io/gitlab/pipeline/EnricoCh/rust-fuzzy-search/main?style=plastic">](https://gitlab.com/EnricoCh/rust-fuzzy-search/badges/master/pipeline.svg)
[<img src="https://img.shields.io/badge/Language-Rust-success?style=plastic&logo=rust">](https://www.rust-lang.org/)
[<img src="https://badgen.net/crates/d/rust-fuzzy-search">](https://gitlab.com/EnricoCh/rust-fuzzy-search)
## Fuzzy search with trigrams implemented in Rust



 This crate implements Fuzzy Searching with trigrams


 Fuzzy searching allows to compare strings by similarity rather than by equality:\
 Similar strings will get a high score (close to `1.0f32`) while dissimilar strings will get a lower score (closer to `0.0f32`).

 Fuzzy searching tolerates changes in word order:\
 ex. `"John Dep"` and `"Dep John"` will get a high score.

 The Algorithm used is taken from : <https://dev.to/kaleman15/fuzzy-searching-with-postgresql-97o>

 Basic idea:

 1. From both strings extracts all groups of 3 adjacent letters.\
 (`"House"` becomes `['  H', ' Ho', 'Hou', 'ous', 'use', 'se ']`).\
 Note the 2 spaces added to the head of the string and the one on the tail, used to make the algorithm work on zero length words.

 1. Then counts the number of trigrams of the first words that are also present on the second word and divide by the number of trigrams of the first word.


 Example: Comparing 2 strings
 ```rust
 fn test () {
    use rust_fuzzy_search::fuzzy_compare;
    let score : f32 = fuzzy_compare("kolbasobulko", "kolbasobulko");
    println!("score = {:?}", score);
 }
 ```

 Example: Comparing a string with a list of strings and retrieving only the best matches
 
```rust
 fn test() {
     use rust_fuzzy_search::fuzzy_search_best_n;
     let s = "bulko";
     let list : Vec<&str> = vec![
         "kolbasobulko",
         "sandviĉo",
         "ŝatas",
         "domo",
         "emuo",
         "fabo",
         "fazano"
     ];
     let n : usize = 3;
     let res : Vec<(&str, f32)> = fuzzy_search_best_n(s,&list, n);
     for (_word, score) in res {
         println!("{:?}",score)
     }
 }
 ```
 Example: if you have a `Vec` of `String`s you need to convert it to a list of `&str`
 ```rust
 fn works_with_strings() {
     use rust_fuzzy_search::fuzzy_search;
     let s = String::from("varma");
     let list: Vec<String> = vec![String::from("varma vetero"), String::from("varma ĉokolado")];
     fuzzy_search(&s, &list.iter().map(String::as_ref).collect::<Vec<&str>>());
 }
 ```


The crate exposes 5 main functions:
- [fuzzy_compare](https://enricoch.gitlab.io/rust-fuzzy-search/rust_fuzzy_search/fn.fuzzy_compare.html) will take 2 strings and return a score representing how similar those strings are.
- [fuzzy_search](https://enricoch.gitlab.io/rust-fuzzy-search/rust_fuzzy_search/fn.fuzzy_search.html) applies [fuzzy_compare](https://enricoch.gitlab.io/rust-fuzzy-search/rust_fuzzy_search/fn.fuzzy_compare.html) to a list of strings and returns a list of tuples: (word, score).
- [fuzzy_search_sorted](https://enricoch.gitlab.io/rust-fuzzy-search/rust_fuzzy_search/fn.fuzzy_search_sorted.html) is similar to [fuzzy_search](https://enricoch.gitlab.io/rust-fuzzy-search/rust_fuzzy_search/fn.fuzzy_search.html) but orders the output in descending order.
- [fuzzy_search_threshold](https://enricoch.gitlab.io/rust-fuzzy-search/rust_fuzzy_search/fn.fuzzy_search_threshold.html) will take an additional `f32` as input and returns only tuples with score greater than the threshold.
- [fuzzy_search_best_n](https://enricoch.gitlab.io/rust-fuzzy-search/rust_fuzzy_search/fn.fuzzy_search_best_n.html) will take an additional `usize` arguments and returns the first `n` tuples.


## Usage

To use this crate, first add this to your Cargo.toml:

```toml
[dependencies]
rust-fuzzy-search = { git = "https://gitlab.com/EnricoCh/rust-fuzzy-search"}
```
Next, add this to your crate:

```rust
extern crate rust_fuzzy_search;

use rust_fuzzy_search::*;

fn main() {
// ...
}
```


## Building

To build the library use `cargo build`


## Testing

To test the library use `cargo test`


## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or http://apache.org/licenses/LICENSE-2.0)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

![MIT License](https://img.shields.io/static/v1.svg?label=📜%20License&message=MIT&color=informational)
![Apache 2.0 License](https://img.shields.io/static/v1.svg?label=📃%20License&message=Apache-2.0&color=informational)   

# Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.