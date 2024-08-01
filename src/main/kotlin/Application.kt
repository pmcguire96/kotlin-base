import java.util.*

fun main() {
    // Use UTC offset regardless of configured system time
    TimeZone.setDefault(TimeZone.getTimeZone("UTC"))
}