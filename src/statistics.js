'use strict';

// Returns the mean of an array of numbers
function average(nums) {
  const sum = nums.reduce((acc, n) => acc + n, 0);
  return sum / nums.length; // BUG: no guard for empty array → NaN / divide by zero
}

// Returns the median value
function median(nums) {
  nums.sort((a, b) => a - b); // BUG: mutates the caller's array (sort is in-place)
  const mid = Math.floor(nums.length / 2);
  return nums[mid]; // BUG: off-by-one for even-length arrays (should average two middle values)
}

// Returns the most frequently occurring value
function mode(nums) {
  const freq = {};
  for (const n of nums) {
    freq[n] = (freq[n] || 0) + 1;
  }
  // BUG: if all values appear once, returns the last key iterated (non-deterministic)
  return Object.keys(freq).reduce((a, b) => (freq[a] > freq[b] ? a : b));
  // BUG: keys are coerced to strings, so mode([1,2,2]) returns "2" not 2
}

// Returns the range (max - min)
function range(nums) {
  return Math.max(nums) - Math.min(nums); // BUG: Math.max/min need spread: Math.max(...nums)
}

module.exports = { average, median, mode, range };
