# No fork

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


running (1m00.3s), 00/80 VUs, 17717 complete and 0 interrupted iterations
default ✓ [======================================] 80 VUs  1m0s

     data_received..................: 4.9 GB 81 MB/s
     data_sent......................: 1.9 MB 32 kB/s
     http_req_blocked...............: avg=12.21µs  min=0s      med=1µs      max=3.33ms   p(90)=1µs      p(95)=2µs
     http_req_connecting............: avg=8.37µs   min=0s      med=0s       max=2.24ms   p(90)=0s       p(95)=0s
     http_req_duration..............: avg=271.48ms min=58.22ms med=268.22ms max=389.39ms p(90)=294.55ms p(95)=298.85ms
       { expected_response:true }...: avg=271.48ms min=58.22ms med=268.22ms max=389.39ms p(90)=294.55ms p(95)=298.85ms
     http_req_failed................: 0.00%  ✓ 0          ✗ 17717
     http_req_receiving.............: avg=279.34µs min=42µs    med=55µs     max=72.92ms  p(90)=75µs     p(95)=88µs
     http_req_sending...............: avg=4.44µs   min=1µs     med=4µs      max=151µs    p(90)=7µs      p(95)=9µs
     http_req_tls_handshaking.......: avg=0s       min=0s      med=0s       max=0s       p(90)=0s       p(95)=0s
     http_req_waiting...............: avg=271.19ms min=41.55ms med=268.15ms max=358.98ms p(90)=294.38ms p(95)=298.74ms
     http_reqs......................: 17717  293.992237/s
     iteration_duration.............: avg=271.51ms min=59.71ms med=268.24ms max=392.57ms p(90)=294.56ms p(95)=298.88ms
     iterations.....................: 17717  293.992237/s
     vus............................: 80     min=80       max=80
     vus_max........................: 80     min=80       max=80
```

# With fork

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


running (1m00.1s), 00/80 VUs, 23680 complete and 0 interrupted iterations
default ✓ [======================================] 80 VUs  1m0s

     data_received..................: 6.5 GB 108 MB/s
     data_sent......................: 2.6 MB 43 kB/s
     http_req_blocked...............: avg=10.36µs  min=0s     med=1µs      max=5.53ms p(90)=2µs      p(95)=3µs
     http_req_connecting............: avg=6.59µs   min=0s     med=0s       max=2.37ms p(90)=0s       p(95)=0s
     http_req_duration..............: avg=202.9ms  min=7.99ms med=201.83ms max=1.1s   p(90)=271.78ms p(95)=299.14ms
       { expected_response:true }...: avg=202.9ms  min=7.99ms med=201.83ms max=1.1s   p(90)=271.78ms p(95)=299.14ms
     http_req_failed................: 0.00%  ✓ 0          ✗ 23680
     http_req_receiving.............: avg=78.38µs  min=34µs   med=61µs     max=5.84ms p(90)=129µs    p(95)=163µs
     http_req_sending...............: avg=6.93µs   min=2µs    med=5µs      max=2.66ms p(90)=10µs     p(95)=14µs
     http_req_tls_handshaking.......: avg=0s       min=0s     med=0s       max=0s     p(90)=0s       p(95)=0s
     http_req_waiting...............: avg=202.82ms min=7.92ms med=201.74ms max=1.1s   p(90)=271.71ms p(95)=299.08ms
     http_reqs......................: 23680  393.795899/s
     iteration_duration.............: avg=202.95ms min=8.02ms med=201.86ms max=1.1s   p(90)=271.82ms p(95)=299.17ms
     iterations.....................: 23680  393.795899/s
     vus............................: 80     min=80       max=80
     vus_max........................: 80     min=80       max=80
```
