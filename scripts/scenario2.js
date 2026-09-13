import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
  stages: [
    { duration: '2m', target: 500 },
    { duration: '2m', target: 500 },
    { duration: '1m', target: 0 },
  ],
};

export default function () {
  const res = http.get(__ENV.TARGET_URL);
  check(res, { 'status 200': (r) => r.status === 200 });
  sleep(1);
}
