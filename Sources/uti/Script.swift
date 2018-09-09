import Foundation
import CoreServices

/**
 * Represents a runnable item of work.
 */

class Script {

    /// The command to execute.
    let command: Command

    /// The console used to output messages.
    let console: Console

    /**
     * Creates a new script that runs the specified command and outputs to the given console.
     * - parameter command: The command to run.
     * - parameter console: The console where success and error messages should be printed.
     */

    init(command: Command, console: Console) {
        self.command = command
        self.console = console
    }

    // MARK: - Creating and Running a Script from CLI

    /**
     * Runs the script using arguments from the main function. Call this from the `main.swift`,
     * if you haven't parsed the arguments.
     * - parameter arguments: The raw arguments of the script.
     * - parameter
     */

    static func main(arguments: [String], console: Console) {
        // 1) Parse Arguments
        switch arguments.parseCommand() {
        case .success(let command):
            let script = Script(command: command, console: console)
            script.run()
        case .error(let error):
            handleError(error, console: console)
        }
    }

    private static func handleError(_ error: Error, console: Console) {
        switch error {
        case CommandParserError.invalidUsage(let command):
            printCommandSpecificError(command, console: console)
        case CommandParserError.missingCommandName:
            printGeneralUsage(to: console, error: nil)
        case CommandParserError.unknownCommand:
            printGeneralUsage(to: console, error: error as! CommandParserError)
        default:
            console.logError(error)
        }
    }

    // MARK: - Execution

    /**
     * Runs the script and outputs errors to the console.
     */

    func run() {
        do {
            try execute()
        } catch {
            console.logError(error)
        }
    }

    /// Executes the script and throws an error if needed.
    private func execute() throws {
        switch command {
        case .getUTI(let fileURL):
            let uti = try fileURL.fetchTypeIdentifier()
            console.log(uti)

        case .checkConformance(let expectedUTI, let fileURL):
            let uti = try fileURL.fetchTypeIdentifier()
            let conforms = UTTypeConformsTo(uti as CFString, expectedUTI as CFString)
            console.log(conforms ? "YES" : "NO")
        case .printHelp:
            Script.printGeneralUsage(to: console, error: nil)
        }
    }

    // MARK: - Usage

    /// Prints an error for a specific command.
    private static func printCommandSpecificError(_ command: CommandType, console: Console) {
        let text = "💥  Invalid usage of '\(command.rawValue)'." + "\n\n" + makeCommandUsage(for: command)
        console.log(text)
    }

    /// Creates the usage string for a specific command.
    private static func makeCommandUsage(for command: CommandType) -> String {
        var text = """
        - \(command.rawValue): \(command.description)
        usage: \(command.usage)
        """

        if let example = command.exampleUsage {
            text += "\nexample: \(example)"
        }

        return text
    }

    /// Prints the general usage text for the script.
    private static func printGeneralUsage(to console: Console, error: LocalizedError?) {
        let commands = CommandType.all.map(makeCommandUsage).joined(separator: "\n\n")

        let usageString = """
        uti: a tool to interact with universal type identifiers

        🌍  source code: https://github.com/alexaubry/uti
        📝  author: Alexis Aubry (https://alexaubry.fr)

        commands:
        \(commands)
        """

        if let errorDescription = error?.errorDescription {
            let errorText = "💥  " + errorDescription + "\n\n" + usageString
            console.logError(errorText)
        } else {
            console.log(usageString)
        }
    }

}
