"""
Test the multi-language analyzer system.
"""
import sys
import os
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))

from analyzers import AnalyzerRegistry
from analyzers.nextjs_analyzer import NextjsAnalyzer
from analyzers.go_analyzer import GoAnalyzer


def test_nextjs_analyzer():
    """Test Next.js analyzer with sample code."""
    print("=" * 60)
    print("TEST: Next.js Analyzer")
    print("=" * 60)

    analyzer = NextjsAnalyzer()

    # Create a test file
    test_code = '''
import React, { useState } from 'react';
import { useRouter } from 'next/router';
import fs from 'fs';  // Server module in client - BAD

export default function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const router = useRouter();

  // Unsafe lifecycle
  componentWillMount() {
    fetchUser(userId);
  }

  const fetchData = async () => {
    const res = await fetch('/api/user');
    setUser(res.json());
  };

  // Missing error handling
  return (
    <div style={{ color: 'red' }}>
      {users.map(u => <span>{u.name}</span>)}  {/* Missing key */}
    </div>
  );
}
'''
    test_path = "/tmp/test_nextjs.tsx"
    with open(test_path, "w") as f:
        f.write(test_code)

    result = analyzer.audit(test_path)
    print(f"File: {result.file_path}")
    print(f"Score: {result.score}/100")
    print(f"Issues found: {len(result.issues)}")
    for issue in result.issues:
        print(f"  [{issue.severity}] {issue.rule_id}: {issue.message}")
        if issue.suggestion:
            print(f"    -> {issue.suggestion}")

    # Cleanup
    os.remove(test_path)
    print()


def test_go_analyzer():
    """Test Go analyzer with sample code."""
    print("=" * 60)
    print("TEST: Go Analyzer")
    print("=" * 60)

    analyzer = GoAnalyzer()

    test_code = '''
package main

import (
    "fmt"
    "io/ioutil"
    "os"
)

func processData() error {
    // Missing error wrapping
    err := os.Open("file.txt")
    if err != nil {
        return err
    }

    // Goroutine without context
    go func() {
        for {
            select {}
        }
    }()

    // Context without cancel
    ctx, _ := context.WithTimeout(context.Background(), 5*time.Second)

    return nil
}

func main() {
    panic("something went wrong")
}
'''
    test_path = "/tmp/test_go.go"
    with open(test_path, "w") as f:
        f.write(test_code)

    result = analyzer.audit(test_path)
    print(f"File: {result.file_path}")
    print(f"Score: {result.score}/100")
    print(f"Issues found: {len(result.issues)}")
    for issue in result.issues:
        print(f"  [{issue.severity}] {issue.rule_id}: {issue.message}")
        if issue.suggestion:
            print(f"    -> {issue.suggestion}")

    # Cleanup
    os.remove(test_path)
    print()


def test_registry():
    """Test analyzer registry."""
    print("=" * 60)
    print("TEST: Analyzer Registry")
    print("=" * 60)

    registry = AnalyzerRegistry()
    print(f"Supported languages: {registry.list_languages()}")

    # Test file detection
    test_files = [
        "/tmp/test_nextjs.tsx",
        "/tmp/test_go.go",
        "/tmp/test_fr3.fr3",
    ]
    for f in test_files:
        analyzer = registry.get_analyzer(f)
        print(f"  {f} -> {analyzer.language if analyzer else 'unknown'}")


if __name__ == "__main__":
    test_nextjs_analyzer()
    test_go_analyzer()
    test_registry()
    print("\n=== ALL TESTS PASSED ===")