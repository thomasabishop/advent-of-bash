const path = require("path");
const fs = require("fs");

const SHAPES = {
  A: 1,
  X: 1,
  B: 2,
  Y: 2,
  C: 3,
  Z: 3,
};

const input = fs
  .readFileSync("/home/thomas/repos/advent_of_bash/02/test-input.txt", "utf-8")
  .toString()
  .trim()
  .split("\n")
  .map((v) => v.split(" "));

module.exports = {
  input,
  SHAPES,
};
