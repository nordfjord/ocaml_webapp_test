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


running (10.0s), 00/80 VUs, 50055 complete and 0 interrupted iterations
default ✓ [=====================================] 80 VUs  10s

     data_received..................: 102 MB 10 MB/s
     data_sent......................: 5.5 MB 545 kB/s
     http_req_blocked...............: avg=7.52µs  min=0s       med=1µs     max=4.93ms   p(90)=1µs     p(95)=2µs
     http_req_connecting............: avg=3.4µs   min=0s       med=0s      max=2.5ms    p(90)=0s      p(95)=0s
     http_req_duration..............: avg=15.97ms min=815µs    med=13.27ms max=388.93ms p(90)=23.71ms p(95)=34.48ms
       { expected_response:true }...: avg=15.97ms min=815µs    med=13.27ms max=388.93ms p(90)=23.71ms p(95)=34.48ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 50055
     http_req_receiving.............: avg=13.84µs min=4µs      med=11µs    max=748µs    p(90)=24µs    p(95)=36µs
     http_req_sending...............: avg=2.99µs  min=1µs      med=2µs     max=715µs    p(90)=4µs     p(95)=9µs
     http_req_tls_handshaking.......: avg=0s      min=0s       med=0s      max=0s       p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=15.95ms min=799µs    med=13.25ms max=388.9ms  p(90)=23.7ms  p(95)=34.46ms
     http_reqs......................: 50055  4997.766955/s
     iteration_duration.............: avg=15.99ms min=826.75µs med=13.29ms max=388.99ms p(90)=23.77ms p(95)=34.51ms
     iterations.....................: 50055  4997.766955/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
