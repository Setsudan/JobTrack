import com.android.build.gradle.LibraryExtension

plugins {
    id("com.android.library") apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    afterEvaluate {
        extensions.findByType(LibraryExtension::class.java)?.let { androidLib ->
            if (name.contains("isar_flutter_libs")) {
                val ns = androidLib.namespace
                if (ns == null || ns.isEmpty()) {
                    androidLib.namespace = "dev.isar.isar_flutter_libs"
                }
                // Package ships compileSdk 30; androidx resources need API 31+ (android:attr/lStar).
                androidLib.compileSdk = maxOf(androidLib.compileSdk ?: 0, 34)
            }
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
