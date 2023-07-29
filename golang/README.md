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


running (10.0s), 00/80 VUs, 58522 complete and 0 interrupted iterations
default ✓ [========================] 80 VUs  10s

     data_received..................: 187 MB 19 MB/s
     data_sent......................: 6.4 MB 637 kB/s
     http_req_blocked...............: avg=6.29µs  min=0s       med=0s      max=4.86ms   p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=2.66µs  min=0s       med=0s      max=2.17ms   p(90)=0s      p(95)=0s
     http_req_duration..............: avg=13.65ms min=557µs    med=11.03ms max=495.49ms p(90)=16.5ms  p(95)=27.38ms
       { expected_response:true }...: avg=13.65ms min=557µs    med=11.03ms max=495.49ms p(90)=16.5ms  p(95)=27.38ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 58522
     http_req_receiving.............: avg=10.29µs min=4µs      med=9µs     max=954µs    p(90)=14µs    p(95)=17µs
     http_req_sending...............: avg=2.51µs  min=1µs      med=2µs     max=2.39ms   p(90)=3µs     p(95)=4µs
     http_req_tls_handshaking.......: avg=0s      min=0s       med=0s      max=0s       p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=13.64ms min=546µs    med=11.02ms max=495.46ms p(90)=16.49ms p(95)=27.37ms
     http_reqs......................: 58522  5845.027567/s
     iteration_duration.............: avg=13.67ms min=568.04µs med=11.04ms max=499.86ms p(90)=16.52ms p(95)=27.39ms
     iterations.....................: 58522  5845.027567/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
