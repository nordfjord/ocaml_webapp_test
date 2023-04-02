to run the test with ocaml:

```sh
dune exec ./bin/main.exe
k6 run --vus 10 --duration 10s test.js
```

to run the test with node:

```sh
cd ./express
pnpm i
node index.js
k6 run --vus 10 --duration 10s ./test.js
```
