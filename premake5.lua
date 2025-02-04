project "NFD"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "on" 


    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    -- common files
    files {
        "src/*.h",
        "src/include/*.h",
        "src/nfd_common.c",
    }

    includedirs {
        "src/include/"
    }

    warnings "extra"

    -- system build filters
    filter "system:windows"
        language "C++"
        files {
            "src/nfd_win.cpp"
        }

    filter {"action:gmake or action:xcode4"}
        buildoptions {"-fno-exceptions"}

    filter "system:macosx"
        language "C"
        files {
            "src/nfd_cocoa.m"
        }



    filter {"system:linux", "options:linux_backend=gtk3"}
        language "C"
        files {
            "src/nfd_gtk.c"
        }
        buildoptions {"`pkg-config --cflags gtk+-3.0`"}

    filter {"system:linux", "options:linux_backend=zenity"}
        language "C"
        files {
            "src/nfd_zenity.c"
        }


    -- visual studio filters
    filter "action:vs*"
        defines { "_CRT_SECURE_NO_WARNINGS" }      