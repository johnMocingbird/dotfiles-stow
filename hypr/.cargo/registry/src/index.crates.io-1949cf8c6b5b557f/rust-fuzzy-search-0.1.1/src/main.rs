use rust_fuzzy_search::*;

fn main() {
    fuzzy_compare("kolbaso", "kolbasobulko");
}

#[allow(dead_code)]
fn simple_search() {
    let s = "bulko";
    let list: Vec<&str> = vec!["kolbasobulko", "sandviĉo"];
    let res = fuzzy_search(&s, &list);
    for x in res {
        println!("{:?}", x)
    }
}

#[allow(dead_code)]
fn search_through_file() {
    use std::fs::File;
    use std::io::Read;

    // string to search in the file
    let input = "colos";

    // filename
    let filename = "src/example_file.txt";

    // creates a buffer and reads the file
    let mut buffer = String::new();
    File::open(filename)
        .unwrap()
        .read_to_string(&mut buffer)
        .unwrap();

    // split the string in the buffer in words
    let dict: Vec<&str> = buffer.split(' ').collect();

    // gets the n (10usize) best matches
    let ress = fuzzy_search_best_n(&input, &dict, 10usize);

    // prints all the matches
    for (x, d) in ress {
        println!("word : {:?} \t\t\t\t score : {:?}", x, d);
    }
}

#[allow(dead_code)]
fn repl_compare() {
    use std::io;
    loop {
        println!("write 2 lines:");

        // creates 2 buffers to read from stdin
        let mut buffer1 = String::new();
        let mut buffer2 = String::new();

        // reads 2 lines from stdin
        io::stdin().read_line(&mut buffer1).unwrap();
        io::stdin().read_line(&mut buffer2).unwrap();

        // test quit instruction (user typed something similar  to "quit")
        if fuzzy_compare(&buffer1, &"quit") > 0.9 {
            println!("quit : quitting");
            break;
        }

        // compares strings and prints the score
        let distance = fuzzy_compare(&buffer1, &buffer2);
        println!("distance is {:?}", distance);
    }
}

#[allow(dead_code)]
fn simple_searches() {
    println!(
        "bulubulu - bulubulu : {:?}",
        fuzzy_compare(&"bulubulu".to_string(), &"bulubulu".to_string())
    );
    println!(
        "sandviĉo - sandviĉo : {:?}",
        fuzzy_compare(&"sandviĉo".to_string(), &"sandviĉo".to_string())
    );
    println!(
        "sandviĉo - kolbasobulko : {:?}",
        fuzzy_compare(&"sandviĉo".to_string(), &"kolbasobulko".to_string())
    );
    println!(
        "varma vetero - vetero : {:?}",
        fuzzy_compare(&"varma vetero".to_string(), &"vetero".to_string())
    );
}
