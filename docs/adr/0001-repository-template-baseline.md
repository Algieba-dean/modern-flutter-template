# ADR 0001: Repository Template Baseline

## Status

Accepted

## Context

Flutter projects in this organization should start with consistent repository
automation, platform support, code style, and integration testing conventions.

## Decision

Use this repository as the baseline GitHub template for enterprise Flutter
applications. The template includes:

- Android, iOS, Web, macOS, Windows, and Linux host projects
- strict Dart analysis rules
- GitHub Actions for quality and platform build validation
- Patrol as the default device-level integration testing framework
- Issue templates, PR template, labels, release drafting, and stale management
- documentation for architecture, workflow, testing, and releases

## Consequences

New projects start with a higher quality floor and less repository setup work.
Teams still need to make project-specific decisions for state management,
routing, networking, analytics, crash reporting, design systems, signing, and
release distribution.
