# Contributing to Advanced Image Color

Thank you for your interest in contributing to Advanced Image Color! This document provides guidelines for contributing to the project.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/advanced_image_color.git`
3. Create a new branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Run tests: `flutter test`
6. Commit your changes: `git commit -am 'Add some feature'`
7. Push to the branch: `git push origin feature/your-feature-name`
8. Submit a pull request

## Development Guidelines

### Code Style

- Follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter format` to format your code
- Ensure code passes `flutter analyze` with no warnings
- Use meaningful variable and function names
- Add comments for complex logic

### Documentation

- Document all public APIs with dartdoc comments
- Include code examples in documentation
- Update README.md if adding new features
- Update CHANGELOG.md following [Keep a Changelog](https://keepachangelog.com/) format

### Testing

- Write tests for all new features
- Ensure all existing tests pass
- Aim for high test coverage
- Include both unit tests and widget tests where applicable

### Commit Messages

- Use clear and descriptive commit messages
- Start with a verb in present tense (Add, Fix, Update, etc.)
- Keep the first line under 50 characters
- Provide detailed description in the body if needed

Example:
```
Add support for custom intensity parameter

- Added intensity parameter to buildColorMatrix
- Updated documentation with examples
- Added tests for custom intensity values
```

## Pull Request Process

1. Ensure all tests pass
2. Update documentation as needed
3. Add an entry to CHANGELOG.md
4. Ensure code is formatted and analyzed
5. Request review from maintainers
6. Address any feedback

## Code Review

All submissions require review. We use GitHub pull requests for this purpose. Reviewers will check for:

- Code quality and style
- Test coverage
- Documentation completeness
- Breaking changes
- Performance implications

## Feature Requests and Bug Reports

- Use GitHub Issues to report bugs or request features
- Search existing issues before creating a new one
- Provide as much detail as possible
- Include code samples for bug reports
- Include expected vs actual behavior

### Bug Report Template

```
**Description**
A clear description of the bug

**To Reproduce**
Steps to reproduce the behavior:
1. Create widget with...
2. Apply color...
3. See error

**Expected Behavior**
What you expected to happen

**Screenshots**
If applicable

**Environment**
- Flutter version:
- Dart version:
- Package version:
- Platform (iOS/Android/Web/Desktop):
```

### Feature Request Template

```
**Is your feature request related to a problem?**
A clear description of the problem

**Describe the solution you'd like**
A clear description of what you want to happen

**Describe alternatives you've considered**
Alternative solutions or features you've considered

**Additional context**
Any other context or screenshots
```

## Questions?

If you have questions, feel free to:
- Open an issue with the "question" label
- Start a discussion in GitHub Discussions
- Reach out to the maintainers

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

Thank you for contributing! 🎉
