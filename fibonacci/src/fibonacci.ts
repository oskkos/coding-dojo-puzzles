function fibonacci(prev: number, current: number): number {
  return prev + current;
}

const rounds = parseInt(process.argv[2] ?? 10);
let prev = 0;
let current = 1;
for (let i = 0; i < rounds; i++) {
  console.log(current);
  [prev, current] = [current, fibonacci(prev, current)];
}
