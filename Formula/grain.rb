class Grain < Formula
  desc "Local-first semantic code review"
  homepage "https://github.com/pranav2012/grain"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pranav2012/grain/releases/download/v0.3.0/grain-aarch64-apple-darwin.tar.xz"
      sha256 "4699d74346fbd4ff352562e5cbe850914e68e2ca0607471caeaba7db296e0f90"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pranav2012/grain/releases/download/v0.3.0/grain-x86_64-apple-darwin.tar.xz"
      sha256 "f864eec87b239d86c198716455cf81bdeaece150ec00a2342bdeb4ad47603550"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pranav2012/grain/releases/download/v0.3.0/grain-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2fa499ff7838a54a2bad107fcfbd848cabb2bac0891237c9ca66fa07c8613c52"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pranav2012/grain/releases/download/v0.3.0/grain-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "086d81901cffe13c10f4d3f536dd15dc38b14bc940bbe6c0de63c9d5f96dd655"
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
