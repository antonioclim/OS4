# Web Seminar 01: Parallel Processing

This is a modern web-based seminar module demonstrating parallel processing concepts using JavaScript and modern testing infrastructure.

## Features

- Interactive demonstration of sequential vs parallel processing
- Modern ES6+ JavaScript modules
- Comprehensive test suite using Vitest
- DOM testing with @testing-library/dom
- JSDOM environment for browser simulation

## Setup

Install dependencies:
```bash
npm install
```

## Running Tests

Run tests once:
```bash
npm test
```

Run tests in watch mode (for development):
```bash
npm run test:watch
```

## Project Structure

- `index.html` - Main seminar page with interactive demo
- `seminar.js` - Core JavaScript functionality demonstrating parallel processing
- `seminar.test.js` - Comprehensive test suite
- `vitest.config.js` - Vitest configuration
- `package.json` - Project configuration and dependencies

## Concepts Demonstrated

1. **Sequential Processing**: Tasks run one after another
2. **Parallel Processing**: Tasks run simultaneously using Promise.all()
3. **Performance Comparison**: Shows timing differences between approaches
4. **Modern JavaScript**: ES6 modules, async/await, Promises

## Usage

Open `index.html` in a web browser and click "Run Demo" to see the interactive demonstration of parallel vs sequential processing.

## Testing

The project includes comprehensive tests that verify:
- ParallelDemo class functionality
- Timing accuracy for sequential and parallel execution
- DOM manipulation functions
- Performance differences between processing approaches

All tests run in a JSDOM environment to simulate browser behavior without requiring a real browser.