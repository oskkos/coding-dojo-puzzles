// https://kata-log.rocks/bowling-game-kata
fun main() {
    print("What's your name? ")
    val name = readln()
    println("Hello, $name! Let's get the Bowling Game going!")

    val game = Game()
    for (frame in 1..<11) {
        println("Enter the number of pins knocked down in frame $frame")
        print(" - roll 1: ")
        val pins = readln().toInt()
        var pins2 = 0
        game.roll(pins)
        if (pins < 10 || frame == 10) {
            print(" - roll 2: ")
            pins2 = readln().toInt()
            game.roll(pins2)
        }
        if (frame == 10 && (pins + pins2) >= 10) {
            print(" - roll 3: ")
            val pins3 = readln().toInt()
            game.roll(pins3)
        }
        println("Score after round: ${game.score()}")
    }
}

class Game {
    private var rolls = IntArray(20)
    private var currentRoll = 0
    private var twoBonuses = 0
    private var oneBonus = 0
    private var score = 0

    fun roll(pins: Int) {
        handleBonuses(pins)

        // We are at last frames bonus rolls, don't add the actual pins to the score
        if (currentRoll >= 20) {
            return
        }
        rolls[currentRoll++] = pins
        if (isStrike(pins)) {
            print(" ** Strike! ** ")
            twoBonuses++
            currentRoll++
        } else if (isSpare(pins)){
            print(" ** Spare! ** ")
            oneBonus++
        }
        score += pins
    }

    fun score(): Int {
        return score
    }

    private fun handleBonuses(pins: Int) {
        if (oneBonus > 0) {
            score += pins
            oneBonus--
        }
        if (twoBonuses > 0) {
            score += pins
            twoBonuses--
            oneBonus++
        }
    }
    private fun isStrike(pins: Int): Boolean {
        return pins == 10 && currentRoll <= 19
    }
    private fun isSpare(pins: Int): Boolean {
        return currentRoll > 1 && currentRoll %2 == 0 && pins + rolls[currentRoll - 2] == 10
    }
}

