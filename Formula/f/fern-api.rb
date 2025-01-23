class FernApi < Formula
  desc "Stripe-level SDKs and Docs for your API"
  homepage "https://buildwithfern.com/"
  url "https://registry.npmjs.org/fern-api/-/fern-api-0.51.1.tgz"
  sha256 "f84a47b8a9c138323aace6bfbfa9f4c49ad21dff3600586095868cb488a90e92"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "4da8a11c2374f3119c00d86f5582ba1bb68e9bcf7aa5b679e77cf1a369771f11"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"fern", "init", "--docs", "--org", "brewtest"
    assert_path_exists testpath/"fern/docs.yml"
    assert_match "\"organization\": \"brewtest\"", (testpath/"fern/fern.config.json").read

    system bin/"fern", "--version"
  end
end
