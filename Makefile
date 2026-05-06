# SPDX-FileCopyrightText: SUSE LLC
# SPDX-License-Identifier: Apache-2.0

.PHONY: test
test:
	bats -r ./test

.PHONY: lint
lint:
	find . \( -name "*.sh" -o -name "*.bats" \) -type f -exec shellcheck -s bash  {} +

.PHONY: lint-fix
lint-fix:
	find . \( -name "*.sh" -o -name "*.bats" \) -type f -exec shellcheck -s bash -a -f diff {} + | patch -p1

.PHONY: fmt
fmt:
	find . \( -name "*.sh" -o -name "*.bats" \) -type f -exec shfmt -w {} +

.PHONY: fmt-check
fmt-check:
	find . \( -name "*.sh" -o -name "*.bats" \) -type f -exec shfmt -d {} +