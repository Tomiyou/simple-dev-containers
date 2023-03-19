use std::process::Command;

use clap::{Parser, Args, Subcommand};

#[derive(Parser)]
#[clap(author = "Author Name", version, about)]
/// Quickly and simply spin up docker containers
struct Arguments {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    Run(Run),
    Create(Create),
    Remove(Remove),
    Uninstall(Uninstall),
}

#[derive(Args)]
struct Run {
    container_name: String,
    user: Option<String>,
}

#[derive(Args)]
struct Create {
    container_name: String,
    source_image: String,
}

#[derive(Args)]
struct Remove {
    container_name: String,
}

#[derive(Args)]
struct Uninstall {
}

fn get_current_user() -> String {
    String::from_utf8(
        Command::new("whoami")
            .output()
            .unwrap()
            .stdout
    ).unwrap()
}

fn container_running(name: &String) -> Result<bool, std::io::Error> {
    // docker container inspect -f '{{.State.Running}}'
    let process = Command::new("docker")
        .arg("container")
        .arg("inspect")
        .arg("-f")
        .arg("'{{.State.Running}}'")
        .arg(name)
        .output()?;

    let output = String::from_utf8(process.stdout).unwrap();

    match output.as_str() {
        "'true'\n" => Ok(true),
        "'false'\n" => Ok(false),
        _ => panic!("'docker ps' bad output: {}", output)
    }
}

fn run(args: &Run) {
    let is_container_running = match container_running(&args.container_name) {
        Ok(state) => state,
        Err(_err) => return println!("Container must be created first! Try running 'simple-docker-run crate'"),
    };

    let current_user = get_current_user();

    let user = match &args.user {
        Some(user) => &user,
        None => &current_user,
    };

    if is_container_running {
        println!("Attaching to an existing docker container as $DOCKER_USER");

        let command = Command::new("docker")
            .arg("exec")
            .arg("--user")
            .arg(user)
            .arg("-it")
            .arg(args.container_name.clone())
            .arg("/bin/bash");
    } else {
        println!("Starting an existing docker container");

        Command::new("docker")
            .arg("start")
            .arg("-a")
            .arg("-i")
            .arg(args.container_name.clone())
            .unwrap();
    }
}

fn create(args: &Create) {

}

fn remove(args: &Remove) {

}

fn uninstall(args: &Uninstall) {

}

fn main() {
    let args = Arguments::parse();
    match args.command {
        Commands::Run(args) => run(&args),
        Commands::Create(args) => create(&args),
        Commands::Remove(args) => remove(&args),
        Commands::Uninstall(args) => uninstall(&args),
    };
}
