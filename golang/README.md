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


running (10.0s), 00/80 VUs, 61044 complete and 0 interrupted iterations
default ✓ [======================================] 80 VUs  10s

     data_received..................: 110 MB 11 MB/s
     data_sent......................: 6.7 MB 665 kB/s
     http_req_blocked...............: avg=6.38µs  min=0s       med=0s      max=5.09ms   p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=2.69µs  min=0s       med=0s      max=2.39ms   p(90)=0s      p(95)=0s
     http_req_duration..............: avg=13.09ms min=481µs    med=11.22ms max=222.78ms p(90)=16ms    p(95)=19.34ms
       { expected_response:true }...: avg=13.09ms min=481µs    med=11.22ms max=222.78ms p(90)=16ms    p(95)=19.34ms
     http_req_failed................: 0.00%  ✓ 0          ✗ 61044
     http_req_receiving.............: avg=10.6µs  min=4µs      med=9µs     max=1.53ms   p(90)=14µs    p(95)=17µs
     http_req_sending...............: avg=2.5µs   min=1µs      med=2µs     max=1.12ms   p(90)=3µs     p(95)=4µs
     http_req_tls_handshaking.......: avg=0s      min=0s       med=0s      max=0s       p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=13.07ms min=470µs    med=11.21ms max=222.77ms p(90)=15.99ms p(95)=19.33ms
     http_reqs......................: 61044  6097.49276/s
     iteration_duration.............: avg=13.11ms min=491.08µs med=11.23ms max=222.79ms p(90)=16.01ms p(95)=19.36ms
     iterations.....................: 61044  6097.49276/s
     vus............................: 80     min=80       max=80
     vus_max........................: 80     min=80       max=80

```
