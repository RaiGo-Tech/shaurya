import { execSync } from "node:child_process";
import { existsSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";

const flutterHome = join(homedir(), "flutter");
const flutterBin = join(flutterHome, "bin", "flutter");

function run(command) {
  console.log(`\n> ${command}`);
  execSync(command, {
    stdio: "inherit",
    env: {
      ...process.env,
      PATH: `${join(flutterHome, "bin")}:${process.env.PATH ?? ""}`,
      CI: "true",
    },
  });
}

try {
  run("git config --global --add safe.directory '*'");
} catch {
  // ignore if git config fails
}

if (!existsSync(flutterBin)) {
  run(
    `git clone https://github.com/flutter/flutter.git -b stable --depth 1 "${flutterHome}"`,
  );
}

run("flutter --version");
run("flutter config --enable-web --no-analytics");
run("flutter precache --web");
run("flutter pub get");
run("flutter build web --release --base-href /");

if (!existsSync("build/web/index.html")) {
  console.error("ERROR: build/web/index.html was not created");
  process.exit(1);
}

console.log("\nVercel web build completed successfully.");
