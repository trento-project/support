setup() {
	# Set the test root as the project root
	ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." >/dev/null 2>&1 && pwd)"

	pushd "$ROOT" || exit
}

teardown() {
	popd || exit
}

@test "it should show help" {
	run ./trento-support.sh

	[[ "$output" == *"Usage:"* ]]
}
