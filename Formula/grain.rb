class Grain < Formula
  desc "Local-first semantic code review"
  homepage "https://github.com/pranav2012/grain"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pranav2012/grain/releases/download/v0.6.0/grain-aarch64-apple-darwin.tar.xz"
      sha256 "731f2a8f9b3d43ade642af78d35335d7e5adbc21ddb1e53b8269941810cbd1b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pranav2012/grain/releases/download/v0.6.0/grain-x86_64-apple-darwin.tar.xz"
      sha256 "a1ee90de48402cc450b90037dde3944f81a2f927b8a0e4d7497b8020038237e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pranav2012/grain/releases/download/v0.6.0/grain-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "165cf78d116f2e0cb74b25ae2e6c244d61b9680e00a892017f178e1f23870ebd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pranav2012/grain/releases/download/v0.6.0/grain-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "74f5ffd73ba95b6aaa96492b4359a2a5ca4297e7c6d6f5ed95f3d3e9fc53d3ea"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "grain"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "grain"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "grain"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "grain"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
