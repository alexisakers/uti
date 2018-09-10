# uti

`uti` a command line tool that provides helpers to interact with Universal Type Identifiers on macOS. It allows you to get the UTI of a file on disk, and to check that a type conforms to the specified UTI.

## Usage

~~~
uti: a tool to interact with universal type identifiers

🌍  source code: https://github.com/alexaubry/uti
📝  author: Alexis Aubry (https://alexaubry.fr)

commands:
- get: Get the Uniform Type Identifier of a file.
usage: uti get <file URL>
example: uti get ~/Desktop

- conforms: Check that a file conforms to the specified type.
usage: uti <UTI to check> <file URL>
example: uti conforms public.folder ~/Desktop

- help: Print the instructions to use the program.
usage: uti help
~~~

## Installation

### With Homebrew

You can install the utility using Homebrew by running this in a terminal.

~~~bash
brew install alexaubry/formulas/uti
~~~

### From Source

To build the program for source and install it on your machine, run this in a terminal:

~~~bash
git clone https://github.com/alexaubry/uti
cd uti
sh build.sh
~~~

## Contributing

The utility was built as a Swift package. It is composed of two targets: the framework that contains the logic, and and an executable that launches that logic.

### Requirements

- To develop `uti`, you will need **Swift 4.1**.
- Please make sure to read the `[Contribution Guide](CONTRIBUTING.md)` before contributing
