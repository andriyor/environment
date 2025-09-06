#!/usr/bin/env node
// not works with invalid json

const fs = require('fs');
const readline = require('readline');

// Configuration
const outputFile = process.argv[2] || 'output.jsonl';
const writeStream = fs.createWriteStream(outputFile, { flags: 'a' });

// State for tracking multiline JSON
let buffer = '';
let bracketCount = 0;  // For curly braces
let squareBracketCount = 0;  // For square brackets
let isCollectingJSON = false;

// Create readline interface
const rl = readline.createInterface({
  input: process.stdin,
  terminal: false
});

// Process each line from stdin
rl.on('line', (line) => {
  // Try to pretty-print JSON for terminal display
  let prettyPrinted = false;

  if (line.trim()) {
    try {
      // Check if it's valid JSON
      const parsedJson = JSON.parse(line);
      // If it parsed successfully, pretty-print it to the terminal
      console.log(JSON.stringify(parsedJson, null, 2));
      prettyPrinted = true;
    } catch (e) {
      // Try as JavaScript object or array literal
      if ((line.trim().startsWith('{') && line.trim().endsWith('}')) ||
        (line.trim().startsWith('[') && line.trim().endsWith(']'))) {
        try {
          const obj = eval(`(${line})`);
          if ((typeof obj === 'object' && obj !== null) || Array.isArray(obj)) {
            console.log(JSON.stringify(obj, null, 2));
            prettyPrinted = true;
          }
        } catch (evalErr) {
          // Not a valid object/array literal, will display original below
        }
      }

      if (!prettyPrinted) {
        // Not valid JSON or object literal, display the original line
        console.log(line);
      }
    }
  } else {
    // Empty line, just echo it
    console.log(line);
  }

  // If we're collecting a multiline JSON object or array
  if (isCollectingJSON) {
    buffer += '\n' + line;

    // Update bracket counts
    bracketCount += (line.match(/{/g) || []).length || 0;
    bracketCount -= (line.match(/}/g) || []).length || 0;

    squareBracketCount += (line.match(/\[/g) || []).length || 0;
    squareBracketCount -= (line.match(/\]/g) || []).length || 0;

    // Check if we've reached the end of the multiline structure
    if ((bracketCount <= 0 && buffer.trim().startsWith('{')) ||
      (squareBracketCount <= 0 && buffer.trim().startsWith('['))) {
      // End of multiline JSON
      isCollectingJSON = false;
      tryProcessAsJSON(buffer);
      buffer = '';
      bracketCount = 0;
      squareBracketCount = 0;
    }
    return;
  }

  // Check if this might be the start of a JSON object or array
  if (line.includes('{') || line.includes('[')) {
    // Count opening and closing brackets
    const openCurlyCount = (line.match(/{/g) || []).length;
    const closeCurlyCount = (line.match(/}/g) || []).length;
    bracketCount = openCurlyCount - closeCurlyCount;

    const openSquareCount = (line.match(/\[/g) || []).length;
    const closeSquareCount = (line.match(/\]/g) || []).length;
    squareBracketCount = openSquareCount - closeSquareCount;

    // Start collection if we have unmatched brackets
    if ((bracketCount > 0 && line.includes('{')) ||
      (squareBracketCount > 0 && line.includes('['))) {
      // Start of a multiline JSON structure
      isCollectingJSON = true;
      buffer = line;
      return;
    }
  }

  // Try to process as JSON
  tryProcessAsJSON(line);
});

// Handle end of input
rl.on('close', () => {
  // Process any remaining buffer content
  if (buffer) {
    tryProcessAsJSON(buffer);
  }

  writeStream.end();
  console.error(`\nJSON output written to ${outputFile}`);
});

// Try to process a string as JSON
function tryProcessAsJSON(str) {
  str = str.trim();
  if (!str) return;

  // First try as standard JSON
  try {
    // Parse and then pretty-print with 2-space indentation
    const parsedJson = JSON.parse(str);
    writeStream.write(JSON.stringify(parsedJson, null, 2) + '\n');
    return;
  } catch (err) {
    // Not valid JSON, try as JavaScript object or array literal
    if ((str.startsWith('{') && str.endsWith('}')) ||
      (str.startsWith('[') && str.endsWith(']'))) {
      try {
        // Try to evaluate as object/array literal
        const obj = eval(`(${str})`);
        if ((typeof obj === 'object' && obj !== null) || Array.isArray(obj)) {
          // Pretty-print with 2-space indentation
          writeStream.write(JSON.stringify(obj, null, 2) + '\n');
          return;
        }
      } catch (evalErr) {
        // Not a valid object/array literal
      }
    }

    // If we reach here, it's not JSON, object literal, or array literal
    // Only write non-JSON lines if they have meaningful content
    if (str.trim() && !/^\s*$/.test(str)) {
      writeStream.write(JSON.stringify({ type: 'non-json', content: str }) + '\n');
    }
  }
}

// Handle errors
process.on('uncaughtException', (err) => {
  console.error('Error:', err);
  process.exit(1);
});
