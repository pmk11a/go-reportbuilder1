package seeders

import "os"

// osReadFile is a thin wrapper that allows tests/mocks to swap the implementation.
var osReadFile = os.ReadFile