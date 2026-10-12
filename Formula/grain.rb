class Grain < Formula
  desc "Local-first semantic code review"
  homepage "https://github.com/pranav2012/grain"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pranav2012/grain/releases/download/v0.1.0/grain-aarch64-apple-darwin.tar.xz"
      sha256 "a52baf066a2c1c5bd9076492f21a9df90de9e147ed69914fed13d6d816329366"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pranav2012/grain/releases/download/v0.1.0/grain-x86_64-apple-darwin.tar.xz"
      sha256 "4116f55b8134cea98c9a7732d6f8dec86055ad41d510188ecab99a68d012f5cd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pranav2012/grain/releases/download/v0.1.0/grain-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6ea93abaabd598d96a7e76bb043de1d712ebc480f04961c5398dd477bc048c75"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pranav2012/grain/releases/download/v0.1.0/grain-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2937dd8a2d74ff8d9cdb9a8fa36ed37d8a45d24cd8538994b3309af6d26fa498"
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
