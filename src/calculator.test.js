'use strict';

const { add, subtract, multiply, divide, power, factorial, clamp } = require('./calculator');

describe('add', () => {
  test('adds two positive numbers', () => expect(add(2, 3)).toBe(5));
  test('adds negative numbers', () => expect(add(-1, -2)).toBe(-3));
  test('adds zero', () => expect(add(5, 0)).toBe(5));
});

describe('subtract', () => {
  test('subtracts numbers', () => expect(subtract(10, 4)).toBe(6));
  test('result can be negative', () => expect(subtract(3, 7)).toBe(-4));
});

describe('multiply', () => {
  test('multiplies numbers', () => expect(multiply(3, 4)).toBe(12));
  test('multiply by zero', () => expect(multiply(5, 0)).toBe(0));
  test('multiply negatives', () => expect(multiply(-2, 3)).toBe(-6));
});

describe('divide', () => {
  test('divides numbers', () => expect(divide(10, 2)).toBe(5));
  test('returns float', () => expect(divide(7, 2)).toBe(3.5));
  test('throws on division by zero', () => {
    expect(() => divide(5, 0)).toThrow('Division by zero');
  });
});

describe('power', () => {
  test('raises to power', () => expect(power(2, 10)).toBe(1024));
  test('power of zero', () => expect(power(5, 0)).toBe(1));
});

describe('clamp', () => {
  test('leaves a value inside the range untouched', () => expect(clamp(5, 1, 10)).toBe(5));
  test('clamps a value below the range up to min', () => expect(clamp(-3, 1, 10)).toBe(1));
  test('clamps a value above the range down to max', () => expect(clamp(42, 1, 10)).toBe(10));
});

describe('factorial', () => {
  test('factorial of 0', () => expect(factorial(0)).toBe(1));
  test('factorial of 5', () => expect(factorial(5)).toBe(120));
  test('throws on negative', () => {
    expect(() => factorial(-1)).toThrow();
  });
  test('throws on non-integer', () => {
    expect(() => factorial(2.5)).toThrow();
  });
});
