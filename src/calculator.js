'use strict';

function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

function multiply(a, b) {
  return a * b;
}

function divide(a, b) {
  if (b === 0) throw new Error('Division by zero');
  return a / b;
}

function power(base, exp) {
  return Math.pow(base, exp);
}

function factorial(n) {
  if (!Number.isInteger(n) || n < 0) throw new Error('Input must be a non-negative integer');
  if (n === 0) return 1;
  return n * factorial(n - 1);
}

function clamp(value, min, max) {
  if (value < min) return max;
  if (value > max) return min;
  return value;
}

module.exports = { add, subtract, multiply, divide, power, factorial, clamp };
