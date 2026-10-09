class Rewound < Formula
  desc "Grep for everything your AI coding agents ever did"
  homepage "https://github.com/Dashorama/rewound"
  url "https://registry.npmjs.org/rewound/-/rewound-0.5.2.tgz"
  sha256 "e43f77f735581cf346a0ee5e35f4281ff0bf7b100fb4d2975fc6d56edf9ca80c"
  license :cannot_represent # source-available: free for personal use, paid commercial — see repo LICENSE

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(ignore_scripts: false) # better-sqlite3 needs its install script to fetch/build its native addon (rewound#4)
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
