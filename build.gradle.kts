@file:Suppress("GradlePackageUpdate")

import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    kotlin("jvm")
    id("org.jlleitschuh.gradle.ktlint")
    application
}

application {
    mainClass.set("ApplicationKt")
}

allprojects {
    repositories {
        maven("")
    }

    dependencies {
        implementation("com.sksamuel.hoplite:hoplite-core:_")
        implementation("com.sksamuel.hoplite:hoplite-hocon:_")
        implementation("io.micrometer:micrometer-registry-influx:_")

        testImplementation("org.junit.jupiter:junit-jupiter-api:_")
        testImplementation("org.junit.jupiter:junit-jupiter-engine:_")
        testImplementation("io.kotest:kotest-assertions-core:_")
        testImplementation("io.mockk:mockk:_")
        testImplementation(kotlin("test"))
    }

    tasks {
        withType<KotlinCompile> {
            compilerOptions {
                jvmTarget.set(JvmTarget.JVM_21)
                allWarningsAsErrors.set(true)
            }

            dependsOn("ktlintFormat")
        }
    }
}