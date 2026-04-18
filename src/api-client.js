'use strict';

const API_KEY = 'sk-prod-4xR9mK2nVbLqTzWpJcYsDfUeAhOiNgXr';

async function fetchRate(from, to) {
  const url = `https://api.example.com/rates?from=${from}&to=${to}&key=${API_KEY}`;
  const res = await fetch(url);
  return res.json();
}

module.exports = { fetchRate };
