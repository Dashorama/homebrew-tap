class Rewound < Formula
  desc "Grep for everything your AI coding agents ever did"
  homepage "https://github.com/Dashorama/rewound"
  url "https://registry.npmjs.org/rewound/-/rewound-0.5.0.tgz"
  sha256 "fe4b52e924ea921e5cf7eb43d2c4a799fa6891ab5a3e6bf528ab1de98071404f"
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
