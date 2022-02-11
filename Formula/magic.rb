class Magic < Formula
    desc "Magic VLSI Layout Tool"
    homepage "https://opencircuitdesign.com/magic/"
    head "https://github.com/RTimothyEdwards/magic"
    version "8.3.266"
    url "https://github.com/RTimothyEdwards/magic/archive/refs/tags/#{version}.tar.gz"
    sha256 "122014fa6e2ee754308dcc86715f2765f7cf404a96ea1e458824109474b4abca"

    depends_on "make" => :build
    depends_on "gcc@11" => :build
    depends_on "cairo"
    depends_on "tcl-tk"

    def install
        gcc_path = "#{Formula["gcc@11"].bin}/gcc-11"
        gpp_path = "#{Formula["gcc@11"].bin}/g++-11"
        system "./configure",
            "--prefix=#{prefix}",
            "--with-tcl=#{Formula["tcl-tk"].opt_prefix}",
            "--with-tk=#{Formula["tcl-tk"].opt_prefix}",
            "--with-cairo=#{Formula["cairo"].opt_include}",
            "CC=#{gcc_path}",
            "CXX=#{gpp_path}"
        system "make", "-j#{`sysctl -n hw.ncpu`.chomp}"
        system "make", "install"
    end
end