```
❯ k6 run --vus 80 --duration 60s  test.js

          /\      |‾‾| /‾‾/   /‾‾/
     /\  /  \     |  |/  /   /  /
    /  \/    \    |     (   /   ‾‾\
   /          \   |  |\  \ |  (‾)  |
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: test.js
     output: -

  scenarios: (100.00%) 1 scenario, 80 max VUs, 1m30s max duration (incl. graceful stop):
           * default: 80 looping VUs for 1m0s (gracefulStop: 30s)


running (1m00.1s), 00/80 VUs, 26189 complete and 0 interrupted iterations
default ✓ [======================================] 80 VUs  1m0s

     data_received..................: 6.9 GB 114 MB/s
     data_sent......................: 2.9 MB 48 kB/s
     http_req_blocked...............: avg=9.05µs   min=0s     med=1µs      max=3.14ms p(90)=2µs      p(95)=2µs
     http_req_connecting............: avg=5.69µs   min=0s     med=0s       max=2.12ms p(90)=0s       p(95)=0s
     http_req_duration..............: avg=183.47ms min=4.22ms med=166.87ms max=1.31s  p(90)=377.42ms p(95)=451.55ms
       { expected_response:true }...: avg=183.47ms min=4.22ms med=166.87ms max=1.31s  p(90)=377.42ms p(95)=451.55ms
     http_req_failed................: 0.00%  ✓ 0          ✗ 26189
     http_req_receiving.............: avg=75.98µs  min=33µs   med=60µs     max=2.36ms p(90)=119µs    p(95)=158µs
     http_req_sending...............: avg=5.72µs   min=1µs    med=4µs      max=6.21ms p(90)=8µs      p(95)=12µs
     http_req_tls_handshaking.......: avg=0s       min=0s     med=0s       max=0s     p(90)=0s       p(95)=0s
     http_req_waiting...............: avg=183.39ms min=4.15ms med=166.77ms max=1.31s  p(90)=377.35ms p(95)=451.44ms
     http_reqs......................: 26189  435.438361/s
     iteration_duration.............: avg=183.51ms min=4.24ms med=166.9ms  max=1.32s  p(90)=377.43ms p(95)=451.57ms
     iterations.....................: 26189  435.438361/s
     vus............................: 80     min=80       max=80
     vus_max........................: 80     min=80       max=80
```
