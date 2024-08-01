rootProject.name = "kotlin-base"

plugins {
    id("de.fayard.refreshVersions") version "0.60.5"
}

refreshVersions {
    rejectVersionIf {
        @Suppress("UnstableApiUsage")
        candidate.stabilityLevel.isLessStableThan(current.stabilityLevel)
    }
}