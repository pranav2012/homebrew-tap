class Grain < Formula
  desc "Local-first semantic code review"
  homepage "https://github.com/pranav2012/grain"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pranav2012/grain/releases/download/v0.5.0/grain-aarch64-apple-darwin.tar.xz"
      sha256 "3b243518b9ed242828c9f1d1b5a5d9690c4fc30b11b9ceac4950a9409d341e0d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pranav2012/grain/releases/download/v0.5.0/grain-x86_64-apple-darwin.tar.xz"
      sha256 "cf22c885d305cd1c80fa04e49b50d2d5d42653b8144f9a814cce22318a56d531"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pranav2012/grain/releases/download/v0.5.0/grain-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "63eedb5c3f60739e46311a20c99bc451a9a4e7823a06428cb0fc52d75bec9495"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pranav2012/grain/releases/download/v0.5.0/grain-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0c05d6a2d90d7dcf09219ce1a79b7338a46c431f9d70e089a781c8f5391fe414"
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
