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


running (10.0s), 00/80 VUs, 54633 complete and 0 interrupted iterations
default ✓ [=====================================] 80 VUs  10s

     data_received..................: 112 MB 11 MB/s
     data_sent......................: 6.0 MB 595 kB/s
     http_req_blocked...............: avg=7.22µs  min=0s       med=1µs     max=5.06ms   p(90)=1µs     p(95)=2µs
     http_req_connecting............: avg=3.23µs  min=0s       med=0s      max=2.66ms   p(90)=0s      p(95)=0s
     http_req_duration..............: avg=14.62ms min=494µs    med=12.02ms max=153.25ms p(90)=26.23ms p(95)=32.88ms
       { expected_response:true }...: avg=14.62ms min=494µs    med=12.02ms max=153.25ms p(90)=26.23ms p(95)=32.88ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 54633
     http_req_receiving.............: avg=13.63µs min=4µs      med=11µs    max=368µs    p(90)=23µs    p(95)=34µs
     http_req_sending...............: avg=2.96µs  min=1µs      med=2µs     max=260µs    p(90)=4µs     p(95)=9µs
     http_req_tls_handshaking.......: avg=0s      min=0s       med=0s      max=0s       p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=14.61ms min=484µs    med=12ms    max=153.23ms p(90)=26.21ms p(95)=32.86ms
     http_reqs......................: 54633  5456.548612/s
     iteration_duration.............: avg=14.64ms min=504.91µs med=12.03ms max=153.26ms p(90)=26.26ms p(95)=32.91ms
     iterations.....................: 54633  5456.548612/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
