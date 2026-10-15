class Grain < Formula
  desc "Local-first semantic code review"
  homepage "https://github.com/pranav2012/grain"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pranav2012/grain/releases/download/v0.4.0/grain-aarch64-apple-darwin.tar.xz"
      sha256 "f1cd8541b7fff4603c505d20d8bac2606f26f13b1e41cc41cbcd88d9e5b73d19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pranav2012/grain/releases/download/v0.4.0/grain-x86_64-apple-darwin.tar.xz"
      sha256 "491f7345ad66cae5f07c212bb77207822531f53f29cf266552a2c914d836b879"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pranav2012/grain/releases/download/v0.4.0/grain-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0b3fb335c6b2c2193d1e500b313b5ccb4ae2b119cfffc6cb9f2ba609f2919857"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pranav2012/grain/releases/download/v0.4.0/grain-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "afda312d69b0b2ab4f589af32b7c44e21c82adddd1ae29cea5bf17dc433fd460"
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
