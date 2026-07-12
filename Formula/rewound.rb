class Rewound < Formula
  desc "Grep for everything your AI coding agents ever did"
  homepage "https://github.com/Dashorama/rewound"
  url "https://registry.npmjs.org/rewound/-/rewound-0.2.0.tgz"
  sha256 "080fe7184e6b5a3d0ed913b93aa9f824fff06111dbfcd21008bfbe7c7739ce4d"
  license :cannot_represent # source-available: free for personal use, paid commercial — see repo LICENSE

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    ENV["REWOUND_DB"] = (testpath/"test.db").to_s
    (testpath/"projects/-tmp-demo").mkpath
    (testpath/"projects/-tmp-demo/demo.jsonl").write <<~EOS
      {"type":"user","uuid":"u1","timestamp":"2026-01-01T00:00:00.000Z","cwd":"/tmp/demo","sessionId":"demo","message":{"role":"user","content":"hello homebrew smoke test"}}
    EOS
    system bin/"rewound", "index", "--roots", testpath/"projects"
    assert_match "homebrew", shell_output("#{bin}/rewound search homebrew")
  end
end
