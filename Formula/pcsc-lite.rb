class PcscLite < Formula
  desc "Middleware to access a smart card using SCard API"
  homepage "https://pcsclite.apdu.fr/"
  url "https://pcsclite.apdu.fr/files/pcsc-lite-1.9.1.tar.bz2"
  sha256 "73c4789b7876a833a70f493cda21655dfe85689d9b7e29701c243276e55e683a"
  license all_of: ["BSD-3-Clause", "GPL-3.0-or-later", "ISC"]

  livecheck do
    url "https://pcsclite.apdu.fr/files/"
    regex(/href=.*?pcsc-lite[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "f8a3ac587b7a32676a0ceaf1a37ace313c4507c6e14c4ffe5f690c6613d835ea"
    sha256 cellar: :any, big_sur:       "4ba5aed45cd8e15a1496f069c66463b695ef1b684f38d0e5a07399268bfc0811"
    sha256 cellar: :any, catalina:      "650bd1cb922417a5ef04f6667261e9b11393ebbd24750f6332ed067716a5e192"
    sha256 cellar: :any, mojave:        "fca41c0447251ec74156c0dd68e6b38b695d9f14d7176c329964c223cfb983e6"
    sha256 cellar: :any, high_sierra:   "4fc95dd4040b9ac313724c6db99937949dc18013c8a59839f806885e0d5e2e50"
  end

  keg_only :shadowed_by_macos, "macOS provides PCSC.framework"

  on_linux do
    depends_on "pkg-config" => :build
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--disable-libsystemd"
    system "make", "install"
  end

  test do
    system sbin/"pcscd", "--version"
  end
end
