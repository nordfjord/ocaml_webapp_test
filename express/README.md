```
❯ k6 run --vus 80 --duration 10s test.js

          /\      |‾‾| /‾‾/   /‾‾/
     /\  /  \     |  |/  /   /  /
    /  \/    \    |     (   /   ‾‾\
   /          \   |  |\  \ |  (‾)  |
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: test.js
     output: -

  scenarios: (100.00%) 1 scenario, 80 max VUs, 40s max duration (incl. graceful stop):
           * default: 80 looping VUs for 10s (gracefulStop: 30s)


running (10.0s), 00/80 VUs, 43404 complete and 0 interrupted iterations
default ✓ [=====================================] 80 VUs  10s

     data_received..................: 76 MB  7.5 MB/s
     data_sent......................: 4.7 MB 473 kB/s
     http_req_blocked...............: avg=8.2µs   min=0s      med=1µs     max=4.73ms   p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=3.66µs  min=0s      med=0s      max=2.32ms   p(90)=0s      p(95)=0s
     http_req_duration..............: avg=18.41ms min=654µs   med=17.22ms max=178.63ms p(90)=30.32ms p(95)=36.32ms
       { expected_response:true }...: avg=18.41ms min=654µs   med=17.22ms max=178.63ms p(90)=30.32ms p(95)=36.32ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 43404
     http_req_receiving.............: avg=11.97µs min=4µs     med=11µs    max=369µs    p(90)=14µs    p(95)=17µs
     http_req_sending...............: avg=2.59µs  min=1µs     med=2µs     max=218µs    p(90)=3µs     p(95)=4µs
     http_req_tls_handshaking.......: avg=0s      min=0s      med=0s      max=0s       p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=18.4ms  min=642µs   med=17.21ms max=178.59ms p(90)=30.31ms p(95)=36.3ms
     http_reqs......................: 43404  4334.681688/s
     iteration_duration.............: avg=18.44ms min=668.2µs med=17.24ms max=182.82ms p(90)=30.34ms p(95)=36.33ms
     iterations.....................: 43404  4334.681688/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
