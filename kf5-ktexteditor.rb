require "formula"

class Kf5Ktexteditor < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/ktexteditor-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/ktexteditor.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kguiaddons"
  depends_on "haraldf/kf5/kf5-kjobwidgets"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-kparts"

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index d94185b..20bd704 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -11,6 +11,7 @@ include(ECMSetupVersion)
 include(ECMGenerateHeaders)
 include(CMakePackageConfigHelpers)
 include(CheckFunctionExists)
+include(CheckSymbolExists)
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings)
 include(KDECMakeSettings)
@@ -86,7 +87,7 @@ install(FILES
 )
 
 # config.h
-check_function_exists (fdatasync HAVE_FDATASYNC)
+check_symbol_exists (fdatasync unistd.h HAVE_FDATASYNC)
 configure_file (config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h)
 
 # let our config.h be found first in any case
