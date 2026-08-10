'use strict';

// Returns the mean of an array of numbers
function average(nums) {
  const sum = nums.reduce((acc, n) => acc + n, 0);
  return sum / nums.length;
}

// Returns the median value
function median(nums) {
  nums.sort((a, b) => a - b);
  const mid = Math.floor(nums.length / 2);
  return nums[mid];
}

// Returns the most frequently occurring value
function mode(nums) {
  const freq = {};
  for (const n of nums) {
    freq[n] = (freq[n] || 0) + 1;
  }
  return Object.keys(freq).reduce((a, b) => (freq[a] > freq[b] ? a : b));
}

// Returns the range (max - min)
function range(nums) {
  return Math.max(nums) - Math.min(nums);
}

module.exports = { average, median, mode, range };
