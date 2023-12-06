@main
public struct AdventOfCode {
    public static func main() {
        guard let input = Resource.getInput(index: 0) else {
            Logger.e("Main", "No input data!")
            return
        }
    }
}
